Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSHZXnu>; Mon, 26 Aug 2002 19:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSHZXnu>; Mon, 26 Aug 2002 19:43:50 -0400
Received: from p50838C89.dip.t-dialin.net ([80.131.140.137]:7183 "EHLO
	calista.inka.de") by vger.kernel.org with ESMTP id <S311025AbSHZXns>;
	Mon, 26 Aug 2002 19:43:48 -0400
Date: Tue, 27 Aug 2002 01:48:04 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and full ipv6 - will it happen?
Message-ID: <20020826234804.GA13520@lina.inka.de>
References: <20020821220313.GA25141@lina.inka.de> <Pine.LNX.4.44.0208261149170.6621-100000@betelgeuse.compendium-tech.com> <20020826215123.GA22750@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020826215123.GA22750@alcove.wittsend.com>
User-Agent: Mutt/1.4i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 05:51:23PM -0400, Michael H. Warfield wrote:
> 	My only other annoynance right now is the default ip6 route on my
> ipv6 router (RedHat 7.3).  It's not working (or doesn't seem to be)!  I
> have a 6bone allocation from Freenet6 (3ffe:b80:c84::/48) with about a
> half a dozen SLA subnets and several routers.  If I assign a default route
> (::/0) on the main router back down my Freenet6 tunnel, weird things happen.

the linux kernel does ignore the ::/0 route if it is in forwarding not, I
guess this is since it is asumed, that the user knows what he is doing and
does not want to do that. You can use 2000::/2 instead.

> This has been noticed and mentioned by others on the 6bone and freenet6
> lists.  Seems to be peculiar to Linux.

it is by intention, yes.

> 	The default routers on the leaf workstations (autoconfigured from
> router advertisements) seem to work fine though.

yes it deoeds on the ipforward setting.


BTW: i am working a bit on net-tools and ipv6, like:

calista:~# netstat -tl
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 *:1024                  *:*                     LISTEN
tcp        0      0 *:5269                  *:*                     LISTEN
...
tcp        0      0 calista.inka.de:domain  *:*                     LISTEN
tcp6       0      0 *:auth                  *:*                     LISTEN
tcp6       0      0 *:ssh                   *:*                     LISTEN
tcp6       0      0 *:smtp                  *:*                     LISTEN


i am not yet sure about the wildcard address and the port separator, but I
like the tcp6 :)


ifconfig may get a more BSDish look, also:

# ./ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500  metric 1
        inet 10.0.0.3  netmask 255.255.255.0  broadcast 10.0.0.255
        inet6 3ffe:400:4f0:ffff::3  prefixlen 112  scopeid 0x0<global>
        inet6 fe80::2e0:7dff:fe92:1f0b  prefixlen 10  scopeid 0x20<link>
        ether 00:e0:7d:92:1f:0b  txqueuelen 100  (Ethernet)
        RX packets 2581434  bytes 1632512018 (1.5 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2031678  bytes 1202569629 (1.1 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 9  base 0x9000

Greetings
Bernd
