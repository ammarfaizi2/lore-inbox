Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288675AbSA3Gvq>; Wed, 30 Jan 2002 01:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288685AbSA3Gvg>; Wed, 30 Jan 2002 01:51:36 -0500
Received: from pool-151-204-77-12.delv.east.verizon.net ([151.204.77.12]:58376
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S288675AbSA3Gv0>; Wed, 30 Jan 2002 01:51:26 -0500
Date: Wed, 30 Jan 2002 01:50:40 -0500
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: Netfilter(MASQ) and PPPoE problem? (2.4.17)
Message-ID: <20020130015040.A19998@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Heyla, folks.  I've got an interesting little report for y'all,
was hoping to get a bit more insight, 'cause I'm rather stumped on it,
and can't really make heads or tails of it.  I've got a DSL with PPPoE
set up on the router (running 2.4.17, with NAT) and seem to be having
problems getting to web sites from client machines behind the firewall.

	What makes it so curious is that this happens with only a
selection of web servers out there, though the number for me seems to be
growing, unfortunately.
	When I use Lynx from the router, I can get to any site out
there on the Internet that I choose.  My fire walling rules are simple:
Accepts everything incoming, and outgoing, and masquerades anything
going out from the LAN to the world beyond through the interfaces of
ppp0 and ppp1 (ppp0 being the PPPoE interface through eth1, ppp1 being
the 'backup' dial-up service.)
	The other curious thing is when I route traffic to a troubled
site through the modem interface (ppp1), I can access things just fine.

	After wading through some packet captures targeting this
problem, I've noticed that when sending a request from one of the
machines behind the NAT box, the standard handshake is processed, then
the HTTP get is sent, and the connection is dropped immediately, but
from the NAT box itself, there's an ACK sent, then the Web server sends
the information with a HTTP/200 response.
	
	I've been trying to puzzle this out for weeks, and due to all
the mitigating factors, the only theory that I can come up with is a
possible bug in the interaction between MASQ and PPPoE, as switching to
the straight PPP account works just fine.

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net:3000/~magamo/index.htm
