Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVBCFUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVBCFUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVBCFUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:20:08 -0500
Received: from smtp.loomes.de ([212.40.161.2]:36538 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S262338AbVBCFTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:19:50 -0500
Subject: Re: Linux 2.6.11-rc3 - BT848 no signal
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 06:19:47 +0100
Message-Id: <1107407987.2097.18.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 18:35 -0800, Linus Torvalds wrote:

> I'd _really_ like to calm down for a final 2.6.11 now, so please note 
> anything really important I missed, but keep the rest pending. And give 
> this a good testing..
...
> Gerd Knorr:
>   o video/arv: remove casts
>   o video/w9966: remove casts
>   o video/zr36120: remove casts
>   o v4l: video-buf update
>   o v4l2 tuner api update
>   o v4l: tuner update
>   o v4l: add tveeprom module
>   o v4l: tvaudio update
>   o v4l: bttv IR input driver update
>   o v4l: bttv update
>   o v4l: saa7134 module
>   o v4l-saa7134-module fix
>   o add i2c adapter id for the cx88 driver

My TV card (Pinnacle PCTV Studio/Rave) stopped working due to these
updates. I get no signal anymore. Rebooting into an older kernel does
not stop the problem immediately. I actually have to power down the
machine and then boot into 2.6.11-rc2 to make my TV card functioning
again.

Here is the relevant dmesg part:

Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
bttv0: Bt878 (rev 17) at 0000:00:0c.0, irq: 17, latency: 64, mmio:
0xefe00000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: pinnacle/mt: id=1 info="PAL / mono" radio=no
bttv0: using tuner=33
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
Losing some ticks... checking if CPU frequency changed.
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
tuner: microtune: companycode=4d54 part=04 rev=04
tuner: microtune MT2032 found, OK
tda9885/6/7: chip found @ 0x86
...
mt2032_set_if_freq failed with -121
mt2032_set_if_freq2 failed with -121
mt2032_set_if_freq failed with -121
mt2032_set_if_freq2 failed with -121
(repeated whenever one switches channels)
__  
Markus


