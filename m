Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132891AbRDPJUM>; Mon, 16 Apr 2001 05:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132892AbRDPJUC>; Mon, 16 Apr 2001 05:20:02 -0400
Received: from wet.kiss.uni-lj.si ([193.2.98.10]:53764 "EHLO
	wet.kiss.uni-lj.si") by vger.kernel.org with ESMTP
	id <S132891AbRDPJTq>; Mon, 16 Apr 2001 05:19:46 -0400
From: Rok Papez <rok.papez@kiss.uni-lj.si>
Reply-To: rok.papez@kiss.uni-lj.si
To: linux-kernel@vger.kernel.org
Subject: TCP/IP problem on 2.2.18. Very big delay when pinging *local* interface (5x NIC, 18x IP).
Date: Mon, 16 Apr 2001 11:03:33 +0200
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01041611164102.00759@strader>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Running 5x 3c905 NICs with 18 IPs

Summary:
When I boot Linux and ping a *local* IP address, it has a
very big delay. Flood ping works without a glitch, normal 
ping exhibits a big delay at the start but will eventualy
start working normally.

Has anyone noticed similar problems ?

[root@skuta network-scripts]# ping 172.26.4.254
PING 172.26.4.254 (172.26.4.254) from 172.26.4.254 : 56(84) bytes of data.
64 bytes from 172.26.4.254: icmp_seq=0 ttl=255 time=0.1 ms
64 bytes from 172.26.4.254: icmp_seq=1 ttl=255 time=19050.4 ms
64 bytes from 172.26.4.254: icmp_seq=2 ttl=255 time=24225.6 ms
64 bytes from 172.26.4.254: icmp_seq=3 ttl=255 time=28241.1 ms
64 bytes from 172.26.4.254: icmp_seq=4 ttl=255 time=32260.9 ms
64 bytes from 172.26.4.254: icmp_seq=5 ttl=255 time=36280.6 ms
64 bytes from 172.26.4.254: icmp_seq=6 ttl=255 time=35299.7 ms
64 bytes from 172.26.4.254: icmp_seq=7 ttl=255 time=34321.5 ms
64 bytes from 172.26.4.254: icmp_seq=8 ttl=255 time=33327.0 ms
64 bytes from 172.26.4.254: icmp_seq=9 ttl=255 time=32348.4 ms
64 bytes from 172.26.4.254: icmp_seq=10 ttl=255 time=31375.9 ms
64 bytes from 172.26.4.254: icmp_seq=11 ttl=255 time=30379.0 ms
64 bytes from 172.26.4.254: icmp_seq=12 ttl=255 time=29401.5 ms
64 bytes from 172.26.4.254: icmp_seq=13 ttl=255 time=28405.0 ms
64 bytes from 172.26.4.254: icmp_seq=14 ttl=255 time=27423.6 ms
64 bytes from 172.26.4.254: icmp_seq=15 ttl=255 time=26427.1 ms
64 bytes from 172.26.4.254: icmp_seq=16 ttl=255 time=25445.2 ms
64 bytes from 172.26.4.254: icmp_seq=17 ttl=255 time=24450.0 ms
64 bytes from 172.26.4.254: icmp_seq=18 ttl=255 time=23472.6 ms
64 bytes from 172.26.4.254: icmp_seq=19 ttl=255 time=22494.6 ms
64 bytes from 172.26.4.254: icmp_seq=20 ttl=255 time=21498.2 ms
64 bytes from 172.26.4.254: icmp_seq=21 ttl=255 time=20515.7 ms
64 bytes from 172.26.4.254: icmp_seq=22 ttl=255 time=19520.9 ms
64 bytes from 172.26.4.254: icmp_seq=23 ttl=255 time=18541.0 ms
64 bytes from 172.26.4.254: icmp_seq=24 ttl=255 time=17545.9 ms
64 bytes from 172.26.4.254: icmp_seq=25 ttl=255 time=16565.7 ms
64 bytes from 172.26.4.254: icmp_seq=26 ttl=255 time=15591.5 ms
64 bytes from 172.26.4.254: icmp_seq=27 ttl=255 time=14613.1 ms
64 bytes from 172.26.4.254: icmp_seq=28 ttl=255 time=13617.1 ms
64 bytes from 172.26.4.254: icmp_seq=29 ttl=255 time=12636.6 ms
64 bytes from 172.26.4.254: icmp_seq=30 ttl=255 time=11661.6 ms
64 bytes from 172.26.4.254: icmp_seq=31 ttl=255 time=10681.2 ms
64 bytes from 172.26.4.254: icmp_seq=32 ttl=255 time=9703.5 ms
64 bytes from 172.26.4.254: icmp_seq=33 ttl=255 time=8706.6 ms
64 bytes from 172.26.4.254: icmp_seq=34 ttl=255 time=7725.9 ms
64 bytes from 172.26.4.254: icmp_seq=35 ttl=255 time=6737.6 ms
64 bytes from 172.26.4.254: icmp_seq=36 ttl=255 time=5767.3 ms
64 bytes from 172.26.4.254: icmp_seq=37 ttl=255 time=4786.5 ms
64 bytes from 172.26.4.254: icmp_seq=38 ttl=255 time=3791.6 ms
64 bytes from 172.26.4.254: icmp_seq=39 ttl=255 time=2813.6 ms
64 bytes from 172.26.4.254: icmp_seq=40 ttl=255 time=1834.2 ms
64 bytes from 172.26.4.254: icmp_seq=41 ttl=255 time=837.8 ms
64 bytes from 172.26.4.254: icmp_seq=42 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=43 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=44 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=45 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=46 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=47 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=48 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=49 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=50 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=51 ttl=255 time=4000.7 ms
64 bytes from 172.26.4.254: icmp_seq=52 ttl=255 time=3021.2 ms
64 bytes from 172.26.4.254: icmp_seq=53 ttl=255 time=2025.4 ms
64 bytes from 172.26.4.254: icmp_seq=54 ttl=255 time=1048.1 ms
64 bytes from 172.26.4.254: icmp_seq=55 ttl=255 time=53.3 ms
64 bytes from 172.26.4.254: icmp_seq=56 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=57 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=58 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=59 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=60 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=61 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=62 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=63 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=64 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=65 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=66 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=67 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=68 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=69 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=70 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=71 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=72 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=73 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=74 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=75 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=76 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=77 ttl=255 time=0.1 ms
64 bytes from 172.26.4.254: icmp_seq=78 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=79 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=80 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=81 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=82 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=83 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=84 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=85 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=86 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=87 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=88 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=89 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=90 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=91 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=92 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=93 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=94 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=95 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=96 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=97 ttl=255 time=0.0 ms
 
--- 172.26.4.254 ping statistics ---
98 packets transmitted, 98 packets received, 0% packet loss
round-trip min/avg/max = 0.0/8168.0/36280.6 ms



[root@skuta network-scripts]# ping 172.26.4.254
PING 172.26.4.254 (172.26.4.254) from 172.26.4.254 : 56(84) bytes of data.
64 bytes from 172.26.4.254: icmp_seq=0 ttl=255 time=0.1 ms
64 bytes from 172.26.4.254: icmp_seq=1 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=2 ttl=255 time=0.0 ms
64 bytes from 172.26.4.254: icmp_seq=3 ttl=255 time=0.0 ms
 
--- 172.26.4.254 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 0.0/0.0/0.1 ms


BOX: Linux RedHat 6.2 with 2.2.18 kernel, custom compile.
--------------------------------------------------
eth0      Link encap:Ethernet  HWaddr 00:01:02:F4:F3:BE
          inet addr:10.21.2.96  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:106287 errors:0 dropped:0 overruns:0 frame:0
          TX packets:10118 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:5 Base address:0x1000
 
eth1      Link encap:Ethernet  HWaddr 00:01:02:F4:F4:25
          inet addr:172.26.1.254  Bcast:172.26.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1460 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:11 Base address:0x1080
 
eth1:0    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:25
          inet addr:172.26.2.254  Bcast:172.26.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:11 Base address:0x1080
 
eth1:1    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:25
          inet addr:172.26.3.254  Bcast:172.26.3.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:11 Base address:0x1080
 
eth1:2    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:25
          inet addr:172.26.4.254  Bcast:172.26.4.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:11 Base address:0x1080
 
eth1:3    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:25
          inet addr:172.26.5.254  Bcast:172.26.5.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:11 Base address:0x1080
 
eth2      Link encap:Ethernet  HWaddr 00:01:02:F4:F4:21
          inet addr:172.26.100.1  Bcast:172.26.100.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          Interrupt:5 Base address:0x1400
 
eth2:0    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:21
          inet addr:172.26.101.1  Bcast:172.26.101.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:5 Base address:0x1400

eth2:1    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:21
          inet addr:172.26.102.1  Bcast:172.26.102.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:5 Base address:0x1400
 
eth2:2    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:21
          inet addr:172.26.103.1  Bcast:172.26.103.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:5 Base address:0x1400
 
eth2:3    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:21
          inet addr:172.26.104.1  Bcast:172.26.104.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:5 Base address:0x1400
 
eth3      Link encap:Ethernet  HWaddr 00:01:02:F4:F4:A6
          inet addr:172.26.200.1  Bcast:172.26.200.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:133068 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5112 errors:0 dropped:0 overruns:0 carrier:0
          collisions:154 txqueuelen:100
          Interrupt:10 Base address:0x1480
 
eth3:0    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:A6
          inet addr:172.26.201.1  Bcast:172.26.201.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0x1480
 
eth3:1    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:A6
          inet addr:172.26.202.1  Bcast:172.26.202.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0x1480
 
eth3:2    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:A6
          inet addr:172.26.203.1  Bcast:172.26.203.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0x1480
 
eth3:3    Link encap:Ethernet  HWaddr 00:01:02:F4:F4:A6
          inet addr:172.26.204.1  Bcast:172.26.204.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0x1480
 
/* This one is totaly dummy... not connected */
eth4      Link encap:Ethernet  HWaddr 00:01:02:F4:F4:89
          inet addr:127.0.0.2  Bcast:127.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:55182 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:3924  Metric:1
          RX packets:2233847 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2233847 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0

------------------------------------------------------------
[root@skuta /root]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
172.26.1.254    0.0.0.0         255.255.255.255 UH    0      0        0 eth1
172.26.3.254    0.0.0.0         255.255.255.255 UH    0      0        0 eth1
172.26.101.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth2
172.26.103.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth2
172.26.5.254    0.0.0.0         255.255.255.255 UH    0      0        0 eth1
172.26.204.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth3
172.26.200.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth3
172.26.202.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth3
172.26.2.254    0.0.0.0         255.255.255.255 UH    0      0        0 eth1
172.26.100.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth2
172.26.102.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth2
172.26.4.254    0.0.0.0         255.255.255.255 UH    0      0        0 eth1
172.26.104.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth2
172.26.201.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth3
172.26.203.1    0.0.0.0         255.255.255.255 UH    0      0        0 eth3
127.0.0.2       0.0.0.0         255.255.255.255 UH    0      0        0 eth4
10.21.2.96      0.0.0.0         255.255.255.255 UH    0      0        0 eth0
172.26.4.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
172.26.103.0    0.0.0.0         255.255.255.0   U     0      0        0 eth2
172.26.5.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
172.26.102.0    0.0.0.0         255.255.255.0   U     0      0        0 eth2
172.26.101.0    0.0.0.0         255.255.255.0   U     0      0        0 eth2
172.26.100.0    0.0.0.0         255.255.255.0   U     0      0        0 eth2
172.26.1.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
172.26.2.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
172.26.3.0      0.0.0.0         255.255.255.0   U     0      0        0 eth1
172.26.202.0    0.0.0.0         255.255.255.0   U     0      0        0 eth3
172.26.203.0    0.0.0.0         255.255.255.0   U     0      0        0 eth3
172.26.200.0    0.0.0.0         255.255.255.0   U     0      0        0 eth3
172.26.201.0    0.0.0.0         255.255.255.0   U     0      0        0 eth3
172.26.204.0    0.0.0.0         255.255.255.0   U     0      0        0 eth3
172.26.104.0    0.0.0.0         255.255.255.0   U     0      0        0 eth2
10.0.0.0        0.0.0.0         255.0.0.0       U     0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 eth4
0.0.0.0         10.1.1.1        0.0.0.0         UG    0      0        0 eth0

------------------------------------------------------
[root@skuta /etc]# lsmod
Module                  Size  Used by
agpgart                 4724   1  (autoclean)
3c59x                  20928   5  (autoclean)
nistnet                49120   0  (unused)
 
[root@skuta /etc]# uname -a
Linux skuta 2.2.18 #2 Tue Mar 13 09:36:25 CET 2001 i686 unknown
------------------------------------------------------

-- 
lp,
Rok.
