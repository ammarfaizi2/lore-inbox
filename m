Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUFNOTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUFNOTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUFNOTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:19:04 -0400
Received: from mailadmin.wku.edu ([161.6.18.52]:45770 "EHLO mailadmin.wku.edu")
	by vger.kernel.org with ESMTP id S263159AbUFNORu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:17:50 -0400
From: "Bikram Assal" <bikram.assal@wku.edu>
Subject: kernel: NETDEV WATCHDOG: eth1: transmit timed out
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser Interface v.4.1.8
Date: Mon, 14 Jun 2004 09:17:45 -0500
Message-ID: <web-68924721@mailadmin.wku.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I m looking for help regarding few errors that I m getting in the /var/log/messages log file.

I m running RedHat linux version 7.3 with kernel version 2.4.18-5 with nfs.

We had updated the original kernel version but are still using the old NICS that came with the DELL PowerEdge box.
These NICS use eepro100 driver.

Sometimes, the system would just freeze with these error messages on the screen and the log file /var/log/messages as follows:

kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 12:56:24 kernel: eth1: Transmit timed out: status f048 0c00 at 1703794288/1703794348 command 200ca000.
Jun 2 12:57:06 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 12:57:06 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794348/1703794410 command 0001a000.
Jun 2 12:57:58 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 12:57:58 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794410/1703794471 command 0001a000.
Jun 2 12:59:02 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 12:59:02 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794471/1703794531 command 0001a000.
Jun 2 13:00:10 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:00:10 kernel: eth1: Transmit timed out: status 7088 0c00 at 1703794531/1703794593 command 0001a000.
Jun 2 13:01:14 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:01:14 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794593/1703794655 command 0001a000.
Jun 2 13:01:54 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:01:54 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794655/1703794715 command 0001a000.
Jun 2 13:02:48 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:02:48 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794715/1703794777 command 0001a000.
Jun 2 13:03:38 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:03:38 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794777/1703794839 command 0001a000.
Jun 2 13:04:14 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:04:14 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794839/1703794901 command 0001a000.
Jun 2 13:04:54 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:04:54 kernel: eth1: Transmit timed out: status f088 0c00 at 1703794901/1703794963 command 0001a000.
Jun 2 13:05:38 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:05:38 kernel: eth1: Transmit timed out: status 7088 0c00 at 1703794963/1703795024 command 0001a000.
Jun 2 13:06:22 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:06:22 kernel: eth1: Transmit timed out: status f088 0c00 at 1703795024/1703795085 command 0001a000.
Jun 2 13:07:16 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:07:16 kernel: eth1: Transmit timed out: status f088 0c00 at 1703795085/1703795147 command 0001a000.
Jun 2 13:07:58 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:07:58 kernel: eth1: Transmit timed out: status f088 0c00 at 1703795147/1703795209 command 0001a000.
Jun 2 13:08:48 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:08:48 kernel: eth1: Transmit timed out: status f088 0c00 at 1703795209/1703795270 command 0001a000.
Jun 2 13:09:38 kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jun 2 13:09:38 kernel: eth1: Transmit timed out: status f088 0c00 at 1703795270/1703795332 command 0001a000.

Once the system freezes, the network card stops working but the machine remains up and running. The system stops responding to keyboard events and just freezes and then the only way to bring it back up is to reboot the system.

When I run dmesg, I get the following out regarding NICs:

eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:06:5B:88:3E:AA, IRQ 26.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 00009c-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
eth1: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:A4:78:D9, IRQ 22.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly a67265-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
eth2: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:A4:78:DA, IRQ 26.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly a67265-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.


Would somebody be able to help me in this case ?

Thanks a lot in advance.


- Bikram 
OCA ( Oracle Certified Associate )
Database Specialist, WKU
http://www.wku.edu/~bikram.assal/
