Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267851AbTBVIbX>; Sat, 22 Feb 2003 03:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbTBVIbX>; Sat, 22 Feb 2003 03:31:23 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:37124 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S267851AbTBVIbW>; Sat, 22 Feb 2003 03:31:22 -0500
Date: Sat, 22 Feb 2003 09:41:30 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-ac1, tulip driver falls into transmit timeouts
Message-ID: <20030222084130.GB23827@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of our Linux-based core routers has recently shown strange
behavior wrt the tulip ethernet card.

Debian/GNU Linux
Kernel 2.4.20-ac1 (with VLAN patches for the netcard drivers)
zebra/ospfd running
~ 20 virtual interfaces configured on 802.1q trunk
00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
        Subsystem: Digital Equipment Corporation DECchip 21142/43
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at a000 [size=128]
        Memory at dd800000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at <unassigned> [disabled] [size=256K]
        Capabilities: [dc] Power Management version 1
The network card is connected to a Cisco Catalyst 3524XL.

The hardware hasn't been touched in four months; kernel 2.4.20-ac1 was
installed in December 2002.

A few days ago, the machine started to drop off the network. Syslog
shows
Feb 21 12:03:32 joan kernel: vlan0: Setting half-duplex based on MII#1 link partner capability of 782d.
Feb 21 12:03:41 joan kernel: NETDEV WATCHDOG: vlan0: transmit timed out
Feb 21 12:03:49 joan kernel: NETDEV WATCHDOG: vlan0: transmit timed out
Feb 21 12:04:16 joan kernel: bbo1: add 01:00:5e:00:00:06 mcast address to master interface
Feb 21 12:04:21 joan kernel: NETDEV WATCHDOG: vlan0: transmit timed out
Feb 21 12:04:29 joan kernel: NETDEV WATCHDOG: vlan0: transmit timed out
Feb 21 12:04:32 joan kernel: vlan0: Setting full-duplex based on MII#1 link partner capability of 41e1.
entries. After falling back to full-duplex, the NETDEV WATCHDOG
message is repeated on a regular basis. Unloading and reloading
the tulip module usually fixes the problem.

Are there any known issues with the tulip module in 2.4.20-ac1? We are
using that configuration on other machines in our backbone as well,
without any problems. After all, this particular machine has been
working for months. But before I go out and swap the hardware, I'd
like to know if there are known problems with this setup.

Any hints will be appreciated.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
