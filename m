Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970941-23996>; Sat, 21 Mar 1998 01:12:18 -0500
Received: from shorelink.com ([204.87.183.62]:1237 "EHLO shorelink.com" ident: "root") by vger.rutgers.edu with ESMTP id <970930-23996>; Sat, 21 Mar 1998 01:11:00 -0500
Date: Fri, 20 Mar 1998 14:24:24 -0800 (PST)
From: George Bonser <grep@oriole.sbay.org>
To: linux-kernel@vger.rutgers.edu
Subject: Multicast and PPP interfaces
Message-ID: <Pine.LNX.3.96.980320141238.684B-100000@calvin.shorelink.com>
X-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


kernel 2.0.32, gated 3.5.8

I am having a heck of a time trying to get gated to join 224.0.0.5 OSPF
multicast.  I have configured the kernel for multicasting, it reports the
following at startup:

...
NET3: Unix domain sockets 0.13 for Linux NET3.035.
Swansea University Computer Society TCP/IP for NET3.034
IP Protocols: IGMP, ICMP, UDP, TCP
Linux IP multicast router 0.07.
...

I am not sure if it is a gated problem or a kernel problem.  The PPP
interface is set multicasting:

ppp0      Link encap:Point-to-Point Protocol  
          inet addr:204.87.183.62  P-t-P:204.87.183.61
Mask:255.255.255.252
          UP POINTOPOINT RUNNING MULTICAST  MTU:1500  Metric:1

The gated configuration is set to multicasting.  I am sending out hellos
but they are going unicast.  The hellos from my neighbor on the multicast
address are being ignored by me.

I am sending this: 14:21:44.652600 shorelink.com >
kjsl-dialup-bonser.kjsl.com: OSPFv2-hello 44: rtrid calvin.shorelink.com
area 0.0.25.196 [tos 0xc0]

WHat I am seeing is this:

 kjsl-dialup-bonser.kjsl.com > OSPF-ALL.MCAST.NET: OSPFv2-hello 44: rtrid
172.17.64.2 area 0.0.25.196 [tos 0xc0] [ttl 1]

It is acting either as 

George Bonser 
Just be thankful that Microsoft does not manufacture pharmaceuticals.
http://www.debian.org
Debian/GNU Linux ... the maintainable operating system.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
