Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbTDATxK>; Tue, 1 Apr 2003 14:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbTDATxK>; Tue, 1 Apr 2003 14:53:10 -0500
Received: from customer79-114.iplannetworks.net ([200.68.70.114]:29827 "EHLO
	nuada.toptech.com.ar") by vger.kernel.org with ESMTP
	id <S262810AbTDATxJ>; Tue, 1 Apr 2003 14:53:09 -0500
Message-ID: <3E89F0CA.3060007@zacarias.com.ar>
Date: Tue, 01 Apr 2003 17:04:26 -0300
From: Gustavo Zacarias <gustavo@zacarias.com.ar>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Accton network chipset -> bad tulip clone?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.
Has anyone seen this happen?
I'm getting TX packets as errors, looks like some swapped register in 
the chip maybe?
And yes, they are actually TXed correct, and i've also tried swapping 
the NIC with another one from the same brand/model, and also into 
another machine with the same results.
The chip is physically branded as an "ADMtek AN983B", the board is an 
"Xnet 3000ACM".
PCI manufacturer ID looks quite phony, this is no Linksys board.
Kernel is 2.4.20.
Any ideas?

----
# ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:05:1C:0D:D9:E5
           inet addr:192.168.1.254  Bcast:192.168.1.255 Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:2989342 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:3448876 dropped:0 overruns:0 carrier:6778358
           collisions:0 txqueuelen:100
           RX bytes:839123376 (800.2 Mb)  TX bytes:0 (0.0 b)
           Interrupt:9 Base address:0x1800

# lspci -v -s 00:0f.0
00:0f.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 
10/100 model NC100 (rev 11)
         Subsystem: Accton Technology Corporation: Unknown device 1216
         Flags: bus master, medium devsel, latency 32, IRQ 9
         I/O ports at f000 [size=256]
         Memory at ffaef800 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at ffac0000 [disabled] [size=128K]
         Capabilities: [c0] Power Management version 2

----



