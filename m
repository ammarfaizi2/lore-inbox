Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263051AbTC1QCS>; Fri, 28 Mar 2003 11:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263052AbTC1QCS>; Fri, 28 Mar 2003 11:02:18 -0500
Received: from web40505.mail.yahoo.com ([66.218.78.122]:7971 "HELO
	web40505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263051AbTC1QCR>; Fri, 28 Mar 2003 11:02:17 -0500
Message-ID: <20030328161328.6645.qmail@web40505.mail.yahoo.com>
Date: Fri, 28 Mar 2003 08:13:28 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: re: 3c59x gives HWaddr FF:FF:...
To: linux-kernel@vger.kernel.org
Cc: jamagallon@able.es
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running a later revision of that same NIC with no problems:

lspci:
00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at e000 [size=128]
        Memory at e9000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2


dmesg:
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:09.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.18-ac
 <HW address>, IRQ 10
  product code 4b53 rev 00.3 date 01-13-97
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
00:09.0: scatter/gather enabled. h/w checksums enabled

I'm runnning 2.4.21pre4-ac4. Looking at your dmesg output, it appears that your card
isn't being initialized correctly (e.g: the date field is bugus). I also noticed that my
NIC driver is a later revision than yours (  LK1.1.18-ac vs. LK1.1.16 )

Could you try booting 2.4.21pre4-ac4 and see if you have the same problem.
I'm assuming that you don't have any interrupt conflicts.


__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
