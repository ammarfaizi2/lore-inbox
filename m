Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313927AbSEAT1B>; Wed, 1 May 2002 15:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313943AbSEAT1A>; Wed, 1 May 2002 15:27:00 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:1524 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S313927AbSEAT07>; Wed, 1 May 2002 15:26:59 -0400
Date: Wed, 01 May 2002 12:33:44 -0700
From: Erik Steffl <steffl@bigfoot.com>
Subject: Re: ide <-> via VT82C693A/694x problems?
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3CD04318.B46EE842@bigfoot.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en]C-PBI-NC404  (WinNT; U)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en,sk
In-Reply-To: <Pine.LNX.4.10.10204301754310.2107-100000@master.linux-ide.org>
 <3CCF4BFD.6C7F67EB@bigfoot.com> <1020239797.10097.68.camel@nomade>
 <3CCFAEEE.AE586B9A@bigfoot.com> <20020501194237.A26336@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Wed, May 01, 2002 at 02:01:34AM -0700, Erik Steffl wrote:
> > Xavier Bestel wrote:
> > >
> > > Le mer 01/05/2002 à 03:59, Erik Steffl a écrit :
> > > >   the MB uses via chips so I included via82cxxx driver (as a module). is
> > > > that correct?
> > > >
> > > >   however, I just checked and via82cxxx is NOT loaded. What do I need to
> > > > do to make ide driver is using via82cxxx module?
> > > >
> > > >   I have ide driver compiled in (booting from ide hd), does via82cxxx
> > > > have to be compiled in?
> > >
> > > You mean the ide module is on the ide drive ? And you want it to be
> > > loaded before any ide access ?
> >
> >   ide is compiled in (not a module), via82cxxx is a module.
> >
> >   via82cxxx is never loaded - what do I need to do to actually use this
> > module? Most other modules are loaded either automatically or an alias
> > is needed, however I have no idea what to do to make kernel use
> > via82cxxx (would ide module use it?). I thought that as long as I
> > configure it in kernel make xconfig as a module it will be used, but
> > it's not loaded (so I guess it's not used).
> >
> >   I suspect that it might be the reason why my cd drive does not rip
> > audio cds...
> 
> via82cxxx cannot be compiled as a module - Config.in doesn't allow that.
> And not only that - it doesn't support it in the source - it has to be
> compiled into the IDE driver to work.

  you're right, I didn't check it, just assumed it's a module! Anyway,
since I have checked the via support for ide (from kernel configuration
CONFIG_BLK_DEV_VIA82CXXX=y) it means that I have support for via82C* ide
compiled in, the main question still remains - why is the CD audio
ripping causing 'lost interrupt' on via ide, while everything else is
working and audio cd ripping is working with pci ide card (same
computer, same cd drive).

  any pointers where to look? I'd appreciate something just a bit more
specific than just pointing me to ide driver...

  TIA

	erik
