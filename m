Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSKDXwL>; Mon, 4 Nov 2002 18:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSKDXwL>; Mon, 4 Nov 2002 18:52:11 -0500
Received: from news.cistron.nl ([62.216.30.38]:39174 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S262913AbSKDXwK>;
	Mon, 4 Nov 2002 18:52:10 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Linux v2.5.46
Date: Mon, 4 Nov 2002 23:58:06 +0000 (UTC)
Organization: Cistron
Message-ID: <aq71ie$vce$1@ncc1701.cistron.net>
References: <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1036454286 32142 62.216.29.67 (4 Nov 2002 23:58:06 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0211041508020.1832-100000@penguin.transmeta.com>,
Linus Torvalds  <torvalds@transmeta.com> wrote:
>Ok, our dear master.kernel.org seems to be back from the dead, which means 
>that I can punish it some more and upload stuff to it again. 

Netfilter compilation fails:

net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
net/ipv4/netfilter/ipt_TCPMSS.c:88: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:91: structure has no member named `pmtu'
net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

Fortunately, reconfiguring the kernel halfway the compilation
(turn of TCP MSS netfilter options) and resuming the compile
actually works.

Mike.

