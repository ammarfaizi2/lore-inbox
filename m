Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285506AbRLNVfh>; Fri, 14 Dec 2001 16:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbRLNVf2>; Fri, 14 Dec 2001 16:35:28 -0500
Received: from out1.prserv.net ([32.97.166.31]:36743 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S285506AbRLNVfY>;
	Fri, 14 Dec 2001 16:35:24 -0500
Message-ID: <3C1A709E.943034DE@mail.com>
Date: Fri, 14 Dec 2001 15:35:26 -0600
From: Brian Horton <go_gators@mail.com>
X-Mailer: Mozilla 4.79 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to debug a deadlock'ed kernel?
In-Reply-To: <Pine.LNX.4.40.0112111822060.13893-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, the nmi_watchdog option didn't work, but I was able to get
information I needed with kdb!

thx!  .bri.

Oliver Xymoron wrote:
> 
> On Tue, 11 Dec 2001, Brian Horton wrote:
> 
> > Thanks, I'll try the nmi_watchdog option out. It appears to not be in
> > the 2.2.14 kernel, but is in a 2.2.19 kernel that I have from RedHat.
> 
> It's there by default in SMP, you just have to enable it with
> nmiwatchdog=1 at boot (or something). I didn't mention it because it
> probably won't help your problem: as you can use the magic sysrq keys to
> reboot, you are not deadlocked with interrupts off, therefore the timer
> interrupt will keep the NMI watchdog from ever firing. NMI watchdog is
> mostly of use when you can't even get the capslock light to toggle..
> 
> > > > Anyone got any good tips on how to debug a SMP system that is locked up
> > > > in a deadlock situation in the kernel? I'm working on a kernel module,
> > > > and after some number of hours of stress testing, the box locks up. None
> > > > of the sysrq options show anything on the display, though the reBoot
> > > > option does reboot the system. RedHat 6.2 and its 2.2.14 kernel. Doesn't
> > > > hang for me on 2.4, so I need to debug it here...
> 
> --
>  "Love the dolphins," she advised him. "Write by W.A.S.T.E.."
