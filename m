Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSELMdi>; Sun, 12 May 2002 08:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSELMdh>; Sun, 12 May 2002 08:33:37 -0400
Received: from m206-234.dsl.tsoft.com ([198.144.206.234]:16512 "EHLO
	jojda.2y.net") by vger.kernel.org with ESMTP id <S313016AbSELMdh>;
	Sun, 12 May 2002 08:33:37 -0400
Message-ID: <3CDE6120.11F402F@bigfoot.com>
Date: Sun, 12 May 2002 05:33:36 -0700
From: Erik Steffl <steffl@bigfoot.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, sk, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ide <-> via VT82C693A/694x problems?
In-Reply-To: <Pine.LNX.4.10.10204301754310.2107-100000@master.linux-ide.org> <3CCF4BFD.6C7F67EB@bigfoot.com> <1020239797.10097.68.camel@nomade> <3CCFAEEE.AE586B9A@bigfoot.com> <20020501194237.A26336@ucw.cz> <3CD04318.B46EE842@bigfoot.com> <20020502103749.A29420@ucw.cz>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Wed, May 01, 2002 at 12:33:44PM -0700, Erik Steffl wrote:
> > Vojtech Pavlik wrote:
> > >
> > > On Wed, May 01, 2002 at 02:01:34AM -0700, Erik Steffl wrote:
> > > > Xavier Bestel wrote:
> > > > >
> > > > > Le mer 01/05/2002 à 03:59, Erik Steffl a écrit :
> > > > > >   the MB uses via chips so I included via82cxxx driver (as a module). is
> > > > > > that correct?
> > > > > >
> > > > > >   however, I just checked and via82cxxx is NOT loaded. What do I need to
> > > > > > do to make ide driver is using via82cxxx module?
> > > > > >
> > > > > >   I have ide driver compiled in (booting from ide hd), does via82cxxx
> > > > > > have to be compiled in?
> > > > >
> > > > > You mean the ide module is on the ide drive ? And you want it to be
> > > > > loaded before any ide access ?
> > > >
> > > >   ide is compiled in (not a module), via82cxxx is a module.
> > > >
> > > >   via82cxxx is never loaded - what do I need to do to actually use this
> > > > module? Most other modules are loaded either automatically or an alias
> > > > is needed, however I have no idea what to do to make kernel use
> > > > via82cxxx (would ide module use it?). I thought that as long as I
> > > > configure it in kernel make xconfig as a module it will be used, but
> > > > it's not loaded (so I guess it's not used).
> > > >
> > > >   I suspect that it might be the reason why my cd drive does not rip
> > > > audio cds...
> > >
> > > via82cxxx cannot be compiled as a module - Config.in doesn't allow that.
> > > And not only that - it doesn't support it in the source - it has to be
> > > compiled into the IDE driver to work.
> >
> >   you're right, I didn't check it, just assumed it's a module! Anyway,
> > since I have checked the via support for ide (from kernel configuration
> > CONFIG_BLK_DEV_VIA82CXXX=y) it means that I have support for via82C* ide
> > compiled in, the main question still remains - why is the CD audio
> > ripping causing 'lost interrupt' on via ide, while everything else is
> > working and audio cd ripping is working with pci ide card (same
> > computer, same cd drive).
> >
> >   any pointers where to look? I'd appreciate something just a bit more
> > specific than just pointing me to ide driver...
> 
> What kernel version is that (2.5, 2.4 ... )? Have you tried some other?
> Have you tried disabling DMA on the drive? (hdparm -d0 /dev/...) Have
> you tried disabling the VIA support?

  I tried:

  2.4.17, VIA support, DMA on/off, 32 bit access on/off
  2.4.18, VIA support, DMA on/off, 32 bit access on/off
  2.4.18 with ide patches from linux-ide.org, VIA support on and off

  all with same results - audio ripping is VERY slow and there is a lot
of 'lost interrupt' messages in syslog.

  I didn't dare to try 2.5.x as it seems like there's lot of changes
related to IDE and there were some problems with currupting HD...

	erik
