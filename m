Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132405AbRDJW0d>; Tue, 10 Apr 2001 18:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132400AbRDJW0X>; Tue, 10 Apr 2001 18:26:23 -0400
Received: from meatloop.andover.net ([209.192.217.120]:48256 "HELO
	meatloop.andover.net") by vger.kernel.org with SMTP
	id <S132370AbRDJW0R>; Tue, 10 Apr 2001 18:26:17 -0400
Date: Tue, 10 Apr 2001 18:24:46 -0400 (EDT)
From: Dave <daveo@osdn.com>
X-X-Sender: <count@meatloop.andover.net>
To: <linux-kernel@vger.kernel.org>
Subject: bizarre TCP behavior
Message-ID: <Pine.LNX.4.33.0104101809190.1468-100000@meatloop.andover.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am having a very strange problem in linux 2.4 kernels.  I have not set
any iptables rules at all, and there is no firewall blocking any of my
outgoing traffic.  At what seems like random selection, I can not connect
to IP's yet I can get ping replies from them.  Most IP's reply just fine,
but certain ones fail to send even an ACK.  This problem disappears when I
boot into 2.2.  Here is a brief example of what I am talking about:

meatloop:~>ping 204.202.131.229
PING 204.202.131.229 (204.202.131.229): 56 data bytes
64 bytes from 204.202.131.229: icmp_seq=0 ttl=42 time=114.7 ms
64 bytes from 204.202.131.229: icmp_seq=1 ttl=42 time=117.0 ms

 [iptraf output]

ICMP echo request (84 bytes) from 209.192.217.120 to 204.202.131.229 on eth0
ICMP echo reply (84 bytes) from 204.202.131.229 to 209.192.217.120 on eth0
ICMP echo request (84 bytes) from 209.192.217.120 to 204.202.131.229 on eth0
ICMP echo reply (84 bytes) from 204.202.131.229 to 209.192.217.120 on eth0


meatloop:~>telnet 204.202.131.229 80
Trying 204.202.131.229...
telnet: Unable to connect to remote host: Connection timed out

 [iptraf output]

209.192.217.120:32926              =       6             360   S---    eth0
204.202.131.229:80                 =       0               0   ----    eth0


and yet when I boot 2.2, I have not seen any problems of this nature.  Is
this a known issue?  Possibly a setting in /proc/sys/net/ipv4 that I dont
know about?  Thanks for your help...

	dave

