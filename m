Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319426AbSIGAA5>; Fri, 6 Sep 2002 20:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319427AbSIGAA4>; Fri, 6 Sep 2002 20:00:56 -0400
Received: from tempest.prismnet.com ([209.198.128.6]:64524 "EHLO
	tempest.prismnet.com") by vger.kernel.org with ESMTP
	id <S319426AbSIGAAy>; Fri, 6 Sep 2002 20:00:54 -0400
From: Troy Wilson <tcw@tempest.prismnet.com>
Message-Id: <200209070005.g8705TYN017050@tempest.prismnet.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <1031283490.3d7823228d9ed@imap.linux.ibm.com> "from Nivedita Singhvi
 at Sep 5, 2002 08:38:10 pm"
To: Nivedita Singhvi <niv@us.ibm.com>
Date: Fri, 6 Sep 2002 19:05:29 -0500 (CDT)
CC: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ifconfig -a and netstat -rn would also be nice to have..

  These counters may have wrapped over the course of the full-length
( 3 x 20 minute runs + 20 minute warmup + rampup + rampdown) SPECWeb run.


*******************************
* ifconfig -a before workload *
*******************************

eth0      Link encap:Ethernet  HWaddr 00:04:AC:23:5E:99  
          inet addr:9.3.192.209  Bcast:9.3.192.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:208 errors:0 dropped:0 overruns:0 frame:0
          TX packets:104 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:22562 (22.0 Kb)  TX bytes:14356 (14.0 Kb)
          Interrupt:50 Base address:0x2000 Memory:fe180000-fe180038 

eth1      Link encap:Ethernet  HWaddr 00:02:B3:9C:F5:9E  
          inet addr:192.168.4.1  Bcast:192.168.4.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:10 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:5940 (5.8 Kb)  TX bytes:256 (256.0 b)
          Interrupt:61 Base address:0x1200 Memory:fc020000-0 

eth2      Link encap:Ethernet  HWaddr 00:02:B3:A8:35:C1  
          inet addr:192.168.2.1  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:256 (256.0 b)
          Interrupt:54 Base address:0x1220 Memory:fc060000-0 

eth3      Link encap:Ethernet  HWaddr 00:02:B3:A3:47:E7  
          inet addr:192.168.3.1  Bcast:192.168.3.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:256 (256.0 b)
          Interrupt:44 Base address:0x2040 Memory:fe120000-0 

eth4      Link encap:Ethernet  HWaddr 00:02:B3:A3:46:F9  
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:5 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:784 (784.0 b)  TX bytes:256 (256.0 b)
          Interrupt:36 Base address:0x2060 Memory:fe160000-0 

eth5      Link encap:Ethernet  HWaddr 00:02:B3:A3:47:88  
          inet addr:192.168.5.1  Bcast:192.168.5.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:256 (256.0 b)
          Interrupt:32 Base address:0x3000 Memory:fe420000-0 

eth6      Link encap:Ethernet  HWaddr 00:02:B3:9C:F5:A0  
          inet addr:192.168.6.1  Bcast:192.168.6.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:64 (64.0 b)  TX bytes:256 (256.0 b)
          Interrupt:28 Base address:0x3020 Memory:fe460000-0 

eth7      Link encap:Ethernet  HWaddr 00:02:B3:A3:47:39  
          inet addr:192.168.7.1  Bcast:192.168.7.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:256 (256.0 b)
          Interrupt:24 Base address:0x4000 Memory:fe820000-0 

eth8      Link encap:Ethernet  HWaddr 00:02:B3:A3:47:87  
          inet addr:192.168.8.1  Bcast:192.168.8.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:256 (256.0 b)
          Interrupt:20 Base address:0x4020 Memory:fe860000-0 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:56 errors:0 dropped:0 overruns:0 frame:0
          TX packets:56 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:5100 (4.9 Kb)  TX bytes:5100 (4.9 Kb)


******************************
* ifconfig -a after workload *
******************************

eth0      Link encap:Ethernet  HWaddr 00:04:AC:23:5E:99  
          inet addr:9.3.192.209  Bcast:9.3.192.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3434 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1408 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:336578 (328.6 Kb)  TX bytes:290474 (283.6 Kb)
          Interrupt:50 Base address:0x2000 Memory:fe180000-fe180038 

eth1      Link encap:Ethernet  HWaddr 00:02:B3:9C:F5:9E  
          inet addr:192.168.4.1  Bcast:192.168.4.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:74893662 errors:3 dropped:3 overruns:0 frame:0
          TX packets:100464074 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:1286843881 (1227.2 Mb)  TX bytes:2106085286 (2008.5 Mb)
          Interrupt:61 Base address:0x1200 Memory:fc020000-0 

eth2      Link encap:Ethernet  HWaddr 00:02:B3:A8:35:C1  
          inet addr:192.168.2.1  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:256 (256.0 b)
          Interrupt:54 Base address:0x1220 Memory:fc060000-0 

eth3      Link encap:Ethernet  HWaddr 00:02:B3:A3:47:E7  
          inet addr:192.168.3.1  Bcast:192.168.3.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:50054881 errors:0 dropped:0 overruns:0 frame:0
          TX packets:67122955 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:3730406436 (3557.5 Mb)  TX bytes:3034087396 (2893.5 Mb)
          Interrupt:44 Base address:0x2040 Memory:fe120000-0 

eth4      Link encap:Ethernet  HWaddr 00:02:B3:A3:46:F9  
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:48 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:7342 (7.1 Kb)  TX bytes:256 (256.0 b)
          Interrupt:36 Base address:0x2060 Memory:fe160000-0 

eth5      Link encap:Ethernet  HWaddr 00:02:B3:A3:47:88  
          inet addr:192.168.5.1  Bcast:192.168.5.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:149206960 errors:2861 dropped:2861 overruns:0 frame:0
          TX packets:200247016 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:2530107402 (2412.8 Mb)  TX bytes:3331495154 (3177.1 Mb)
          Interrupt:32 Base address:0x3000 Memory:fe420000-0 

eth6      Link encap:Ethernet  HWaddr 00:02:B3:9C:F5:A0  
          inet addr:192.168.6.1  Bcast:192.168.6.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:13 errors:0 dropped:0 overruns:0 frame:0
          TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:832 (832.0 b)  TX bytes:640 (640.0 b)
          Interrupt:28 Base address:0x3020 Memory:fe460000-0 

eth7      Link encap:Ethernet  HWaddr 00:02:B3:A3:47:39  
          inet addr:192.168.7.1  Bcast:192.168.7.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:151162569 errors:2993 dropped:2993 overruns:0 frame:0
          TX packets:202895482 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:2673954954 (2550.0 Mb)  TX bytes:2456469394 (2342.6 Mb)
          Interrupt:24 Base address:0x4000 Memory:fe820000-0 

eth8      Link encap:Ethernet  HWaddr 00:02:B3:A3:47:87  
          inet addr:192.168.8.1  Bcast:192.168.8.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:256 (256.0 b)
          Interrupt:20 Base address:0x4020 Memory:fe860000-0 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:100 errors:0 dropped:0 overruns:0 frame:0
          TX packets:100 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:8696 (8.4 Kb)  TX bytes:8696 (8.4 Kb)


***************
* netstat -rn *
***************

Kernel IP routing table
Destination     Gateway         Genmask         Flags   MSS Window  irtt Iface
192.168.7.0     0.0.0.0         255.255.255.0   U        40 0          0 eth7
192.168.6.0     0.0.0.0         255.255.255.0   U        40 0          0 eth6
192.168.5.0     0.0.0.0         255.255.255.0   U        40 0          0 eth5
192.168.4.0     0.0.0.0         255.255.255.0   U        40 0          0 eth1
192.168.3.0     0.0.0.0         255.255.255.0   U        40 0          0 eth3
192.168.2.0     0.0.0.0         255.255.255.0   U        40 0          0 eth2
192.168.1.0     0.0.0.0         255.255.255.0   U        40 0          0 eth4
9.3.192.0       0.0.0.0         255.255.255.0   U        40 0          0 eth0
192.168.8.0     0.0.0.0         255.255.255.0   U        40 0          0 eth8
127.0.0.0       0.0.0.0         255.0.0.0       U        40 0          0 lo
0.0.0.0         9.3.192.1       0.0.0.0         UG       40 0          0 eth0






