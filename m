Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269994AbTHOQZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269542AbTHOQN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:27 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267274AbTHOQJn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:43 -0400
Date: Fri, 15 Aug 2003 16:20:08 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: Problem with framebuffer in 2.6.0-test3
Message-ID: <20030815142008.GA22123@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I compile with framebuffer I get weird results during boot.

When I use "vga=normal", I get this weird screen during boot.
It doesn't show any text.  It just lots of coloured pixels.

When I use "vga=0x301" I just get a blank screen during boot.

In the init scripts I call fbset to set the proper resolution,
which work in both cases.


Here is part of my .config:
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_3DFX=y
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

>From dmesg (with vga=0x301)
Linux version 2.6.0-test3 (root@Q) (gcc version 2.95.3 20010315
(release)) #6 Mon Aug 11 19:47:08 CEST 2003
Video mode to be used for restore is 301
...
Console: colour dummy device 80x25
...
fb: 3Dfx Banshee memory = 16384K
vesafb: abort, cannot reserve video memory at 0xe6000000
vesafb: framebuffer at 0xe6000000, mapped to 0xcf802000, size
16384k
vesafb: mode is 640x480x8, linelength=640, pages=53
vesafb: protected mode interface info at c000:7e95
vesafb: scrolling: redraw
fb1: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb2: VGA16 VGA frame buffer device
Console: switching to colour frame buffer device 80x30


With vga=normal
Linux version 2.6.0-test3 (root@Q) (gcc version 2.95.3 20010315
(release)) #6 Mon Aug 11 19:47:08 CEST 2003
Aug 11 20:13:45 Q kernel: Video mode to be used for restore is f00
...
Console: colour VGA+ 80x25
...
fb: 3Dfx Banshee memory = 16384K
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
Console: switching to colour frame buffer device 80x30


Kurt

