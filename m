Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130102AbRBIFWr>; Fri, 9 Feb 2001 00:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130116AbRBIFW2>; Fri, 9 Feb 2001 00:22:28 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:27918 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S130102AbRBIFWQ>; Fri, 9 Feb 2001 00:22:16 -0500
Date: Thu, 8 Feb 2001 21:22:15 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ARP out the wrong interface
In-Reply-To: <Pine.LNX.4.33.0102082058060.21439-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.33.0102082121230.21439-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops typo.

On Thu, 8 Feb 2001, dean gaudet wrote:

> this appears to occur with both 2.2.16 and 2.4.1.
>
> server:
>
> eth0 is 192.168.250.11 netmask 255.255.255.0
> eth1 is 192.168.251.11 netmask 255.255.255.0
>
> they're both connected to the same switch.
>
> client:
>
> eth0 is 192.168.251.11 netmask 255.255.255.0

er, i meant to say the client is 192.168.251.25 there.

> connected to the same switch as both of server's eth.
>
> on client i try "ping 192.168.251.11".
>
> responses come back from both eth0 and eth1, listing each of their
> respective MAC addresses...  it's essentially a race condition at this
> point as to whether i'll get the right MAC address.  ("right" means the
> MAC for server:eth1).
>
> client# tcpdump -n arp
> Kernel filter, protocol ALL, datagram packet socket
> tcpdump: listening on all devices
> 21:03:05.695089 eth0 > arp who-has 192.168.251.11 tell 192.168.251.25 (0:3:47:0:25:80)
> 21:03:05.695405 eth0 < arp reply 192.168.251.11 is-at 0:d0:b7:be:3e:aa (0:3:47:0:25:80)
> 21:03:05.695523 eth0 < arp reply 192.168.251.11 is-at 0:d0:b7:1f:ea:35 (0:3:47:0:25:80)
>
>
> server# cat /proc/sys/net/ipv4/ip_forward
> 0
> server# cat /proc/sys/net/ipv4/conf/*/proxy_arp
> 0
> 0
> 0
> 0
> 0
> 0
> 0
>
> is this expected?  it seems broken.
>
> thanks
> -dean
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
