Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbREROBP>; Fri, 18 May 2001 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbREROBF>; Fri, 18 May 2001 10:01:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262324AbREROAr>; Fri, 18 May 2001 10:00:47 -0400
Subject: Re: Kernel support for Sony Vaio PCG-FX140
To: pekon@informatics.muni.cz (Petr Konecny)
Date: Fri, 18 May 2001 14:57:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <qwweltmbxvt.fsf@decibel.fi.muni.cz> from "Petr Konecny" at May 18, 2001 03:16:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150klD-00077z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) The ethernet:
> 01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset Ethernet (rev 03)
>         Subsystem: Intel Corporation: Unknown device 3013
>         Flags: bus master, medium devsel, latency 66, IRQ 9
>         Memory at f4105000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at 3000 [size=64]
>         Capabilities: [dc] Power Management version 2
> 
> works with eepro100 driver on 100Mbit network. But oopses on insmod with
> CONFIG_EEPRO100_PM=y. I alsoa had some problems on 10Mbit, under heavy
> load the card starts reporting "eepro100: wait_for_cmd_done timeout!" 
> and stops receiving, ifconfig down/up fixes that. 

I would be interested in the oops trace for the PM case. 

> 2) Audio:
> 00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 03)
>         Subsystem: Sony Corporation: Unknown device 80df

Intel ICH2/ICH3

> I have no idea what driver to use, if there is one. I tried Intel 8x0
> driver from alsa, but it did not work:

Use the i810_audio driver see if that works any better

> 3) It has winmodem, so no luck there.
> 00:1f.6 Modem: Intel Corporation: Unknown device 2446 (rev 03) (prog-if 00 [Generic])
>         Subsystem: Sony Corporation: Unknown device 80df
>         Flags: medium devsel, IRQ 5
>         I/O ports at 2000 [size=256]
>         I/O ports at 1880 [size=128]

Almost certainly the modem codec on the i810 chipset. If so its an absolutely
dumb winmodem - but the hardware iface is doucmented. Someone just has to
build a working modem stack


