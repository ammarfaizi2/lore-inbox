Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTJ0OOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTJ0OOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:14:05 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:264 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263151AbTJ0OOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:14:00 -0500
Date: Mon, 27 Oct 2003 15:13:58 +0100
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Transmit timeout with 3c395, 2.4.19, 2.4.22
Message-ID: <20031027141358.GA26271@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi list!

Suddenly, after 160 days of running, our bridged firewall started to
spit out this:
NETDEV WATCHDOG: eth1: transmit timed out
eth1: transmit timed out, tx_status 00 status e000.
  diagnostics: net 0cd8 media 8880 dma ffffffff.
  Flags; bus-master 1, dirty 2606584(8) current 2606600(8)
  Transmit list 07f2f400 vs. c7f6f400.
  0: @c7f6f200  length 800000a2 status 000000a2
  1: @c7f6f240  length 8000003c status 0000003c
  2: @c7f6f280  length 80000095 status 00000095
  3: @c7f6f2c0  length 80000092 status 00000092
  4: @c7f6f300  length 80000062 status 00000062
  5: @c7f6f340  length 8000009b status 0000009b
  6: @c7f6f380  length 800000a5 status 800000a5
  7: @c7f6f3c0  length 8000009d status 8000009d
  8: @c7f6f400  length 80000092 status 00000092
  9: @c7f6f440  length 80000072 status 00000072
  10: @c7f6f480  length 80000092 status 00000092
  11: @c7f6f4c0  length 80000072 status 00000072
  12: @c7f6f500  length 800000a2 status 000000a2
  13: @c7f6f540  length 80000089 status 00000089
  14: @c7f6f580  length 80000092 status 00000092
  15: @c7f6f5c0  length 80000091 status 00000091
eth1: Resetting the Tx ring pointer.

cont...

This was first with 2.4.19 plus bridge-firewall patches. I installed
2.4.22 with the latest ebtables/brfw patches, but got the same errors.
In all the cases reconfiguring the interfaces didn't help to bring it
back to life, only reboot helped. Now the very same error happens
already several times in a short period.

>From dmesg:
...
PCI: Found IRQ 5 for device 00:09.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe000. Vers LK1.1.18-ac
 00:50:04:4c:6f:22, IRQ 5
  product code 5451 rev 00.12 date 06-06-99
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
00:09.0: scatter/gather enabled. h/w checksums enabled
PCI: Found IRQ 10 for device 00:0c.0
See Documentation/networking/vortex.txt
00:0c.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe400. Vers LK1.1.18-ac
 00:50:04:4c:6f:97, IRQ 10
  product code 5451 rev 00.12 date 06-06-99
  Internal config register is 1800000, transceivers 0xa.
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7849.
  Enabling bus-master transmits and whole-frame receives.
00:0c.0: scatter/gather enabled. h/w checksums enabled

This always happened with eth1, so we think it *may* a hardware error
creeping in. I would like to know wether this can be the case, or
wether there is something else (switches on the other side, ...) which
may have produced these errors.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
OBWESTRY (abs.n.)
Bloody-minded determination on part of a storyteller to continue a
story which both the teller and the listeners know has become
desperately tedious.
			--- Douglas Adams, The Meaning of Liff
