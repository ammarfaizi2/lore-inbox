Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVJEGzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVJEGzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 02:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVJEGzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 02:55:43 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:1783 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932554AbVJEGzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 02:55:43 -0400
Date: Wed, 5 Oct 2005 02:54:14 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Chase Venters <chase.venters@clientec.com>
cc: Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <200510041840.55820.chase.venters@clientec.com>
Message-ID: <Pine.LNX.4.58.0510050242170.20622@localhost.localdomain>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com>
 <200510041840.55820.chase.venters@clientec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Oct 2005, Chase Venters wrote:

> As for error messages... the equivalent of the Linux kernel panic is basically
> the Windows BSOD. Neither one of them should appear in the day to day use of
> the system as they indicate bugs. Linux is actually the clear winner here, I
> think, because a Windows BSOD gives you a single hex code and no indication
> of what happened, except for very vague codes like
> "PAGE_FAULT_IN_NON_PAGED_AREA". I'd much rather have a backtrace :) In any
> case, I'm watching the work on kdump with a keen interest.
>

And what about kexec?  To be able to boot into another kernel on a kernel
bug and still have access to all the memory and the system state of the
bug.  That's pretty cool.  It would be like Windows going straight to
Safe-Mode on a BSOFD without a reboot.

> In any case, I think pretty much all of this work lives outside the kernel.
> There is one side note I'd make about booting - my own boot process has to
> wait forever for my Adaptec SCSI controller to wake up. It would be
> interesting if bootup initialization tasks could be organized into dependency
> levels and run in parallel, though as I'm a beginner to the workings of the
> kernel I'm not entirely sure how possible this would be.
>

I've been thinking of at least trying to see what would happen if I
threaded the do_initcalls in main.c but lately I haven't had the time.

-- Steve

