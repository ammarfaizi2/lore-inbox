Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281098AbRKEMaU>; Mon, 5 Nov 2001 07:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281099AbRKEMaK>; Mon, 5 Nov 2001 07:30:10 -0500
Received: from [202.56.254.10] ([202.56.254.10]:23619 "EHLO
	mtv01ex01.mindtree.com") by vger.kernel.org with ESMTP
	id <S281098AbRKEMaB> convert rfc822-to-8bit; Mon, 5 Nov 2001 07:30:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Change in source IP to local machines
Date: Mon, 5 Nov 2001 18:00:25 +0530
Message-ID: <1A9DB8F9CE0DE64BAC2BA2ACC4E367FE0136B9@mtv01ex02.mindtree.com>
Thread-Topic: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
Thread-Index: AcFl8lYF5v8KT2TbSOys7wreB1QbKAAAq2Vg
From: "Roma Bajpai" <romab@mindtree.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Nov 2001 12:30:26.0043 (UTC) FILETIME=[A575ACB0:01C165F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am working on a Network Address Translator and am trying out a few sample
programs to change the source and destination IPs of packets, at kernel
level. When I receive a packet I change the src IP to my machine's IP and
destination IP to another machine's. The destination machine doesnt receive
the packet. On the other hand when the src IP is changed to that of some
other machine (besides mine) the code works fine and the destination machine
receives the packets.  Please not that ip_forward has been enabled.

CONTROL FLOW AT KERNEL LEVEL :
Whenever a packet is received the function ip_rcv() gets called (present in
file /net/ipv4/ip_input.c). At the end of this function I change the source
and destination IPs.  Next ip_route_input() is called. This function tires to
route the the packet and in course calls a function fib_lookup() to see if
the routing table has the entry. The fib_lookup returns a result, the type of
which not being RTN_UNICAST. Since its not a unicast packet, control goes to
a label martian_source and the destination machine does not receive the
packet. I wanted to know if it is possible to forward a packet with the src
IP changed to the local IP.
Please do let me know if anyone can help me with this one.

Thanks & Regards,
Roma
