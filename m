Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUGLDmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUGLDmr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266706AbUGLDmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:42:46 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:13723 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266705AbUGLDmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:42:23 -0400
Message-ID: <40F20891.8030808@blue-labs.org>
Date: Sun, 11 Jul 2004 23:42:09 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040711
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swsuspend still breaks 3c905, 2.6.7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend and the 3com card becomes useless.  Have to remove the module or 
reboot. Seems to be a pretty common and long-standing bug with the power 
management and has been around since at least the middle 2.5.xx 
kernels.  And it seems it's also in 2.4.x.

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status ff status ffff.
  diagnostics: net ffff media ffff dma ffffffff fifo ffff
eth0: Transmitter encountered 16 collisions -- network cable problem?
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
  Flags; bus-master 1, dirty 0(0) current 16(0)
  Transmit list ffffffff vs. e4aae200.
eth0: command 0x3002 did not complete! Status=0xffff
  0: @e4aae200  length 8000002a status 0000002a
  1: @e4aae2a0  length 8000002a status 0000002a
  2: @e4aae340  length 8000002a status 0000002a
  3: @e4aae3e0  length 8000002a status 0000002a
  4: @e4aae480  length 8000004c status 0000004c
  5: @e4aae520  length 8000002a status 0000002a
  6: @e4aae5c0  length 8000002a status 0000002a
  7: @e4aae660  length 8000002a status 0000002a
  8: @e4aae700  length 8000002a status 0000002a
  9: @e4aae7a0  length 8000004c status 0000004c
  10: @e4aae840  length 8000002a status 0000002a
  11: @e4aae8e0  length 8000002a status 0000002a
  12: @e4aae980  length 8000002a status 0000002a
  13: @e4aaea20  length 8000002a status 0000002a
  14: @e4aaeac0  length 8000004c status 8000004c
  15: @e4aaeb60  length 8000002a status 8000002a
eth0: command 0x5800 did not complete! Status=0xffff
eth0: Resetting the Tx ring pointer.


Chris root # lspci -v -s 2:0.0
02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] 
(rev 78)
        Subsystem: Dell Computer Corporation: Unknown device 00d4
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at ec80 [size=128]
        Memory at f8fffc00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at f9000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2


David

