Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261198AbRGGB3D>; Fri, 6 Jul 2001 21:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbRGGB2x>; Fri, 6 Jul 2001 21:28:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:49932 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S264499AbRGGB2r>;
	Fri, 6 Jul 2001 21:28:47 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.26020.902385.697947@cargo.ozlabs.ibm.com>
Date: Sat, 7 Jul 2001 11:28:04 +1000 (EST)
To: "Tim McDaniel" <tim.mcdaniel@tuxia.com>
Cc: <linux-ppc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Trouble Booting Linux PPC On Mac G4 2000
In-Reply-To: <A16915712C18BD4EBD97897F82DA08CD409EEE@exchange1.win.agb.tuxia>
In-Reply-To: <A16915712C18BD4EBD97897F82DA08CD409EEE@exchange1.win.agb.tuxia>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim McDaniel writes:

> We are having a great degree of difficulty getting Linux PPC20000
> running on a Mac G4 466 tower with 128MB of memory, One 30MB HD and one
> CR RW. This is not a NuBus based system. To the best of our knowledge we
> have followed the user manual to the tee, and even tried forcing video
> settings at the Xboot screen.   

One possible problem is that many Apple monitors only work at a fixed
horizontal frequency - the Apple Studio 17 monitor (with the
transparent case) that I use with my G4 cube is like that, it will
only operate at horizontal scan rates between 79 and 82 kHz.  If the
kernel video driver chooses a video mode with a scan rate outside that
range the screen goes black.  So I have to put video=aty128fb:vmode:20
on the kernel command line to avoid that.  (It would be nice if the
kernel driver did DDC but it doesn't.)

Other than that, you might get more useful suggestions if you ask on
the linuxppc-user@lists.linuxppc.org mailing list.

Paul.
