Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSHNXMq>; Wed, 14 Aug 2002 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSHNXMq>; Wed, 14 Aug 2002 19:12:46 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:9481 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S315923AbSHNXMp>; Wed, 14 Aug 2002 19:12:45 -0400
Date: Thu, 15 Aug 2002 09:53:31 +1200 (NZST)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: framebuffer corruption
Message-ID: <Pine.LNX.4.21.0208150945360.1761-100000@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.31, VESA framebuffer, 1280x1024x16, SiS5597 chipset, 3Mb shared 
video memory from a pool of 32Mb main memory (yuck).


When changing virtual consoles, I notice the contents of the screen shift up
about two text lines (unsure of exact amount), and it doesn't reset itself
until the screen has a reason to scroll.  A ^L (clear) doesn't reset the
screen, though I notice that if I hit <Enter> at the bottom of the screen,
that seems to do the trick.  It's like the kernel is aiming for a refresh, but
not quite getting the location right, though another console scroll seems to
do the trick.

Something else that might be related is that I have spot corruption of various
characters (only the occasional one) - like, one of my 's' looks like a cross
between an o, an s, and an e - the character two spaces before is supposed to
be blank, but looks like it has the first part of an o.  Wierd. These clear 
when I change the screen in appreciable manner, such as a program close (pine).

I'm noticing the refreshes look REALLY wierd every few lines or so - like the 
refresh has been shifted a few lines up, then it resets itself - things look 
REALLY jumpy.

Anyway, I'll send this off.

-- 
 /|   _,.:*^*:.,   |\           Cheers from the Viking family, 
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!


