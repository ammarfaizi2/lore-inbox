Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278652AbRJ1WaA>; Sun, 28 Oct 2001 17:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278703AbRJ1W3k>; Sun, 28 Oct 2001 17:29:40 -0500
Received: from AGrenoble-101-1-3-57.abo.wanadoo.fr ([193.253.251.57]:61313
	"EHLO lyon.ram.loc") by vger.kernel.org with ESMTP
	id <S278652AbRJ1W3i>; Sun, 28 Oct 2001 17:29:38 -0500
From: Raphael Manfredi <Raphael_Manfredi@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: 8139too on ABIT BP6 causes "eth0: transmit timed out"
X-Mailer: MH [version 6.8]
Organization: Home, Grenoble, France
Date: Sun, 28 Oct 2001 23:30:12 +0100
Message-ID: <16095.1004308212@nice.ram.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running:

	Linux nice 2.4.12-ac3 #1 SMP Sat Oct 20 16:21:24 MEST 2001 i686 unknown

but this problem is not specific to that kernel.  I've been having
it for a looong time.

Specifically, I get:

 NETDEV WATCHDOG: eth0: transmit timed out
 eth0: Tx queue start entry 32190531  dirty entry 32190527.
 eth0:  Tx descriptor 0 is 00002000.
 eth0:  Tx descriptor 1 is 00002000.
 eth0:  Tx descriptor 2 is 00002000.
 eth0:  Tx descriptor 3 is 00002000. (queue head)
 eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.

and then the machine is dead, network-wise.  I have to reboot (reset).

Note that I am on an ABIT BP6 board, and I do get a lot of APIC errors
under heavy network traffic, which is what raises the above.
By heavy network traffic, I mean a 7 Mb/s full duplex (it's a 100 Mb/s
LAN).

I suspect that somewhere, the APIC gets hosed and looses an interrupt,
and then the ethernet driver no longer processes its queue.
Is there anything that can be done to reset the hardware state more
fully when this occurs?

Raphael
