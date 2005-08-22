Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVHVU16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVHVU16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVHVU16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:27:58 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:49567 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S1751058AbVHVU15
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:27:57 -0400
Date: 22 Aug 2005 22:27:40 +0200
Message-ID: <20050822202740.9793.qmail@dns.toxicfilms.tv>
From: solt@dns.toxicfilms.tv
To: linux-kernel@vger.kernel.org
Subject: 3com 3c59x stopped working with 2.6.13-rc[56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i tried to boot 2.6.13-rc5-git4 and 2.6.13-rc6-git13 both with the same
result: my 3com (3c59x driver on 3com 905c) card not working.
Here is what I saw in the logs.
Notice the regularity of the log barfs. They continue the same every 10secs.

The upgrade was committed using:
cd /usr/src/linux
patch -p1 < ../patch-2.6.13-rc5
patch -p1 < ../patch-2.6.13-rc5-git4
make oldconfig
make bzImage modules modules_install install

gcc-4.0.1 from Debian testing.

Any ideas?
Regards,
Maciej


18:27:47: eth1: Setting full-duplex based on MII #24 link partner capability of 05e1.
18:32:02: NETDEV WATCHDOG: eth1: transmit timed out
18:32:02: eth1: transmit timed out, tx_status 00 status e601.
18:32:02:   diagnostics: net 0cfa media 8880 dma 0000003a fifo 8800
18:32:02: eth1: Interrupt posted but not delivered -- IRQ blocked by another device?
18:32:02:   Flags; bus-master 1, dirty 16(0) current 16(0)
18:32:02:   Transmit list 00000000 vs. dff2c200.
18:32:02:   0: @dff2c200  length 80000020 status 00010020
18:32:02:   1: @dff2c2a0  length 8000002a status 0001002a
18:32:02:   2: @dff2c340  length 8000002a status 0001002a
18:32:02:   3: @dff2c3e0  length 80000076 status 00010076
18:32:02:   4: @dff2c480  length 8000002a status 0001002a
18:32:02:   5: @dff2c520  length 8000002a status 0001002a
18:32:02:   6: @dff2c5c0  length 8000002a status 0001002a
18:32:02:   7: @dff2c660  length 8000002a status 0001002a
18:32:02:   8: @dff2c700  length 8000002a status 0001002a
18:32:02:   9: @dff2c7a0  length 8000002a status 0001002a
18:32:02:   10: @dff2c840  length 8000002a status 0001002a
18:32:02:   11: @dff2c8e0  length 80000020 status 00010020
18:32:02:   12: @dff2c980  length 80000020 status 00010020
18:32:02:   13: @dff2ca20  length 80000020 status 00010020
18:32:02:   14: @dff2cac0  length 80000076 status 80010076
18:32:02:   15: @dff2cb60  length 80000020 status 80010020
18:32:02: eth1: Resetting the Tx ring pointer.
18:38:02: NETDEV WATCHDOG: eth1: transmit timed out
18:38:02: eth1: transmit timed out, tx_status 00 status e601.
18:38:02:   diagnostics: net 0cfa media 8880 dma 0000003a fifo 8000
18:38:02: eth1: Interrupt posted but not delivered -- IRQ blocked by another device?
18:38:02:   Flags; bus-master 1, dirty 32(0) current 32(0)
18:38:02:   Transmit list 00000000 vs. dff2c200.
18:38:02:   0: @dff2c200  length 80000020 status 00010020
18:38:02:   1: @dff2c2a0  length 80000020 status 00010020
18:38:02:   2: @dff2c340  length 80000020 status 00010020
18:38:02:   3: @dff2c3e0  length 8000002a status 0001002a
18:38:02:   4: @dff2c480  length 8000002a status 0001002a
18:38:02:   5: @dff2c520  length 8000002a status 0001002a
18:38:02:   6: @dff2c5c0  length 8000002a status 0001002a
18:38:02:   7: @dff2c660  length 8000002a status 0001002a
18:38:02:   8: @dff2c700  length 8000002a status 0001002a
18:38:02:   9: @dff2c7a0  length 8000002a status 0001002a
18:38:02:   10: @dff2c840  length 8000002a status 0001002a
18:38:02:   11: @dff2c8e0  length 8000002a status 0001002a
18:38:02:   12: @dff2c980  length 80000020 status 00010020
18:38:02:   13: @dff2ca20  length 80000076 status 00010076
18:38:02:   14: @dff2cac0  length 80000020 status 80010020
18:38:02:   15: @dff2cb60  length 80000020 status 80010020
18:38:02: eth1: Resetting the Tx ring pointer.
18:38:12: NETDEV WATCHDOG: eth1: transmit timed out
18:38:12: eth1: transmit timed out, tx_status 00 status e601.
18:38:12:   diagnostics: net 0cfa media 8880 dma 0000003a fifo 0000
18:38:12: eth1: Interrupt posted but not delivered -- IRQ blocked by another device?
18:38:12:   Flags; bus-master 1, dirty 48(0) current 48(0)
18:38:12:   Transmit list 00000000 vs. dff2c200.
18:38:12:   0: @dff2c200  length 8000002a status 0001002a
18:38:12:   1: @dff2c2a0  length 8000002a status 0001002a
18:38:12:   2: @dff2c340  length 8000002a status 0001002a
18:38:12:   3: @dff2c3e0  length 8000002a status 0001002a
18:38:12:   4: @dff2c480  length 8000002a status 0001002a
18:38:12:   5: @dff2c520  length 8000002a status 0001002a
18:38:12:   6: @dff2c5c0  length 8000002a status 0001002a
18:38:12:   7: @dff2c660  length 8000002a status 0001002a
18:38:12:   8: @dff2c700  length 8000002a status 0001002a
18:38:12:   9: @dff2c7a0  length 8000002a status 0001002a
18:38:12:   10: @dff2c840  length 8000002a status 0001002a
18:38:12:   11: @dff2c8e0  length 8000002a status 0001002a
18:38:12:   12: @dff2c980  length 8000002a status 0001002a
18:38:12:   13: @dff2ca20  length 8000002a status 0001002a
18:38:12:   14: @dff2cac0  length 8000002a status 8001002a
18:38:12:   15: @dff2cb60  length 8000002a status 8001002a
18:38:12: eth1: Resetting the Tx ring pointer.
