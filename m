Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136297AbRARX03>; Thu, 18 Jan 2001 18:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136176AbRARXZp>; Thu, 18 Jan 2001 18:25:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:57035 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136226AbRARXZ3>;
	Thu, 18 Jan 2001 18:25:29 -0500
Date: Thu, 18 Jan 2001 23:55:17 +0100
From: David Weinehall <tao@acc.umu.se>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: idalton@ferret.phonewave.net, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010118235517.B10370@khan.acc.umu.se>
In-Reply-To: <mike@UDel.Edu> <200101171616.LAA01194@localhost.localdomain> <20010118065012.B26045@cadcamlab.org> <20010118095906.A8983@ferret.phonewave.net> <20010118225316.L25659@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010118225316.L25659@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Thu, Jan 18, 2001 at 10:53:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 10:53:16PM +0200, Matti Aarnio wrote:
> On Thu, Jan 18, 2001 at 09:59:06AM -0800, idalton@ferret.phonewave.net wrote:
> ...
> > > Yes.  PCI-based drivers will most likely use bus order since the kernel
> > > provides facilities to do this easily.  For a single driver driving
> > > multiple cards on multiple bus types, who knows.
> > 
> > Multiple bus types... Compaq server with PCI and EISA, for example? IIRC
> > the EISA bus is bridged onto one of the PCI busses. Perhaps a
> > breadth-first scan; PCI busses first, then bridged devices on PCI, then
> > internal non-PCI busses, then external busses.
> > 
> > Are there any systems where a non-PCI bus is not connected through a
> > PCI-foo bridge?
> 
> 	Yes.
> 
> 	Oh, you propably won't meet them in PC world, but pick
> 	any UltraSPARC; PCI and SBUS are on parallel "hoses".
> 	("hose" is term used at Alpha code for the IO-bus to
> 	 CPU/MEMORY bus interface, sort of "north bridge".)
> 	Actually those UltraSPARC systems have core-bus called UPA,
> 	and IO-busses, like PCI and SBUS, are connected there...
> 
> 	Also these "big" systems often do come with multiple "hoses"
> 	of same type.
> 
> 	If you look carefully at intel things, there is this "FSB"
> 	which is the real core-bus, and IO-busses hang on it.
> 
> 
> 	I have never myself seen big Digital Alpha system where IO-
> 	busses are anything but PCI, but there exists options to place
> 	there FutureBus+, PCI, VME, TurboChannel, and several other
> 	DEC proprietary things.  With 43-45 bits of physical address
> 	space out of the processors, it is trivial to plug in multiple
> 	32-bit address space busses.
> 
> 	In coherent view NUMA implementation of Linux, there possibly
> 	comes even the detail about which NUMA node the busses reside at.

I'm pretty sure the IBM PC-Server 700 (8 MCA-slots and 8 PCI-slots
and a lot of other cool stuff) doesn't have the MCA-bus bridged
onto the PCI-bus. Maybe the other way around. I'd be happy to get one
of these machines to test this, but they seem to be a little hard
to get by for free... :^)


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
