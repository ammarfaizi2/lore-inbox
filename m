Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbULYNkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbULYNkv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbULYNkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:40:51 -0500
Received: from rt106.internetdsl.tpnet.pl ([80.55.71.106]:22914 "HELO brod.pl")
	by vger.kernel.org with SMTP id S261434AbULYNkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:40:31 -0500
Date: Sat, 25 Dec 2004 14:40:27 +0100
To: netfilter-devel@lists.netfilter.org,
       netfilter-devel-owner@lists.netfilter.org, linux-kernel@vger.kernel.org,
       "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu>,
       "David S. Miller" <davem@davemloft.net>,
       "Rusty Russell" <rusty@rustcorp.com.au>
Subject: ip_conntrack_tcp problem on kernel 2.4.28 !!! INVALID ? 
From: Konsar <konsar@brod.pl>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opsjkf9pg8or678w@localhost>
User-Agent: Opera M2/7.52 (Linux, build 727)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !!!

I have patches kernel 2.4.28 + patch-o-matic-ng-20040621 with  
iptables-1.2.11 on my router/NAT server.This islog from my server

Dec 25 14:12:22 gizmo kernel: NET: 27 messages suppressed.
Dec 25 14:12:22 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=83.77.122.183 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=237 ID=46800 PROTO=TCP SPT=9468 DPT=1694 SEQ=0  
ACK=825898583 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:12:27 gizmo kernel: NET: 35 messages suppressed.
Dec 25 14:12:27 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=62.121.70.214 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x20 TTL=119 ID=34129 PROTO=TCP SPT=4242 DPT=2549 SEQ=0  
ACK=2005480290 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:12:31 gizmo kernel: CHAT WP TCP: IN= OUT=pvc0 SRC=172.17.250.241  
DST=212.77.100.125 LEN=48 TOS=0x00 PREC=0x00 TTL=
127 ID=23042 DF PROTO=TCP SPT=1100 DPT=5579 WINDOW=8192 RES=0x00 SYN URGP=0
Dec 25 14:12:33 gizmo kernel: NET: 21 messages suppressed.
Dec 25 14:12:33 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=213.239.239.122 DST=22.22.22.22 LEN=40 TO
S=0x00 PREC=0x00 TTL=52 ID=3377 DF PROTO=TCP SPT=4667 DPT=1761 SEQ=0  
ACK=813352302 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:12:37 gizmo kernel: NET: 20 messages suppressed.
Dec 25 14:12:37 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=84.10.17.214 DST=22.22.22.22 LEN=40 TOS=0
x00 PREC=0x00 TTL=120 ID=50393 PROTO=TCP SPT=4662 DPT=2661 SEQ=0  
ACK=9308174 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:12:42 gizmo kernel: NET: 26 messages suppressed.
Dec 25 14:12:42 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=65.87.147.230 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=236 ID=4763 PROTO=TCP SPT=45685 DPT=4652 SEQ=0  
ACK=1890158427 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:12:47 gizmo kernel: NET: 33 messages suppressed.
Dec 25 14:12:47 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=66.192.117.42 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=106 ID=4442 PROTO=TCP SPT=4661 DPT=1770 SEQ=0  
ACK=679162417 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:12:52 gizmo kernel: NET: 25 messages suppressed.
Dec 25 14:12:52 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=193.124.3.125 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=52 ID=36341 PROTO=TCP SPT=4662 DPT=2625 SEQ=0  
ACK=2015595096 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:12:57 gizmo kernel: NET: 19 messages suppressed.
Dec 25 14:12:57 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=84.94.148.102 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=113 ID=8452 PROTO=TCP SPT=5662 DPT=1621 SEQ=0  
ACK=1829442 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:13:02 gizmo kernel: NET: 11 messages suppressed.
Dec 25 14:13:02 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=65.33.222.93 DST=22.22.22.22 LEN=40 TOS=0
x00 PREC=0x00 TTL=107 ID=9220 PROTO=TCP SPT=4662 DPT=2124 SEQ=0  
ACK=860192316 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:14:42 gizmo kernel: NET: 26 messages suppressed.
Dec 25 14:14:42 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=217.230.140.99 DST=22.22.22.22 LEN=40 TOS
=0x00 PREC=0x00 TTL=116 ID=25536 PROTO=TCP SPT=4662 DPT=2954 SEQ=0  
ACK=2058124665 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:14:47 gizmo kernel: NET: 15 messages suppressed.
Dec 25 14:14:47 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=80.224.113.94 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=112 ID=43358 PROTO=TCP SPT=12334 DPT=2975 SEQ=0  
ACK=2060489490 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:14:52 gizmo kernel: NET: 26 messages suppressed.
Dec 25 14:14:52 gizmo kernel: ip_conntrack_tcp: INVALID: invalid SYN  
(ignored) SRC=81.218.218.159 DST=22.22.22.22 LEN=48 TOS
=0x00 PREC=0x00 TTL=113 ID=32073 DF PROTO=TCP SPT=5662 DPT=1703  
SEQ=3478352784 ACK=1939099 WINDOW=17424 RES=0x00 ACK SYN URG
P=0 OPT (020405AC01010402)
Dec 25 14:14:57 gizmo kernel: NET: 24 messages suppressed.
Dec 25 14:14:57 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=65.87.147.230 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=236 ID=4999 PROTO=TCP SPT=45685 DPT=4775 SEQ=0  
ACK=1929624992 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:02 gizmo kernel: NET: 27 messages suppressed.
Dec 25 14:15:02 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=83.31.233.49 DST=22.22.22.22 LEN=40 TOS=0
x00 PREC=0x00 TTL=59 ID=4266 PROTO=TCP SPT=4661 DPT=3024 SEQ=0  
ACK=2066681917 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:07 gizmo kernel: NET: 21 messages suppressed.
Dec 25 14:15:07 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=217.226.253.221 DST=22.22.22.22 LEN=40 TO
S=0x00 PREC=0x00 TTL=116 ID=40588 PROTO=TCP SPT=4662 DPT=3048 SEQ=0  
ACK=2069063385 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:12 gizmo kernel: NET: 21 messages suppressed.
Dec 25 14:15:12 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=24.172.182.40 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=40 ID=57315 PROTO=TCP SPT=4662 DPT=1223 SEQ=0  
ACK=1689537525 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:17 gizmo kernel: NET: 26 messages suppressed.
Dec 25 14:15:17 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=82.80.17.22 DST=22.22.22.22 LEN=40 TOS=0x
00 PREC=0x00 TTL=47 ID=6248 PROTO=TCP SPT=5662 DPT=3052 SEQ=0  
ACK=2070513242 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:22 gizmo kernel: NET: 25 messages suppressed.
Dec 25 14:15:22 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=62.0.114.140 DST=22.22.22.22 LEN=40 TOS=0
x00 PREC=0x00 TTL=112 ID=20330 PROTO=TCP SPT=5662 DPT=1737 SEQ=0  
ACK=1971649 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:27 gizmo kernel: NET: 29 messages suppressed.
Dec 25 14:15:27 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=82.83.241.247 DST=22.22.22.22 LEN=40 TOS=
0x00 PREC=0x00 TTL=115 ID=21621 PROTO=TCP SPT=4662 DPT=2969 SEQ=0  
ACK=9477194 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:32 gizmo kernel: NET: 22 messages suppressed.
Dec 25 14:15:32 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=213.60.104.166 DST=22.22.22.22 LEN=40 TOS
=0x00 PREC=0x00 TTL=115 ID=50605 PROTO=TCP SPT=4662 DPT=2983 SEQ=0  
ACK=9483240 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:37 gizmo kernel: NET: 16 messages suppressed.
Dec 25 14:15:37 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=81.218.236.158 DST=22.22.22.22 LEN=40 TOS
=0x00 PREC=0x00 TTL=112 ID=10848 PROTO=TCP SPT=5662 DPT=1757 SEQ=0  
ACK=1991635 WINDOW=0 RES=0x00 ACK RST URGP=0
Dec 25 14:15:42 gizmo kernel: NET: 12 messages suppressed.
Dec 25 14:15:42 gizmo kernel: ip_conntrack_tcp: INVALID: invalid SYN  
(ignored) SRC=82.254.73.37 DST=22.22.22.22 LEN=48 TOS=0
x00 PREC=0x00 TTL=116 ID=22080 DF PROTO=TCP SPT=4662 DPT=2989  
SEQ=1583196893 ACK=9483243 WINDOW=16944 RES=0x00 ACK SYN URGP=
0 OPT (0204058401010402)
Dec 25 14:15:47 gizmo kernel: NET: 10 messages suppressed.
Dec 25 14:15:47 gizmo kernel: ip_conntrack_tcp: INVALID: invalid RST  
(ignored) SRC=64.230.127.202 DST=22.22.22.22 LEN=40 TOS
=0x00 PREC=0x00 TTL=111 ID=25587 PROTO=TCP SPT=46885 DPT=1804 SEQ=0  
ACK=881916807 WINDOW=0 RES=0x00 ACK RST URGP=0
janek.log lines 17-47/47 (END)

What is this and how close this log ? Where is problem ?

-- 
Pozdrawiam Konsar konsar{at}brod{dot}pl
