Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTJMGGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 02:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTJMGGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 02:06:12 -0400
Received: from dsl-46020.solcon.nl ([212.45.46.20]:62383 "HELO taos-it.nl")
	by vger.kernel.org with SMTP id S261473AbTJMGGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 02:06:08 -0400
Subject: Re: 2.6.0-test7 vs. vga= boot parameter
From: "M. Lucas" <m.lucas@taos-it.nl>
Reply-To: m.lucas@taos-it.nl
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <316c01c39147$8e019600$5cee4ca5@DIAMONDLX60>
References: <316c01c39147$8e019600$5cee4ca5@DIAMONDLX60>
Content-Type: text/plain
Organization: TAOS-IT
Message-Id: <1066024998.12028.8.camel@orion.taos-it.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 13 Oct 2003 08:04:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-13 at 07:03, Norman Diamond wrote:
> On a machine with unknown graphics chip and a 1024x768 screen,
> 2.4.18 and 2.6.0-test1 through test7 can all be booted with
> vga=791 and have no problem.
> 
> On a machine with a Neomagic 128XD chip and an 800x600 screen,
> 2.4.19 and 2.4.20 can be booted with vga=788 and have no problem.
> But booting 2.6.0-test1 through test7 with vga=788 yields a
> black screen during boot and disables all text mode displays
> in VT consoles.  After X11 starts up, switching to a VT just
> displays whatever was last put in graphics memory by X11 and
> does not change until I switch back to X11.
> 
> Booting 2.6.0-test1 through test7 without any vga option has
> no problem displaying boot messages, and after X11 starts up,
> it has no problem switching between X11 and VT consoles.
> 
> This part of dmesg might be relevant to the vga problem in test7.
> vesafb seems to say it aborted and then succeeded, but maybe it
> aborted and went crazy instead?
> 
> neofb: mapped io at c6800000
> Autodetected internal display
> Panel is a 800x600 color TFT display
> neofb: mapped framebuffer at c6a01000
> neofb v0.4.1: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
> fb0: MagicGraph 128XD frame buffer device
> vesafb: abort, cannot reserve video memory at 0x43000000
> vesafb: framebuffer at 0x43000000, mapped to 0xc6c02000, size 1984k
> vesafb: mode is 800x600x16, linelength=1600, pages=1
> vesafb: protected mode interface info at c000:8cb0
> vesafb: scrolling: redraw
> vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
> fb1: VESA VGA frame buffer device
> -

I had the same problems with all the 2.6 test versions and the vga=
bootoption.

I didn't find out what the cause was of this problem, but using the
following line video=matroxfb:vesa:0x118,depth=32 did work on my matrox
card.

This way I don't have to use the vga= line.

Hope this helps you.

Maurice Lucas

