Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbRERNRM>; Fri, 18 May 2001 09:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262309AbRERNRB>; Fri, 18 May 2001 09:17:01 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:1740 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S262290AbRERNQp>; Fri, 18 May 2001 09:16:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Kernel support for Sony Vaio PCG-FX140
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 18 May 2001 15:16:38 +0200
Message-ID: <qwweltmbxvt.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.5 (anise)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I started to use Linux on Sony Vaio PCG-FX140. It has Intel 815-EM
chipset.  I got the network card working, but had little luck with other
stuff. I used 2.4.4-ac4.

1) The ethernet:
01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset Ethernet (rev 03)
        Subsystem: Intel Corporation: Unknown device 3013
        Flags: bus master, medium devsel, latency 66, IRQ 9
        Memory at f4105000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 3000 [size=64]
        Capabilities: [dc] Power Management version 2

works with eepro100 driver on 100Mbit network. But oopses on insmod with
CONFIG_EEPRO100_PM=y. I alsoa had some problems on 10Mbit, under heavy
load the card starts reporting "eepro100: wait_for_cmd_done timeout!" 
and stops receiving, ifconfig down/up fixes that. 

2) Audio:
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 03)
        Subsystem: Sony Corporation: Unknown device 80df
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 1c00 [size=256]
        I/O ports at 1840 [size=64]

I have no idea what driver to use, if there is one. I tried Intel 8x0
driver from alsa, but it did not work:

PCI: Found IRQ 5 for device 00:1f.5
PCI: The same IRQ used for device 00:1f.3
PCI: The same IRQ used for device 00:1f.6
PCI: Setting latency timer of device 00:1f.5 to 64
ALSA ac97_codec.c:1371: AC'97 does not respond - RESET
ALSA card-intel8x0.c:1141: Intel ICH soundcard not found or device busy

3) It has winmodem, so no luck there.
00:1f.6 Modem: Intel Corporation: Unknown device 2446 (rev 03) (prog-if 00 [Generic])
        Subsystem: Sony Corporation: Unknown device 80df
        Flags: medium devsel, IRQ 5
        I/O ports at 2000 [size=256]
        I/O ports at 1880 [size=128]

I did not have a chance to test USB and Firewire; will test USB over the
weekend. USB uhci drivers load, so I don't expect any problems there.

Any ideas or pointers ?

                                                Thanks, Petr
-- 
Go not to the elves for counsel, for they will say both yes and no.
		-- J.R.R. Tolkien
