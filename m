Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289011AbSA3JdG>; Wed, 30 Jan 2002 04:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289013AbSA3Jcr>; Wed, 30 Jan 2002 04:32:47 -0500
Received: from mail.pyramid.de ([213.164.67.210]:27893 "EHLO
	EXCH01.intern.pyramid.de") by vger.kernel.org with ESMTP
	id <S289011AbSA3Jcn>; Wed, 30 Jan 2002 04:32:43 -0500
Message-ID: <3C57BD20.9000800@pyramid.de>
Date: Wed, 30 Jan 2002 10:30:08 +0100
From: Daniel Bunzendahl <daniel.bunzendahl@pyramid.de>
Reply-To: daniel.bunzendahl@pyramid.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Malcolm Mallardi <magamo@ranka.2y.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Netfilter(MASQ) and PPPoE problem? (2.4.17)
In-Reply-To: <20020130015040.A19998@trianna.upcommand.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Malcolm,
try to change the MTU on your clientmashines:
ifconfig eth0 mtu 1400

then connect again ...

this Problem comes with many Webservers use Loadbalancing and BigIP
because they answer with an different Packetsice and Providers like 
T-Online
block this ...

bye

 

Malcolm Mallardi wrote:

>	Heyla, folks.  I've got an interesting little report for y'all,
>was hoping to get a bit more insight, 'cause I'm rather stumped on it,
>and can't really make heads or tails of it.  I've got a DSL with PPPoE
>set up on the router (running 2.4.17, with NAT) and seem to be having
>problems getting to web sites from client machines behind the firewall.
>
>	What makes it so curious is that this happens with only a
>selection of web servers out there, though the number for me seems to be
>growing, unfortunately.
>	When I use Lynx from the router, I can get to any site out
>there on the Internet that I choose.  My fire walling rules are simple:
>Accepts everything incoming, and outgoing, and masquerades anything
>going out from the LAN to the world beyond through the interfaces of
>ppp0 and ppp1 (ppp0 being the PPPoE interface through eth1, ppp1 being
>the 'backup' dial-up service.)
>	The other curious thing is when I route traffic to a troubled
>site through the modem interface (ppp1), I can access things just fine.
>
>	After wading through some packet captures targeting this
>problem, I've noticed that when sending a request from one of the
>machines behind the NAT box, the standard handshake is processed, then
>the HTTP get is sent, and the connection is dropped immediately, but
>from the NAT box itself, there's an ACK sent, then the Web server sends
>the information with a HTTP/200 response.
>	
>	I've been trying to puzzle this out for weeks, and due to all
>the mitigating factors, the only theory that I can come up with is a
>possible bug in the interaction between MASQ and PPPoE, as switching to
>the straight PPP account works just fine.
>
>--
>Malcolm D. Mallardi - Dark Freak At Large
>"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
>AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
>http://ranka.2y.net:3000/~magamo/index.htm
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



