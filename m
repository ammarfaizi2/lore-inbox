Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSHYRxG>; Sun, 25 Aug 2002 13:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSHYRxG>; Sun, 25 Aug 2002 13:53:06 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:49302 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317457AbSHYRxG>; Sun, 25 Aug 2002 13:53:06 -0400
Message-ID: <3D691AC8.DBF7F50E@wanadoo.fr>
Date: Sun, 25 Aug 2002 19:58:32 +0200
From: Christophe Devalquenaire <C.Devalquenaire@wanadoo.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2.5 Problem ne.c driver
References: <Pine.LNX.4.44.0208251222280.1561-100000@beohost.scyld.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> 
> On Sun, 25 Aug 2002, Christophe Devalquenaire wrote:
> > kris wrote:
> > > kris wrote:
> > > >
> > > > I have 2 ne2000 isa cards (10Mbps for each) and with this versions of
> > > > kernel the bandwith is divided by 2. So 2*5Mbps = 10Mbps instead of
> > > > 2*10Mbps=20Mbps.
> > > > I try to fix the pbm.
> > >
> > > perhaps a bug exists on the dispatcher when 2 identical cards exist.
> > > Anyone have 2 identical cards for test ?
> >
> > After other tries, the ne.c file is buggy. Confirmation.
> > I investigate. Anyone helps me ?
> 
> Do you have evidence of a specific problem?
> Or the same hardware running faster with other drivers or kernel versions?
> 
> This sounds as if you are just running out of ISA bus bandwidth...

My configuration : a server with 2 cards NE2000(10 Mbps), a machine with
2 cards : 1 NE2000(ISA) and 1 3C905b(PCI).
server : NE2000 <-> workstation : NE2000  in 192.168.1.X
server : NE2000 <-> workstation : 3C905b  in 192.168.0.X

I try with a 2.4.6, 2.4.15, and 2.5.31. there is near from no
differences in the code of ne.c, gkrellm tells me that when I download
on both cards big files (for tests), the bandwidth falls to 5Mbps for
each card.
If 1 download stops, the other bandwidth is up to 10Mbps immediatly.

No other ISA card is used on the server.
