Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316227AbSEKOyK>; Sat, 11 May 2002 10:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316228AbSEKOyJ>; Sat, 11 May 2002 10:54:09 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:750 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S316227AbSEKOyH>; Sat, 11 May 2002 10:54:07 -0400
Date: Sat, 11 May 2002 16:53:31 +0200 (CEST)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Via-rhine problems (2.4.19-pre8)
Message-ID: <Pine.LNX.4.44.0205111651070.1365-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm having some problems with my via-rhine ethernet card.
I have a crossed cable running from the card to an ADSL modem.
Regularly (at least once every two days) I have connections problems 
and I'm unable to even ping the ADSL modem. On /var/log/messages I see the 
message:

kernel: eth0: reset did not complete in 10 ms.
kernel: NETDEV WATCHDOG: eth0: transmit timed out
kernel: eth0: Transmit timed out, status 0000, PHY status 782d, 
resetting...

Removing the ethernet cable, unloading/loading the module doesn't change a
thing, only a cold reboot fixes the problem (until next time).

Is this a known problem? Any fixes?

Driver startup info:
kernel: via-rhine.c:v1.10-LK1.1.13  Nov-17-2001  Written by Donald Becker
kernel: http://www.scyld.com/network/via-rhine.html
kernel: eth0: VIA VT6102 Rhine-II at 0xd000, 00:50:ba:65:47:7d, IRQ 10.
kernel: eth0: MII PHY found at address 8, status 0x7829 advertising 01e1 
Link 0021.

/sbin/lspci -vn:
00:0b.0 Class 0200: 1106:3065 (rev 42)
        Subsystem: 1186:1401
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d000 [size=256]
        Memory at e3000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2

The card is a D-Link DFE-530TX.

Thanks for any help,
Rui Sousa


