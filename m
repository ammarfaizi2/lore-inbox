Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTJMFFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 01:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTJMFFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 01:05:37 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:17145 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S261406AbTJMFFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 01:05:35 -0400
Message-ID: <316c01c39147$8e019600$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test7 vs. vga= boot parameter
Date: Mon, 13 Oct 2003 14:03:05 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with unknown graphics chip and a 1024x768 screen,
2.4.18 and 2.6.0-test1 through test7 can all be booted with
vga=791 and have no problem.

On a machine with a Neomagic 128XD chip and an 800x600 screen,
2.4.19 and 2.4.20 can be booted with vga=788 and have no problem.
But booting 2.6.0-test1 through test7 with vga=788 yields a
black screen during boot and disables all text mode displays
in VT consoles.  After X11 starts up, switching to a VT just
displays whatever was last put in graphics memory by X11 and
does not change until I switch back to X11.

Booting 2.6.0-test1 through test7 without any vga option has
no problem displaying boot messages, and after X11 starts up,
it has no problem switching between X11 and VT consoles.

This part of dmesg might be relevant to the vga problem in test7.
vesafb seems to say it aborted and then succeeded, but maybe it
aborted and went crazy instead?

neofb: mapped io at c6800000
Autodetected internal display
Panel is a 800x600 color TFT display
neofb: mapped framebuffer at c6a01000
neofb v0.4.1: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
fb0: MagicGraph 128XD frame buffer device
vesafb: abort, cannot reserve video memory at 0x43000000
vesafb: framebuffer at 0x43000000, mapped to 0xc6c02000, size 1984k
vesafb: mode is 800x600x16, linelength=1600, pages=1
vesafb: protected mode interface info at c000:8cb0
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb1: VESA VGA frame buffer device
