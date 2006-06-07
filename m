Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWFGJIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWFGJIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWFGJIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:08:39 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:38028 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932075AbWFGJIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 05:08:38 -0400
Message-ID: <44869794.9080906@drzeus.cx>
Date: Wed, 07 Jun 2006 11:08:36 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
CC: Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx>	 <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx>
In-Reply-To: <4484B5AE.8060404@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Pierre Ossman wrote:
>> Matt Reimer wrote:
>>> I suspect that a lot of these readers are broken, assuming 512 byte
>>> blocks.
>>>
>> That's what I thought until I looked closer at the Sandisk specs. Until
>> we can see what the official specs say, we won't really know what the
>> correct behaviour is. The Nokia boys working on the 770 have a copy.
>> Perhaps someone here knows how to get in touch with one of them that can
>> have a look?
>>
> 
> With the help of Khasim Syed, who happens to have access to the MMC
> spec, we now know what's in the spec. Unfortunately, what's in there is
> the same text that's in Russell's card specs, which state that only
> WRITE_BL_LEN is supported.
> 

New information. Version 4.2 of the MMC spec changes the wording to this:

* WRITE_BL_LEN
Block length for write operations. See READ_BL_LEN for field coding.
Note that the support for 512B write access is mandatory for all cards.

Similar wording for READ_BL_LEN, but that isn't of interest to us.

Rgds
Pierre

