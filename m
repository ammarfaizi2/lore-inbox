Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaNns>; Sun, 31 Dec 2000 08:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaNni>; Sun, 31 Dec 2000 08:43:38 -0500
Received: from swm.pp.se ([195.54.133.5]:48132 "EHLO uplift.swm.pp.se")
	by vger.kernel.org with ESMTP id <S129324AbQLaNnT>;
	Sun, 31 Dec 2000 08:43:19 -0500
Date: Sun, 31 Dec 2000 14:12:51 +0100 (CET)
From: Mikael Abrahamsson <swmike@swm.pp.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: path MTU bug still there?
In-Reply-To: <Pine.LNX.4.30.0012311449250.9644-100000@shodan.irccrew.org>
Message-ID: <Pine.LNX.4.30.0012311409390.14553-100000@uplift.swm.pp.se>
Organization: People's Front Against WWW
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Jussi Hamalainen wrote:

> I'm running 2.2.18 vanilla and my firewall rules aren't blocking
> ICMP. The ethernet interfaces and the ISDN link have an MTU of
> 1500 and the GRE tunnel has an MTU of 1514 (courtesy of Cisco).

How is this solved? Personally, I am behind a CIPE tunnel with an MTU of
1442 or something like that. I experienced problems to some places and
have solved it by using the linux box as socks5 proxy (only napster) and
webproxy (squid). When the linux box does TCP to the outside it'll use the
MTU of the tunnel (default route is the tunnel) and thus works perfectly
(since TCP MSS will be set low enough to fit into the tunnel).

Could it be some kind of incompability at the tunnel level that make you
unable to receive large packets over the tunnel? Have you tcpdump:ed to
see if the tunnel packets actually make it the way they should?

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
