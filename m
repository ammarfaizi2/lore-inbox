Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSBZMco>; Tue, 26 Feb 2002 07:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSBZMcf>; Tue, 26 Feb 2002 07:32:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6670 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285060AbSBZMc1>; Tue, 26 Feb 2002 07:32:27 -0500
Subject: Re: Problems with orinoco_cs and i810_audio
To: haegar@sdinet.de (Sven Koch)
Date: Tue, 26 Feb 2002 12:47:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, hermes@gibson.dropbear.id.au
In-Reply-To: <Pine.LNX.4.40.0202261314260.695-100000@space.comunit.de> from "Sven Koch" at Feb 26, 2002 01:22:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fh0g-0000XD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Feb 26 13:13:40 aurora kernel: i810_audio: only 48Khz playback available.
> Feb 26 13:13:40 aurora kernel: i810_audio: AC'97 codec 0 supports AMAP,
> total ch annels = 2
> Feb 26 13:13:40 aurora kernel: ac97_codec: AC97 Modem codec, id:
> 0x5349:0x4c27 (Unknown)
> Feb 26 13:13:50 aurora kernel: i810_audio: timed out waiting for codec 1
> analog

Ok the codec timeout I fixed in -ac but it isnt related to your other 
problem.

> with ZV Support, Toshiba America Info Systems ToPIC95 PCI to Cardbus
> Bridge with ZV Support (#2), usb-uhci, usb-uhci, orinoco_cs, Intel ICH2

Exclude IRQ11 in your /etc/pcmcia/config - the orinoco card probably isnt
going to like sharing if its pcmcia not cardbus
