Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbQJ0PPi>; Fri, 27 Oct 2000 11:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQJ0PP3>; Fri, 27 Oct 2000 11:15:29 -0400
Received: from zeus.kernel.org ([209.10.41.242]:33031 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129364AbQJ0PPX>;
	Fri, 27 Oct 2000 11:15:23 -0400
Date: Fri, 27 Oct 2000 18:13:44 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: VM-global-2.2.18pre17-7
Message-ID: <20001027181344.B1248@niksula.cs.hut.fi>
In-Reply-To: <Pine.LNX.4.05.10010271651240.14633-100000@marina.lowendale.com.au> <Pine.LNX.4.21.0010271124550.5338-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <Pine.LNX.4.21.0010271124550.5338-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 11:29:08AM -0200, you [Marcelo Tosatti] claimed:
> 
> 
> On Fri, 27 Oct 2000, Neale Banks wrote:
> 
> > On Thu, 26 Oct 2000, octave klaba wrote:
> > 
> > > > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > > > let me guess: intel eepro100 or similar??
> > > yeap
> > 
> > er, "me too":
> > 
> >   Bus  0, device   2, function  0:
> >     Ethernet controller: Intel 82557 (rev 8).
> >       Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
> >       Non-prefetchable 32 bit memory at 0xb5fff000 [0xb5fff000].
> >       I/O at 0x2400 [0x2401].
> >       Non-prefetchable 32 bit memory at 0xb5e00000 [0xb5e00000].
> > 
> > On Debian's 2.2.17-compact on a Compaq DL380 - with 60 days uptime I have
> > 6 "eth0: card reports no resources." messages reported in dmesg.
> 
> We are having the same problem with eepro100 on a Compaq DL360. 
> 
> v1.11 of eepro100.c fixed the problem:
> 
> ftp://ftp.scyld.com/pub/network/eepro100.c

The eepro100 problem (2.2.18pre17 stock) happens here too: "card reports
no resources" and then the network stalls for few minutes.

The hack suggested by David Richardson (
http://marc.theaimsgroup.com/?l=linux-kernel&m=96514412914742&w=2)
did not help.

The Becker's driver from ftp://ftp.scyld.com/pub/network/eepro100.c cures
the error messages, but the network still stalls, and worse yet, seems to
stall forever (as opposed to few minutes with 2.2.18pre17 driver).

A network problem is not out of question (although the rest of the network
works just fine, and we did try another HUB port). It could also be flaky
card, but the machine and the card worked fine for years in their past
life under NT.

This is dual PPro200, 256MB, nothing fancy. 


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
