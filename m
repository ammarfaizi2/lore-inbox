Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbVI1A3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbVI1A3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVI1A3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:29:46 -0400
Received: from lucidpixels.com ([66.45.37.187]:62080 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751166AbVI1A3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:29:46 -0400
Date: Tue, 27 Sep 2005 20:29:44 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: TCP=828mbps, UDP=1mbps? (both running 2.6.13.2)
Message-ID: <Pine.LNX.4.63.0509272028390.2652@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any idea why with TCP I get 828 megabits on my gigabit connection but only 
1.05 megabits with UDP?

Using iperf to benchmark.

TCP
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 192.168.1.12 port 5001 connected with 192.168.1.253 port 
48853
[  4]  0.0-35.1 sec  3.38 GBytes    828 Mbits/sec


UDP
------------------------------------------------------------
Server listening on UDP port 5001
Receiving 1470 byte datagrams
UDP buffer size:   101 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.12 port 5001 connected with 192.168.1.253 port 
32773
[  3]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec  0.043 ms    0/  893 (0%)


p34:~$ netstat -i
Kernel Interface table
Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR 
Flg
eth0   1500 0   1266337      0      0      0  2588651      0      0      0 
BMRU
eth1   1500 0      2358      0      0      0     2229      0      0      0 
BMRU
eth2   1500 0     39706      0      0      0     5747      0      0      0 
BMNRU
lo    16436 0       184      0      0      0      184      0      0      0 
LRU

box2:~$ netstat -i
Kernel Interface table
Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR 
Flg
eth0   1500 0   2955176      0      0      0  3696501      0      0      0 
BMRU
lo    16436 0       612      0      0      0      612      0      0      0 
LRU


