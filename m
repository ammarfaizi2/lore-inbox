Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUBCKDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUBCKDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:03:24 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:27140 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265956AbUBCKDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:03:21 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1075802128@astro.swin.edu.au>
Subject: Console off by one error: (Was Re: Cursor disappears on console, no frame-buffer)
In-reply-to: <Pine.LNX.4.53.0401290000090.7071@tellurium.ssi.swin.edu.au>
References: <slrn-0.9.7.4-26788-30547-200401282138-tc@hexane.ssi.swin.edu.au> <200401281356.52102.ender@debian.org> <Pine.LNX.4.53.0401290000090.7071@tellurium.ssi.swin.edu.au>
X-Face: A>QmH)/u`[d}b.a5?Xq=L&d?Q}cF5x|wu#O_mAK83d(Tw,BjxX[}n4<13.e$"d!Gg(I%n8fL)I9fZ$0,8s3_5>iI]4c%FXg{CpVhuIuyI,W'!5Cl?5M,dL-*dHYs}K9=YQZCN-\2j1S>cU6XPXsQhz$x`M\ZEV}nPw'^jPc41FiwTQZ'g)xNK{2',](o5mrODBHe))
Message-ID: <slrn-0.9.7.4-28141-6988-200402032055-tc@hexane.ssi.swin.edu.au>
Date: Tue, 3 Feb 2004 21:03:17 +1100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors <tconnors+linuxkml@astro.swin.edu.au> said on Thu, 29 Jan 2004 00:02:07 +1100 (EST):
> On Wed, 28 Jan 2004, David [iso-8859-15] Martínez Moreno wrote:
> > El Miércoles, 28 de Enero de 2004 11:46, Tim Connors escribió:
> > > Recently, a few kernel revisions ago, I experimented with the
> > > frame-buffer. I don't know what I broke, but with nothing frame-buffer
> > > related in the kernel (It could have been broken for a long time, I
> > > don't use the console that much, but it certainly worked at one
> > > stage):
> 
> 2.4.23 originally, still a problem in 25-pre7.

More info: Seems there is an off by one error

I can manage to refresh the cursor position by flicking to another VT
and back. When the cursor reaches the bottom of the screen, for every
line output, the cursor moves further "down". So when I reset the cursor
position with a ctrl-l or go to some cursor position within an ncurses
app, then the cursor is now n lines below where it should be, where n
is how many lines were output once the cursor got to the bottom of the
screen.

I mentioned that I don't have the frame-buffer on. I removed all
references to svgalib from my debian sid install, and boot lilo with
the text menu, rather than the graphic logo. dmesg says there are no
strange args passed to the kernel:

Kernel command line: auto BOOT_IMAGE=linux ro root=303 hdc=ide-scsi

kernel build was 
Linux version 2.4.25-pre7 (root@scuzzie) (gcc version 3.3.3 20040110
(prerelease) (Debian)) #1 Wed Jan 28 18:42:00 EST 2004

Despite there being no framebuffer, when the cursor is hanging around
the bottom of the screen, the bottom of the display flashes blue - I
don't recall this happening until recently.

This is all on a Dell Inspiron 4000 laptop, with a Rage 128 Mobility
M3 video card.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
A new verb was accidently created during a discussion about KDE 3 and Debian.
It was said that KDE 3 will sid soon. -- Debian Weekly News Jan 14,2003 
