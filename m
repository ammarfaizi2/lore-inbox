Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTI3DNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 23:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTI3DNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 23:13:24 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:63754 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263088AbTI3DNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 23:13:22 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: 2.6.0-test[56] pcnet32 problems
Date: Tue, 30 Sep 2003 03:13:11 +0000 (UTC)
Organization: Cistron
Message-ID: <blasc7$jfi$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1064891591 19954 62.216.30.38 (30 Sep 2003 03:13:11 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got an cyrix box with built in ethernet & 2 extra ethernet cards
as a firewall at home with a dsl line (connected to eth0)

pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
PCI: Found IRQ 11 for device 0000:00:0f.0
IRQ routing conflict for 0000:00:0f.0, have irq 9, want irq 11
pcnet32: PCnet/FAST III 79C973 at 0xfca0, warning: CSR address invalid,
    using instead PROM address of 00 00 e2 24 41 1d assigned IRQ 9.
eth0: registered as PCnet/FAST III 79C973
pcnet32: 1 cards_found.

Sometimes (even during low traffic) eth0 simply locks up:
In dmesg i see:
kernel: eth0: Bus master arbitration failure, status 88f3.

rmmod pcnet32 results in kernel-panic.
Only reboot works.
tried:
acpi == disabled
pci=noacpi

Another weird thing is output of ifconfig eth0:

eth0      Link encap:Ethernet  HWaddr 00:00:E2:24:41:1D  
          inet addr:195.64.94.48  Bcast:195.64.94.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:30345 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:16042 dropped:0 overruns:0 carrier:16042
          collisions:0 txqueuelen:1000 
          RX bytes:38404293 (36.6 MiB)  TX bytes:1298028 (1.2 MiB)
          Interrupt:9 Base address:0xfca0 

0 packets transmitted , all errors ans carrier faults ?
Still it works! (this could be counters that are wrong)

kernel config, lspci -v and dmesg output available at:

http://dth.net/kernel/

Any help/suggestions/hints appreciated.

Danny
-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

