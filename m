Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSHYUfm>; Sun, 25 Aug 2002 16:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSHYUfm>; Sun, 25 Aug 2002 16:35:42 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:21173 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317512AbSHYUfl>;
	Sun, 25 Aug 2002 16:35:41 -0400
Date: Sun, 25 Aug 2002 22:39:11 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Christophe Devalquenaire <C.Devalquenaire@wanadoo.fr>
Cc: Donald Becker <becker@scyld.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2.5 Problem ne.c driver
Message-ID: <20020825223911.A27962@ucw.cz>
References: <Pine.LNX.4.44.0208251222280.1561-100000@beohost.scyld.com> <3D691AC8.DBF7F50E@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D691AC8.DBF7F50E@wanadoo.fr>; from C.Devalquenaire@wanadoo.fr on Sun, Aug 25, 2002 at 07:58:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 07:58:32PM +0200, Christophe Devalquenaire wrote:

> Donald Becker wrote:
> > 
> > On Sun, 25 Aug 2002, Christophe Devalquenaire wrote:
> > > kris wrote:
> > > > kris wrote:
> > > > >
> > > > > I have 2 ne2000 isa cards (10Mbps for each) and with this versions of
> > > > > kernel the bandwith is divided by 2. So 2*5Mbps = 10Mbps instead of
> > > > > 2*10Mbps=20Mbps.
> > > > > I try to fix the pbm.
> > > >
> > > > perhaps a bug exists on the dispatcher when 2 identical cards exist.
> > > > Anyone have 2 identical cards for test ?
> > >
> > > After other tries, the ne.c file is buggy. Confirmation.
> > > I investigate. Anyone helps me ?
> > 
> > Do you have evidence of a specific problem?
> > Or the same hardware running faster with other drivers or kernel versions?
> > 
> > This sounds as if you are just running out of ISA bus bandwidth...
> 
> My configuration : a server with 2 cards NE2000(10 Mbps), a machine with
> 2 cards : 1 NE2000(ISA) and 1 3C905b(PCI).
> server : NE2000 <-> workstation : NE2000  in 192.168.1.X
> server : NE2000 <-> workstation : 3C905b  in 192.168.0.X
> 
> I try with a 2.4.6, 2.4.15, and 2.5.31. there is near from no
> differences in the code of ne.c, gkrellm tells me that when I download
> on both cards big files (for tests), the bandwidth falls to 5Mbps for
> each card.
> If 1 download stops, the other bandwidth is up to 10Mbps immediatly.
> 
> No other ISA card is used on the server.

ISA has a maximum bandwidth usually about a megabyte per second in PIO
(io-port, which the NE2k uses) mode. That's 10MBps. With two cards, i
gets evenly distributed. What's so surprising here?

-- 
Vojtech Pavlik
SuSE Labs
