Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313717AbSEARmo>; Wed, 1 May 2002 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313724AbSEARmn>; Wed, 1 May 2002 13:42:43 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:14738 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313717AbSEARmm>;
	Wed, 1 May 2002 13:42:42 -0400
Date: Wed, 1 May 2002 19:42:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Erik Steffl <steffl@bigfoot.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide <-> via VT82C693A/694x problems?
Message-ID: <20020501194237.A26336@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10204301754310.2107-100000@master.linux-ide.org> <3CCF4BFD.6C7F67EB@bigfoot.com> <1020239797.10097.68.camel@nomade> <3CCFAEEE.AE586B9A@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 02:01:34AM -0700, Erik Steffl wrote:
> Xavier Bestel wrote:
> > 
> > Le mer 01/05/2002 à 03:59, Erik Steffl a écrit :
> > >   the MB uses via chips so I included via82cxxx driver (as a module). is
> > > that correct?
> > >
> > >   however, I just checked and via82cxxx is NOT loaded. What do I need to
> > > do to make ide driver is using via82cxxx module?
> > >
> > >   I have ide driver compiled in (booting from ide hd), does via82cxxx
> > > have to be compiled in?
> > 
> > You mean the ide module is on the ide drive ? And you want it to be
> > loaded before any ide access ?
> 
>   ide is compiled in (not a module), via82cxxx is a module.
> 
>   via82cxxx is never loaded - what do I need to do to actually use this
> module? Most other modules are loaded either automatically or an alias
> is needed, however I have no idea what to do to make kernel use
> via82cxxx (would ide module use it?). I thought that as long as I
> configure it in kernel make xconfig as a module it will be used, but
> it's not loaded (so I guess it's not used).
> 
>   I suspect that it might be the reason why my cd drive does not rip
> audio cds...

via82cxxx cannot be compiled as a module - Config.in doesn't allow that.
And not only that - it doesn't support it in the source - it has to be
compiled into the IDE driver to work.

-- 
Vojtech Pavlik
SuSE Labs
