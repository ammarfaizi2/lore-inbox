Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVGINZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVGINZq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGINZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:25:45 -0400
Received: from smtp15.wanadoo.fr ([193.252.23.84]:20601 "EHLO
	smtp15.wanadoo.fr") by vger.kernel.org with ESMTP id S261383AbVGINZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:25:36 -0400
X-ME-UUID: 20050709132523288.465D87000081@mwinf1502.wanadoo.fr
Message-ID: <19494147.1120915523280.JavaMail.www@wwinf1505>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: sis190
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.251.50.60]
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-CC: |~||~||~||~||~||~|
X-WUM-REPLYTO: |~|
Date: Sat,  9 Jul 2005 15:25:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 6 Jul 2005 23:29:25 +0200
> From: Francois Romieu <romieu@fr.zoreil.com>
[...]
> The patchkit of the day should fix these issues:
> http://www.zoreil.com/~romieu/sis190/20050706-2.6.13-rc1/patches
[...]
> I'd appreciate if you could check the allowed frame size range, say
> ping -s 1468 ... ping -s 1473 to compare with Lars's results.
> 
> You can add something like a ping -q -l 48 -s 64 -f to your tests and
> increase the 48 and NUM_{RX/TX}_DESC but I am not sure that the remote
> 8139 will be able to go terribly far. If it performs well, pktgen
> could be useful too.

I don't receive Lars's results, but here are my results.
As far as i know, they seem pretty good...

# ping -s 1468 -c2 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 1468(1496) bytes of data.
1476 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=0.762 ms
1476 bytes from 10.169.21.1: icmp_seq=1 ttl=64 time=0.638 ms

--- 10.169.21.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.638/0.700/0.762/0.062 ms, pipe 2

# ping -s 1469 -c2 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 1469(1497) bytes of data.
1477 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=0.647 ms
1477 bytes from 10.169.21.1: icmp_seq=1 ttl=64 time=0.630 ms

--- 10.169.21.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.630/0.638/0.647/0.026 ms, pipe 2

# ping -s 1470 -c2 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 1470(1498) bytes of data.
1478 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=0.670 ms
1478 bytes from 10.169.21.1: icmp_seq=1 ttl=64 time=0.650 ms

--- 10.169.21.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.650/0.660/0.670/0.010 ms, pipe 2

# ping -s 1471 -c2 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 1471(1499) bytes of data.
1479 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=0.660 ms
1479 bytes from 10.169.21.1: icmp_seq=1 ttl=64 time=0.612 ms

--- 10.169.21.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.612/0.636/0.660/0.024 ms, pipe 2

# ping -s 1472 -c2 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 1472(1500) bytes of data.
1480 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=0.655 ms
1480 bytes from 10.169.21.1: icmp_seq=1 ttl=64 time=0.637 ms

--- 10.169.21.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.637/0.646/0.655/0.009 ms, pipe 2

# ping -s 1473 -c2 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 1473(1501) bytes of data.
1481 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=0.745 ms
1481 bytes from 10.169.21.1: icmp_seq=1 ttl=64 time=0.747 ms

--- 10.169.21.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.745/0.746/0.747/0.001 ms, pipe 2

# ping -s 1473 -c2 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 1473(1501) bytes of data.
1481 bytes from 10.169.21.1: icmp_seq=0 ttl=64 time=0.745 ms
1481 bytes from 10.169.21.1: icmp_seq=1 ttl=64 time=0.747 ms

--- 10.169.21.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1000ms
rtt min/avg/max/mdev = 0.745/0.746/0.747/0.001 ms, pipe 2


NUM_TX_DESC=256
NUM_RX_DESC=256
link partner = r8169

# ping -q -l 256 -s 64 -f 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 64(92) bytes of data.

--- 10.169.21.1 ping statistics ---
2924162 packets transmitted, 2924162 received, 0% packet loss, time 143582ms
rtt min/avg/max/mdev = 0.050/3.922/116.174/10.601 ms, pipe 257, ipg/ewma 0.049/0.114 ms


# ping -q -l 512 -s 64 -f 10.169.21.1
PING 10.169.21.1 (10.169.21.1) 64(92) bytes of data.

--- 10.169.21.1 ping statistics ---
1626523 packets transmitted, 1542700 received, 5% packet loss, time 65081ms
rtt min/avg/max/mdev = 0.050/1.167/56.088/5.896 ms, pipe 513, ipg/ewma 0.040/0.108 ms

# cat /proc/net/pktgen/eth0
Params: count 10000000  min_pkt_size: 60  max_pkt_size: 60
     frags: 0  delay: 0  clone_skb: 1000000  ifname: eth0
     flows: 0 flowlen: 0
     dst_min: 10.169.21.1  dst_max:
     src_min:   src_max:
     src_mac: 00:11:2F:E9:42:70  dst_mac: 00:40:F4:A8:70:BC
     udp_src_min: 9  udp_src_max: 9  udp_dst_min: 9  udp_dst_max: 9
     src_mac_count: 0  dst_mac_count: 0
     Flags: IPDST_RND
Current:
     pkts-sofar: 8699475  errors: 0
     started: 1120913419217947us  stopped: 1120913484497743us idle: 0us
     seq_num: 8699485  cur_dst_mac_offset: 0  cur_src_mac_offset: 0
     cur_saddr: 0x1515a90a  cur_daddr: 0x115a90a
     cur_udp_dst: 9  cur_udp_src: 9
     flows: 0
Result: OK: 65279796(c65279796+d0) usec, 8699475 (60byte,0frags)
  133264pps 63Mb/sec (63966720bps) errors: 0


"ethtool -s eth0 ..." does not freeze the station anymore, but
"autoneg off" does not work properly :

# ethtool -s eth0 speed 10 duplex half autoneg off
# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Current message level: 0x00000037 (55)
        Link detected: yes
# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: on
        Current message level: 0x00000037 (55)
        Link detected: yes

The values written in StationControl are probaly wrong,
but i really don't know what i can try...


> (on an unrelated note, something enabled the "send mail as html" checkbox
> in your mail user agent: you may consider removing it).

Sorry, but i must use Webmail, as my provider's smtp is open-relay, and i don't
how the webmail thing deals with my messages...


Regards
Pascal





