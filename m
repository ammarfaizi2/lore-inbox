Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTAOIa1>; Wed, 15 Jan 2003 03:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTAOIa0>; Wed, 15 Jan 2003 03:30:26 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:53778 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266010AbTAOIa0>; Wed, 15 Jan 2003 03:30:26 -0500
Message-Id: <200301150806.h0F86Ts05193@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: jt@hpl.hp.com, Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: 2.4.20-pre11: PCI Wavelan card loses connection
Date: Wed, 15 Jan 2003 10:06:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200301130821.h0D8Kis26772@Port.imtp.ilyichevsk.odessa.ua> <20030113172435.GC20409@bougret.hpl.hp.com>
In-Reply-To: <20030113172435.GC20409@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 January 2003 19:24, Jean Tourrilhes wrote:
> On Mon, Jan 13, 2003 at 10:20:14AM +0200, Denis Vlasenko wrote:
> > I bought a PCI wireless card, a DLink-520 (I think, I forgot
> > exactly (it's at home), anyway, lspci dump is below).
> >
> > We (my father and me) made a fairly long helical aerial.
> > We are trying to communicate over ~15 km with a small wireless
> > cell. (~10 hosts, one AP).
> >
> > We can successfully associate with it, signal is weak as expected.
> > But after a short while our eth0 seems to 'fall off the net'
> > and while it looks like we can send packets, we see no incoming
> > data at all.
> >
> > Since I have almost zero wireless experience, I'll be happy if
> > someone with said experience can read further and say what bites
> > us.
>
> 	Personally, I never managed to get this hardware to work at
> all. And Orinoco is known to have problems with PrismII cards. Please
> use the HostAP or linux-wlan-ng driver.

Count me in. I want to make it work.

It's not a Prism II, it says Prism I. It is a D-Link DWL-520 PCI card.
Does that matter?

By the way, I wouldn't want to admit it, but it works much better under
Win98 (ick). It cycles between "Associated: (mac addr)" and "Scanning..."
for _several minutes_ before giving up. And ping is working all this time.
Under Linux, average time before failure is 20 sec :(

I presume card is considering AP to be too weak and try to find a better
one. There isn't any. How can I disable this reassociation or lower
reassociation threshold?

At the very least, how can I see whether it is associated or scanning?
Pointers to 802.1b docs? (I am googling in parallel...)

Meanwhile will download and look into HostAP.
--
vda
