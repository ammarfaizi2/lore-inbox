Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUHVEuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUHVEuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 00:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUHVEuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 00:50:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:27533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266129AbUHVEuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 00:50:16 -0400
Date: Sat, 21 Aug 2004 21:48:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Davis <tadavis@lbl.gov>
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.6.8.1-mm3
Message-Id: <20040821214824.4bf5e6fd.akpm@osdl.org>
In-Reply-To: <412821C4.7060402@lbl.gov>
References: <20040820031919.413d0a95.akpm@osdl.org>
	<412821C4.7060402@lbl.gov>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Davis <tadavis@lbl.gov> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/
> > 
> > - Added three more bk trees:
> > 
> > 	bk-fb:		Some ARM framebuffer driver (rmk)
> > 	bk-mmc:		ARM-specific media drivers(?)
> > 	bk-watchdog:	watchdog drivers
> > 
> > - I'm totally unclear on what's happening with the release_task
> >   sleep-while-atomic bug, and with the CPU hotplug BUG.  This kernel will
> >   probably emit might_sleep warnings.  Turn off CONFIG_PREEMPT if it gets
> >   irritating.
> > 
> > - Added Nick Piggin's CPU scheduler to see what happens.  See inside the
> >   patch for details.  Please test, benchmark, report.
> > 
> > - This is (very) lightly tested.  Mainly a resync with various parties.
> > 
> 
> Not sure what does what - I'm in the process of going back to 2.6.8.1, and see if any of this goes away..
> 
> 1) the ub device kills my SanDisk 8 in 1 reader (SDDR-88)  I have to yank it out of the USB port to fix it.  fixed by removing the UB device from my config outright.

Hi, Pete.

> 2) do not try to modprobe -r ub; it will do wonky things to your machine (I tried in a KDE Konsole, and lost the keyboard, and the terminal just scrolled blank lines..)

Hi, Pete.

> 3) Interactivity performance when compiling a kernel (make rpm) sucks.  I have a Dell Poweredge 400SC, with a Hyper threaded P4/1GB of ram, ATI Radeon 9600 based video.  Load average jumps to the 4's, and stays there - while each cpu in the hyper thread shows about 50% idle time.  Mouse pointer jumps all over the place, mouse clicks are lost, menus are slow to drop down, etc..

Ingo found a ghastly performance problem with X, but that'll be present in
2.6.8.1 as well.
