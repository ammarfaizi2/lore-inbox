Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTA3Bmt>; Wed, 29 Jan 2003 20:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbTA3Bmt>; Wed, 29 Jan 2003 20:42:49 -0500
Received: from corpmail.cwie.net ([63.214.164.17]:7349 "EHLO corpmail.cwie.net")
	by vger.kernel.org with ESMTP id <S267281AbTA3Bmr>;
	Wed, 29 Jan 2003 20:42:47 -0500
X-CWIE-Scanner-Mail-From: jbooth@ccbill.com via corpmail.cwie.net
X-CWIE-Scanner-Rcpt-To: andrewm@uow.edu.au,linux-kernel@vger.kernel.org,netdev@oss.sgi.com
X-CWIE-Scanner: 1.15 (Clear:. Processed in 0.547154 secs)
From: "Justin Booth" <jbooth@ccbill.com>
To: "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>
Cc: "'Netdev mailing list'" <netdev@oss.sgi.com>,
       "'Andrew Morton'" <andrewm@uow.edu.au>
Subject: High number of "carriers" 
Date: Wed, 29 Jan 2003 18:52:06 -0700
Message-ID: <001701c2c802$315a3380$6450000a@hwsys200225>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


	I have a problem with multiple machines that I have that have
dual onboard nic's on them that come up as "3Com Corporation 3c982 Dual
Port Server Cyclone" nics. The carrier counter seems to increase quite
quickly at about  1354 carriers per 3030906 bytes. I was transferring a
13 gig backup when I noticed the carriers. I seem to be transferring at
a rate of 1.7 Mb/sec.  The 6506 that I am plugged into is reporting no
errors or anything wrong with the lines at all. Mii-tool reports that
it's running 100Mbit FD. 

Any help would be greatly appreciated,

	Thanks, 
		Justin Booth



System Information
---------------


The kernel version is 2.4.20 with compiled in drivers , no kernel
modules loaded, using the 3c59x driver.

Eth0 is the only link that is live. mii-tool outputs:

eth0: 100 Mbit, full duplex, link ok
  product info: vendor 00:10:5a, model 0 rev 0
  basic mode:   100 Mbit, full duplex
  basic status: link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
flow-control
eth1: no link
  product info: vendor 00:10:5a, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: no link
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
flow-control

lspci -vx reports:

00:0f.0 Ethernet controller: 3Com Corporation 3c982 Dual Port Server
Cyclone (rev 78)
        Subsystem: Tyan Computer: Unknown device 2462
        Flags: bus master, medium devsel, latency 80, IRQ 18
        I/O ports at 1c00 [size=128]
        Memory at f4003000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
00: b7 10 05 98 17 00 10 02 78 00 00 02 10 50 00 00
10: 01 1c 00 00 00 30 00 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f1 10 62 24
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 0a 0a

00:10.0 Ethernet controller: 3Com Corporation 3c982 Dual Port Server
Cyclone (rev 78)
        Subsystem: Tyan Computer: Unknown device 2462
        Flags: bus master, medium devsel, latency 80, IRQ 19
        I/O ports at 1c80 [size=128]
        Memory at f4003400 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
00: b7 10 05 98 17 00 10 02 78 00 00 02 10 50 00 00
10: 81 1c 00 00 00 34 00 f4 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f1 10 62 24
30: 00 00 00 00 dc 00 00 00 00 00 00 00 03 01 0a 0a




ifconfig eth0:


eth0      Link encap:Ethernet  HWaddr 00:E0:81:03:E2:D5  
          inet addr:xx.xx.xx.xx  Bcast:xx.xx.xx.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:972257412 errors:0 dropped:0 overruns:0 frame:0
          TX packets:360108756 errors:0 dropped:0 overruns:0
carrier:68929308
          collisions:0 txqueuelen:100 
          RX bytes:776134149 (740.1 Mb)  TX bytes:1464990605 (1397.1 Mb)
          Interrupt:18 Base address:0x1c00



