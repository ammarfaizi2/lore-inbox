Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBZXaD>; Mon, 26 Feb 2001 18:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRBZX3s>; Mon, 26 Feb 2001 18:29:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18847 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129232AbRBZX3j>;
	Mon, 26 Feb 2001 18:29:39 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.58854.215318.882641@pizda.ninka.net>
Date: Mon, 26 Feb 2001 15:25:26 -0800 (PST)
To: michael@linuxmagic.com
Cc: Jan Rekorajski <baggins@sith.mimuw.edu.pl>, Chris Wedgwood <cw@f00f.org>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
        waltje@uWalt.NL.Mugnet.ORG
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
In-Reply-To: <0102261546570H.02007@mistress>
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net>
	<20010225163836.A12173@metastasis.f00f.org>
	<20010225045420.B10281@sith.mimuw.edu.pl>
	<0102261546570H.02007@mistress>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Peddemors writes:
 > A few things.. why is ip.h not part of the linux/include/net rather than 
 > linux/include/linux hierachy?

Exported to older userlands...

 > Defined items that are not used anywhere in the source..
 > Can any of them be deleted now?
 > <see below>

So what, userland makes use of them :-)

 > Also, I was looking into some RFC 1812 stuff. (Thanks for nothing Dave :) and 
 > was looking at 4.2.2.6 where it mentions that a router MUST implement the End 
 > of Option List option..  Havent' figured out where that is implememented yet..

egrep "IPOPT_END" net/ipv4/ip_options.c

You just aren't looking hard enough.

 > Also was trying to figure out some things. 
 > I want to create a new ip_option for use in some DOS protection experiments.
 > I have a whole 40 bytes (+/-) to share...  Now although I don't see anything 
 > explicitly prohibiting the use of unused IP Header option space, I know that 
 > it really was designed for use by the sending parties, and not routers in 
 > between.. Has anyone seen any RFC that explicitly says I MUST NOT?

Not to my knowledge.  Routers already change the time to live field,
so I see no reason why they can't do smart things with special IP
options either (besides efficiency concerns :-).

Later,
David S. Miller
davem@redhat.com
