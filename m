Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSCCUPl>; Sun, 3 Mar 2002 15:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288921AbSCCUP1>; Sun, 3 Mar 2002 15:15:27 -0500
Received: from linux.kappa.ro ([194.102.255.131]:15030 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S288919AbSCCUPF>;
	Sun, 3 Mar 2002 15:15:05 -0500
Date: Sun, 3 Mar 2002 22:16:39 +0200 (EET)
From: Teodor Iacob <theo@astral.kappa.ro>
X-X-Sender: <theo@linux.kappa.ro>
Reply-To: <Teodor.Iacob@astral.kappa.ro>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Various 802.1Q VLAN driver patches.
In-Reply-To: <3C7FD9E7.BD26CABD@mandrakesoft.com>
Message-ID: <Pine.LNX.4.31.0203032215030.10883-100000@linux.kappa.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Jeff Garzik wrote:

> Patrick Schaaf wrote:
> > > Ben Greear wrote:
> > > > --- linux-2.4.16/drivers/net/eepro100.c Mon Nov 12 18:47:18 2001
> > > > +++ linux/drivers/net/eepro100.c        Tue Dec 18 11:36:11 2001
> > > > @@ -510,12 +510,12 @@
> > > >   static const char i82557_config_cmd[CONFIG_DATA_SIZE] = {
> > > >          22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=Use MII  0=Use AUI */
> > > >          0, 0x2E, 0,  0x60, 0,
> > > > -       0xf2, 0x48,   0, 0x40, 0xf2, 0x80,              /* 0x40=Force full-duplex */
> > > > +       0xf2, 0x48,   0, 0x40, 0xfa, 0x80,              /* 0x40=Force full-duplex */
> > > >          0x3f, 0x05, };
> > > >   static const char i82558_config_cmd[CONFIG_DATA_SIZE] = {
> > > >          22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=Use MII  0=Use AUI */
> > > >          0, 0x2E, 0,  0x60, 0x08, 0x88,
> > > > -       0x68, 0, 0x40, 0xf2, 0x84,              /* Disable FC */
> > > > +       0x68, 0, 0x40, 0xfa, 0x84,              /* Disable FC */
> > > >          0x31, 0x05, };
>
> > This patch, from all I know using it, does exactly one thing: it permits
> > receiving (and sending) slightly larger frames, for setting the MTU on the
> > base interface to 1504, so the VLAN interfaces themselves can run the
> > normal 1500 byte MTU.
>
> Thanks.
>
> Can you be more specific?
> Does this (a) set eepro100 h/w max mtu to 1504, or (b) enable h/w vlan
> de-tagging, or (c) enable h/w support for non-standard frame sizes?
> Any idea what the max h/w frame size is?

 Someone told me it disables something like: drop oversized frames. But
anyway I was wondering if this could be user changable, since for example
I use 3 eepro100 and only one uses vlan 802.1q, and since I connect the
others on WANs, I would like the card to still discard the "oversized
frames" could this be possible?


 >
> --
> Jeff Garzik      |
> Building 1024    |
> MandrakeSoft     | Choose life.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

