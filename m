Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264869AbRFTJyy>; Wed, 20 Jun 2001 05:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264870AbRFTJyn>; Wed, 20 Jun 2001 05:54:43 -0400
Received: from firewall.sch.bme.hu ([152.66.215.213]:1664 "EHLO
	singular.sch.bme.hu") by vger.kernel.org with ESMTP
	id <S264869AbRFTJyk>; Wed, 20 Jun 2001 05:54:40 -0400
Date: Wed, 20 Jun 2001 11:56:36 +0200 (CEST)
From: =?ISO-8859-2?Q?Kajt=E1r_Zsolt?= <soci@firewall.sch.bme.hu>
To: linux-kernel@vger.kernel.org
cc: rusty@rustcorp.com.au
Subject: Re: Iptables ipt_unclean bug?
Message-ID: <Pine.LNX.4.21.0106201130470.274-100000@firewall.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <Pine.LNX.4.21.0106190104020.414-100000@firewall.sch.bme.hu>
> you write:
> >
> > Hi all!
> >
> > I think it's possible to hang the kernel useing isic 0.05
> > (www.packetfactory.net/Projects/ISIC/), when there's a unclean match
> > in iptables rules.

> Thanks for the bug report. I've just done an audit of the unclean
> code: patch against 2.4.5 is below. There were some bad thinkos there,
> two fatal.

2 infinite loops ;)

After patching now everything seems to be ok.

But there must be some other bug somewhere in TCP/IP stack or af_packet
(or my machine is just crap ;) ), because after ~5 mins I can still hang
my kernel on loopback WITHOUT iptables... Will check which one is on fault
on my home network...

							-soci-


