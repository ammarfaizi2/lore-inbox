Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRBOSSL>; Thu, 15 Feb 2001 13:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRBOSSB>; Thu, 15 Feb 2001 13:18:01 -0500
Received: from think.faceprint.com ([166.90.149.11]:41220 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S129112AbRBOSRx>; Thu, 15 Feb 2001 13:17:53 -0500
Message-ID: <3A8C1D50.AB6F2E5A@faceprint.com>
Date: Thu, 15 Feb 2001 13:17:52 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-ac14 tulip woes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fix in ac14 for the ac13 patch that killed the tulip driver doesn't
quite work either:

Feb 15 13:04:16 patience kernel: LDT allocated for cloned task!
Feb 15 13:04:55 patience kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 15 13:05:27 patience last message repeated 4 times
Feb 15 13:06:31 patience last message repeated 8 times
Feb 15 13:07:35 patience last message repeated 8 times
Feb 15 13:07:59 patience last message repeated 3 times
Feb 15 13:08:07 patience kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Feb 15 13:08:39 patience last message repeated 4 times
Feb 15 13:08:41 patience init: Switching to runlevel: 6

lspci -v from ac13 w/ ac12 tulip driver:

00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
        Subsystem: Netgear FA310TX
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at 9800 [size=256]
        Memory at e0000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]

dmesg snippet from ac13 w/ ac12 tulip driver:
PCI: Found IRQ 5 for device 00:0a.0
eth0: Lite-On 82c168 PNIC rev 32 at 0x9800, 00:A0:CC:61:CC:D2, IRQ 5.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.

Nathan
