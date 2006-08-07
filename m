Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWHGF4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWHGF4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWHGF4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:56:24 -0400
Received: from gw.goop.org ([64.81.55.164]:26027 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751092AbWHGF4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:56:23 -0400
Message-ID: <44D6D60E.5080507@goop.org>
Date: Sun, 06 Aug 2006 22:56:30 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
References: <1154925835.21647.29.camel@localhost.localdomain>	<1154925943.21647.32.camel@localhost.localdomain>	<1154926048.21647.35.camel@localhost.localdomain> <200608070739.33428.ak@muc.de>
In-Reply-To: <200608070739.33428.ak@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 07 August 2006 06:47, Rusty Russell wrote:
>   
>> This patch does the dumbest possible replacement of paravirtualized
>> instructions: calls through a "paravirt_ops" structure.  Currently
>> these are function implementations of native hardware: hypervisors
>> will override the ops structure with their own variants.
>>     
>
> You should call it HAL - that would make it clearer what it is.
>   

I've always found the term "HAL" to be vague to the point of 
meaningless.  What would it mean in this case:  "hypervisor abstraction 
layer"?  It certainly doesn't attempt abstract all hardware.

> I think I would prefer to patch always. Is there a particular
> reason you can't do that?
>   

Some calls just don't need patching; an indirect call is fast enough, 
and simple.  But I can't think of a good reason to not patch patchable 
calls, other than for debugging perhaps (easier to place one breakpoint 
than one per inline site).

    J
