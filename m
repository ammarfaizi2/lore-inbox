Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287545AbSALVhp>; Sat, 12 Jan 2002 16:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287518AbSALVhf>; Sat, 12 Jan 2002 16:37:35 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:8901 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S287513AbSALVhU>; Sat, 12 Jan 2002 16:37:20 -0500
Message-Id: <200201122137.g0CLbCR26740@jupiter.cs.uni-dortmund.de>
To: timothy.covell@ashavan.org
cc: "Pei Zheng" <zhengpei@msu.edu>, linux-kernel@vger.kernel.org
Subject: Re: strange kernel message when hacking the NIC driver 
In-Reply-To: Message from Timothy Covell <timothy.covell@ashavan.org> 
   of "Fri, 11 Jan 2002 05:55:20 CST." <200201111159.g0BBxCSr001144@svr3.applink.net> 
Date: Sat, 12 Jan 2002 22:37:11 +0100
From: "Prof. Brand " <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell <timothy.covell@ashavan.org> said:
> On Thursday 10 January 2002 23:20, Timothy Covell wrote:

> Let me clarify what I said earlier.  You cannot have
> identical MAC addresses on two different NICs.

You sure can. Look at your nearest Sun machine with two NICs for an
example.

>                                                Indeed,
> it is impossible w/o trying to fool the kernel into
> redefining the NICs hardware based MAC address. 

It is not "fooling", you can set the MAC address on some cards by software.
Kernel has nothing to do with it.

> As concerns TCP/IP, you can define two NICs to have the
> same IP address, but you will only end up confusing
> your switch/HUB router which assumes a 1 to 1 mapping
> of MACs to IPs.   The whole point of ICMP is to
> discover this mapping via ARP requests.

TCP/IP is a 4(5) level protocol stack:

0 Hardware [Cribbed from ISO]
1 Device driver
2 IP [Includes ICMP]
3 TCP and UDP
4 Applications

A switch/hub works on Ethernet frames, i.e., at the hardware level. It has
absolutely no idea of mappings of MACs to IPs.

ICMP is part of the IP layer, the whole of the mapping of IPs to MACs is
(conceptually at least) part of the device driver layer. This includes ARP,
DHCP et al. ICMP has nothing to do with ARP.
-- 
Horst von Brand			     http://counter.li.org # 22616
