Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVK1NUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVK1NUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVK1NUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:20:25 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:8335 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932093AbVK1NUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:20:25 -0500
Date: Mon, 28 Nov 2005 14:20:35 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Marc Koschewski <marc@osknowledge.org>,
       "Calin A. Culianu" <calin@ajvar.org>, akpm@osdl.org, adaplas@pol.net,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: nvidia fb flicker
Message-ID: <20051128132035.GA7265@stiffy.osknowledge.org>
References: <Pine.LNX.4.64.0511252358390.25302@rtlab.med.cornell.edu> <20051128103554.GA7071@stiffy.osknowledge.org> <438AF8A2.6030403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438AF8A2.6030403@gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc1-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Antonino A. Daplas <adaplas@gmail.com> [2005-11-28 20:31:30 +0800]:

> Marc Koschewski wrote:
> > * Calin A. Culianu <calin@ajvar.org> [2005-11-26 00:02:46 -0500]:
> > 
> >> Hi,
> >>
> >> This patch can be applied against 2.6.15-rc1 to add support to the 
> >> nvidiafb driver for a few obscure (yet on-the-market) nvidia 
> >> boards/chipsets, including various versions of the Geforce 6600 and 6200.
> >>
> >> This patch has been tested and allows the above-mentioned boards to get 
> >> framebuffer console support.
> >>
> >> Thanks!
> >>
> >> -Calin
> > 
> > Hi all,
> > 
> > yesterday I compiled a 2.6.15-rc2 on one of my Inspirons (NVIDIA GeForce2 Go)
> > with nvidiafb. I just changed the fb to some 1600x1200 mode and thus seems to
> > work (the source states GeForce2 Go is supported and known). However, the
> > letters seems to 'flicker' in some way. Uhm, it's not really flickering, it's
> > more like the sinle dots a letter is made of seem to randomly turn on an off. I
> 
> Can you try booting with video=nvidiafb:1600x1200MR@60?
> 
> If that still does not work, can you open drivers/video/fbmon.c then change
> the line #undef DEBUG to #define DEBUG, recompile, reboot and post your
> dmesg?
> 
> > one takes a closer look it seems like the whole screen is 'fluent' or something.
> > Does anybody know how to handle that? I didn't specify a video mode, but
> > 'video=vesafb:mtrr:3'. 
> > 
> 
> No, remove any vga= and video=vesafb: strings in your boot options.

So, I just booted with the parameter given by you (and without vga= as usual), as
well as without any parameter. No change though.

Here's my relevant messages stuff with DEBUG enabled:

Nov 28 14:02:31 stiffy kernel: nvidiafb: nVidia device/chipset 10DE0112
Nov 28 14:02:31 stiffy kernel: nvidiafb: EDID found from BUS2
Nov 28 14:02:31 stiffy kernel: ========================================
Nov 28 14:02:31 stiffy kernel: Display Information (EDID)
Nov 28 14:02:31 stiffy kernel: ========================================
Nov 28 14:02:31 stiffy kernel:    EDID Version 1.3
Nov 28 14:02:31 stiffy kernel:    Manufacturer: SHP
Nov 28 14:02:31 stiffy kernel:    Model: 138e
Nov 28 14:02:31 stiffy kernel:    Serial#: 0
Nov 28 14:02:31 stiffy kernel:    Year: 1990 Week 0
Nov 28 14:02:31 stiffy kernel:    Display Characteristics:
Nov 28 14:02:32 stiffy kernel:       Monitor Operating Limits:    Detailed Timings
Nov 28 14:02:32 stiffy kernel:       160 MHz 1600 1664 1856 2112 1200 1201 1204 1250 -HSync -VSync
Nov 28 14:02:32 stiffy kernel: 
Nov 28 14:02:32 stiffy kernel:    Supported VESA Modes
Nov 28 14:02:32 stiffy kernel:       Manufacturer's mask: 0
Nov 28 14:02:32 stiffy kernel:    Standard Timings
Nov 28 14:02:32 stiffy kernel:       1600x1200@60Hz
Nov 28 14:02:32 stiffy kernel: Extrapolated
Nov 28 14:02:32 stiffy kernel:            H: 75-75KHz V: 60-60Hz DCLK: 162MHz
Nov 28 14:02:32 stiffy kernel:       Digital Display Input

Marc
