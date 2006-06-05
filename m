Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751131AbWFEOYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWFEOYe (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFEOYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:24:34 -0400
Received: from mail.dgt.com.pl ([195.117.141.2]:9476 "EHLO dgt.com.pl")
	by vger.kernel.org with ESMTP id S1751131AbWFEOYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:24:33 -0400
Message-ID: <44843EFB.4030704@dgt.com.pl>
Date: Mon, 05 Jun 2006 16:26:03 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Dual via-rhine on EPIA PD6000E
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I have two differnent via-rhine on EPIA board. Second one is now 
working on my 2.6.15 kernel.

Why there are different io adresses in lspci dmesg and ifconfig?
Any idea why it's not working???


Here are some additional info:

#lspci -v
...
0000:00:0f.0 Ethernet controller: VIA Technologies, Inc. VT6105 
[Rhine-III] (rev
 8b)
        Subsystem: VIA Technologies, Inc.: Unknown device 0106
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d000 [size=256]
        Memory at de000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Power Management version 2
....
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 
[Rhine-II] (rev
74)
        Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded 
Ethernet Con
troller on VT8235
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e400 [size=256]
        Memory at de002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2





#ifconfig

eth0      Link encap:Ethernet  HWaddr 00:40:63:DB:86:85 
          inet addr:192.168.6.156  Bcast:192.168.6.255  Mask:255.255.255.0
          inet6 addr: fe80::240:63ff:fedb:8685/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2323562 errors:0 dropped:0 overruns:0 frame:0
          TX packets:474569 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:3145097604 (2.9 GiB)  TX bytes:98221200 (93.6 MiB)
          Interrupt:10 Base address:0xe000

eth1      Link encap:Ethernet  HWaddr 00:40:63:DB:86:88 
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11 Base address:0x4000


#dmesg
...
...
eth0: VIA Rhine III at 0xde000000, 00:40:63:db:86:85, IRQ 10.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 41e1.
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
eth1: VIA Rhine II at 0xde002000, 00:40:63:db:86:88, IRQ 11.
eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000
.....

PS  now second cable is disconnected, but there was a link on eth1 too




