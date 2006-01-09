Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWAIS2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWAIS2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWAIS2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:28:09 -0500
Received: from smtp-9.smtp.ucla.edu ([169.232.48.137]:27825 "EHLO
	smtp-9.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S964918AbWAIS2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:28:07 -0500
Date: Mon, 9 Jan 2006 10:28:01 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Roberto Nibali <ratz@drugphish.ch>
cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <43BF8785.2010703@drugphish.ch>
Message-ID: <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local>
 <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org>
 <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Roberto Nibali wrote:

>>> After a little more than one day up with 2.4.32 SMP+ACP+aic7xxx, I got 
>>> another bad pmd and an oops this morning at 4:23am.  I'm going to boot 
>>> vanilla 2.4.32 with nosmp and acpi=off.
>
> Your oops does not make much sense, could you enable following, please:
>
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_SLAB=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_FRAME_POINTER=y

kernel, sysrq, and frame_pointer were already enabled.  I'll enable 
debug_slab, as well.

>> booting with "nosmp acpi=off" did not help.  The box hung as before, at
>
> Could you boot with pci=noacpi and report again? The difference is that 
> ACPI will still be used but not for IRQ routing. I have a few boxes out 
> with 2.4.x kernels and Adaptec HBAs that need this to work reliably.

Are you interested in results from "pci=noacpi" by itself or in 
conjunction with nosmp?

> What's the SCSI BIOS version?

The SCSI controller is an onboard AIC 7899 (in a Dell PowerEdge 2650), and 
reports itself as "25309".

> What's the diff between /proc/interrupt and lspci -v on those kernels, 
> when they've finished the booting sequence?

> If you find time, send me your BIOS settings and your .config in private 
> email. I didn't track this thread from the beginning, so I don't know if 
> you've already done this.

<http://hashbrown.cts.ucla.edu/pub/oops-200512/> has the .config, lspci 
-v, and /proc/interrupts for 2.6.14.4 and 2.4.32.


-Chris
