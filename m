Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129571AbQJ0Pue>; Fri, 27 Oct 2000 11:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbQJ0PuZ>; Fri, 27 Oct 2000 11:50:25 -0400
Received: from mail.aslab.com ([205.219.89.194]:18186 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S129385AbQJ0PuI>;
	Fri, 27 Oct 2000 11:50:08 -0400
Message-ID: <008e01c0402c$85369760$7818b7c0@aslab.com>
From: "Jeff Nguyen" <jeff@aslab.com>
To: "Ville Herva" <vherva@mail.niksula.cs.hut.fi>,
        <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.05.10010271651240.14633-100000@marina.lowendale.com.au> <Pine.LNX.4.21.0010271124550.5338-100000@freak.distro.conectiva> <20001027181344.B1248@niksula.cs.hut.fi>
Subject: Re: VM-global-2.2.18pre17-7
Date: Fri, 27 Oct 2000 08:42:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should use the Intel e100 driver at
http://support.intel.com/support/network/adapter/pro100/100Linux.htm.
It works much better than eepro100.

Jeff

ASL

----- Original Message -----
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: <linux-kernel@vger.kernel.org>; <linux-net@vger.kernel.org>
Sent: Friday, October 27, 2000 8:13 AM
Subject: Re: VM-global-2.2.18pre17-7


> On Fri, Oct 27, 2000 at 11:29:08AM -0200, you [Marcelo Tosatti] claimed:
> >
> >
> > On Fri, 27 Oct 2000, Neale Banks wrote:
> >
> > > On Thu, 26 Oct 2000, octave klaba wrote:
> > >
> > > > > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > > > > let me guess: intel eepro100 or similar??
> > > > yeap
> > >
> > > er, "me too":
> > >
> > >   Bus  0, device   2, function  0:
> > >     Ethernet controller: Intel 82557 (rev 8).
> > >       Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master
Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
> > >       Non-prefetchable 32 bit memory at 0xb5fff000 [0xb5fff000].
> > >       I/O at 0x2400 [0x2401].
> > >       Non-prefetchable 32 bit memory at 0xb5e00000 [0xb5e00000].
> > >
> > > On Debian's 2.2.17-compact on a Compaq DL380 - with 60 days uptime I
have
> > > 6 "eth0: card reports no resources." messages reported in dmesg.
> >
> > We are having the same problem with eepro100 on a Compaq DL360.
> >
> > v1.11 of eepro100.c fixed the problem:
> >
> > ftp://ftp.scyld.com/pub/network/eepro100.c
>
> The eepro100 problem (2.2.18pre17 stock) happens here too: "card reports
> no resources" and then the network stalls for few minutes.
>
> The hack suggested by David Richardson (
> http://marc.theaimsgroup.com/?l=linux-kernel&m=96514412914742&w=2)
> did not help.
>
> The Becker's driver from ftp://ftp.scyld.com/pub/network/eepro100.c cures
> the error messages, but the network still stalls, and worse yet, seems to
> stall forever (as opposed to few minutes with 2.2.18pre17 driver).
>
> A network problem is not out of question (although the rest of the network
> works just fine, and we did try another HUB port). It could also be flaky
> card, but the machine and the card worked fine for years in their past
> life under NT.
>
> This is dual PPro200, 256MB, nothing fancy.
>
>
> -- v --
>
> v@iki.fi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
