Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132696AbRDOQli>; Sun, 15 Apr 2001 12:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132699AbRDOQl3>; Sun, 15 Apr 2001 12:41:29 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:19913 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132696AbRDOQlO>; Sun, 15 Apr 2001 12:41:14 -0400
Date: Sun, 15 Apr 2001 09:40:47 -0700 (PDT)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
Message-ID: <Pine.LNX.4.31.0104150915320.984-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [One of the things for 2.5 is 15- or 31-bit keycodes.
> The 7-bits we have today do no longer suffice. I have a 132-key keyboard.]

Or for 2.5.X you could use EVIOCGKEYCODE or EVIOCSKEYCODE using
/dev/eventX. Also the input api supports up to 220 different keys and
could support up to 255. If you app needs to use a large keycode space
then use this instead. Its better to use this interface especially
for embedded systems that have only a serial console, but sometimes
we need to use a regular keyboard. Consider for example a hand held iPAQ.
Usually their is no keyboard attached. Here you have a graphical interface
(using framebuffer) and a touch screen. So here I like to have a kernel
that uses fbdev without the VT console system and input drivers to
interface with the device. Debugging can be done by the serial console.
If I attach a keyboard I like to be able to use it without having to have
a console system needing to be built in. Remember every byte of space
counts. Getting keycode via the console layer should eventually be
replaced by this approach.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

