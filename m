Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSBZMoq>; Tue, 26 Feb 2002 07:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbSBZMog>; Tue, 26 Feb 2002 07:44:36 -0500
Received: from butterblume.comunit.net ([192.76.134.57]:29956 "EHLO
	butterblume.comunit.net") by vger.kernel.org with ESMTP
	id <S284144AbSBZMoS>; Tue, 26 Feb 2002 07:44:18 -0500
Date: Tue, 26 Feb 2002 13:44:16 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, <hermes@gibson.dropbear.id.au>
Subject: Re: Problems with orinoco_cs and i810_audio
In-Reply-To: <E16fh0g-0000XD-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0202261340220.695-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Alan Cox wrote:

> > Feb 26 13:13:40 aurora kernel: i810_audio: only 48Khz playback available.
> > Feb 26 13:13:40 aurora kernel: i810_audio: AC'97 codec 0 supports AMAP,
> > total ch annels = 2
> > Feb 26 13:13:40 aurora kernel: ac97_codec: AC97 Modem codec, id:
> > 0x5349:0x4c27 (Unknown)
> > Feb 26 13:13:50 aurora kernel: i810_audio: timed out waiting for codec 1
> > analog
>
> Ok the codec timeout I fixed in -ac but it isnt related to your other
> problem.

ack
It only seems to happen once after loading the i810_audio module and does
not affect function.

> > with ZV Support, Toshiba America Info Systems ToPIC95 PCI to Cardbus
> > Bridge with ZV Support (#2), usb-uhci, usb-uhci, orinoco_cs, Intel ICH2
>
> Exclude IRQ11 in your /etc/pcmcia/config - the orinoco card probably isnt
> going to like sharing if its pcmcia not cardbus

This does not work.

Even with "exclude irq 11" in /etc/pcmcia/config.opts (included by
/etc/pcmcia/config) orinoco_cs reports on loading:

Feb 26 13:38:46 aurora kernel: orinoco_cs.c 0.09b (David Gibson
<hermes@gibson.dropbear.id.au> and others)
Feb 26 13:38:46 aurora kernel: eth1: Station identity 001f:0001:0006:000e
Feb 26 13:38:46 aurora kernel: eth1: Looks like a Lucent/Agere firmware
version 6.14
Feb 26 13:38:46 aurora kernel: eth1: Ad-hoc demo mode supported
Feb 26 13:38:46 aurora kernel: eth1: IEEE standard IBSS ad-hoc mode
supported
Feb 26 13:38:46 aurora kernel: eth1: WEP supported, 104-bit key
Feb 26 13:38:46 aurora kernel: eth1: MAC address 00:02:2D:12:3C:48
Feb 26 13:38:46 aurora kernel: eth1: Station name "HERMES I"
Feb 26 13:38:46 aurora kernel: eth1: ready
Feb 26 13:38:46 aurora kernel: eth1: index 0x01: Vcc 3.3, irq 11, io
0x0100-0x013f


c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

