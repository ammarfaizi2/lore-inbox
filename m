Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129566AbRBESPq>; Mon, 5 Feb 2001 13:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129711AbRBESPg>; Mon, 5 Feb 2001 13:15:36 -0500
Received: from grunt.okdirect.com ([209.54.94.12]:26381 "HELO mail.pyxos.com")
	by vger.kernel.org with SMTP id <S129232AbRBESP0>;
	Mon, 5 Feb 2001 13:15:26 -0500
Message-Id: <5.0.2.1.2.20010131134730.02eb4fe8@209.54.94.12>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 05 Feb 2001 12:15:22 -0600
To: linux-kernel@vger.kernel.org
From: Daniel Walton <zwwe@opti.cgi.net>
Subject: 2.4.x latency
In-Reply-To: <3A75BBB2.63CE124C@napster.com>
In-Reply-To: <5.0.2.1.2.20010128140720.03465e38@209.54.94.12>
 <5.0.2.1.2.20010128140720.03465e38@209.54.94.12>
 <5.0.2.1.2.20010129002217.03362fe0@209.54.94.12>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm experiencing an odd behavior under the 2.4.0 and 2.4.1 kernels on two 
of my servers.  I'm experiencing high latency periods.  Sometimes the 
periods are long and other times they are short.  As a test I setup three 
ping processes on one of the servers all pinging the same destination on 
the LAN at the same time.  Below is a sample of the ping output.  The 
strange thing is that while all three ping processes went through the 
latency cycle, they each did it at different times.  This tells me that 
surely this isn't a network response issue or else all ping processes would 
show the latency at the same time.

64 bytes from (216.185.106.18): icmp_seq=55 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=56 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=57 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=58 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=59 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=60 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=61 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=62 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=63 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=64 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=65 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=66 ttl=255 time=4121.7 ms
64 bytes from (216.185.106.18): icmp_seq=67 ttl=255 time=3259.0 ms
64 bytes from (216.185.106.18): icmp_seq=68 ttl=255 time=2384.6 ms
64 bytes from (216.185.106.18): icmp_seq=69 ttl=255 time=1511.2 ms
64 bytes from (216.185.106.18): icmp_seq=70 ttl=255 time=666.1 ms
64 bytes from (216.185.106.18): icmp_seq=71 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=72 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=73 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=74 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=75 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=76 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=77 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=78 ttl=255 time=0.1 ms
64 bytes from (216.185.106.18): icmp_seq=79 ttl=255 time=0.1 ms


The hardware in question are two Athlon servers with VIA KT133 chipset, 
512Mb RAM, and IDE drives.  One server uses the tulip network driver for a 
Netgear FA-310.  The other uses the NatSim DP83810 network driver for the 
FA-312 and both exhibit the same problem.  I've had 3com 3c900 series cards 
in the machines as well and the problem still persisted.

One other interesting little fact is that if I ping the problem machines 
from a good machine I always get 0.1 ms response times, even while the 
pings from the problem machines are showing latency.

I hope this is enough information for someone to work with.  I'm at a loss 
for what the problem is and unfortunately I'm no kernel hacker.  I 
appreciate any help you guys can offer.

Thank you,
Daniel Walton




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
