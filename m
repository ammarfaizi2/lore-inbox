Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWCWN5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWCWN5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWCWN5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:57:47 -0500
Received: from rtr.ca ([64.26.128.89]:53992 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932093AbWCWN5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:57:46 -0500
Message-ID: <4422A959.9030700@rtr.ca>
Date: Thu, 23 Mar 2006 08:57:45 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16 Regression:  vbetool:  Error: something went wrong performing
 real mode call
References: <4422A340.2080104@rtr.ca>
In-Reply-To: <4422A340.2080104@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> As of 2.6.16, I am seeing this message when I do suspend-to-RAM
> from a text window:
> 
> Error: something went wrong performing real mode call
> 
> I've narrowed it down to coming from "vbetool post"
> on resume from RAM.

Mmm.. looking more closely, it's a vm86 (old) call failing,
and I seem to be missing CONFIG_VM86 from my .config.

Will rebuild / retest.

Cheers
