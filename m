Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311331AbSCLUbT>; Tue, 12 Mar 2002 15:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311336AbSCLUbK>; Tue, 12 Mar 2002 15:31:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:52163 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S311331AbSCLUaw>;
	Tue, 12 Mar 2002 15:30:52 -0500
Date: Tue, 12 Mar 2002 21:35:05 +0100
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] PIIX driver rewrite
Message-Id: <20020312213505.1d229d95.sebastian.droege@gmx.de>
In-Reply-To: <20020312210035.A15175@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu>
	<Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com>
	<20020311234553.A3490@ucw.cz>
	<3C8DDFC8.5080501@evision-ventures.com>
	<20020312210035.A15175@ucw.cz>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.bEa).1jugeX10?"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.bEa).1jugeX10?
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2002 21:00:35 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:

> On Tue, Mar 12, 2002 at 12:00:24PM +0100, Martin Dalecki wrote:
> > Hello Vojtech.
> > 
> > I have noticed that the ide-timings.h and ide_modules.h are running
> > much in aprallel in the purpose they serve. Are the any
> > chances you could dare to care about propagating the
> > fairly nice ide-timings.h stuff in favour of
> > ide_modules.h more.
> > 
> > BTW.> I think some stuff from ide-timings.h just belongs
> > as generic functions intro ide.c, and right now there is
> > nobody who you need to work from behind ;-).
> > 
> > So please feel free to do the changes you apparently desired
> > to do a long time ago...
> 
> Oh, by the way, here goes the PIIX rewrite ... unlike the AMD one, this
> is completely untested, and may not work at all - I only have the
> datasheets at hand, no PIIX hardware.
> 
> Differences from the previous PIIX driver:
> 
> * 82451NX MIOC isn't supported anymore. It's not an ATA controller, anyway ;)
> * 82371FB_0 PIIX ISA bridge isn't an ATA controller either.
> * 82801CA ICH3 support added. Only ICH3-M is supported by the original driver.
> * 82371MX MPIIX is not supported anymore. Too weird beast and doesn't do
>   DMA anyway, better handled by the generic PCI ATA routines.
> 
> * Cleaner, converted to ide-timing.[ch]
> 
> * May not work. ;)
But does work with an Intel Corp. 82371AB PIIX4 IDE (rev 01) IDE controller...
I'll do some more stress testing but it boots, works in DMA and the data transfer rates haven't decreased ;)
*playingwithhdparmanddbench* ;)

Bye
--=.bEa).1jugeX10?
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8jmaBe9FFpVVDScsRArSaAJ9efVy13T3Srn+yvbgmroZPnWRxbgCdE2Le
SH0ZYLhAAo3pAAwljg3LEj4=
=zyAe
-----END PGP SIGNATURE-----

--=.bEa).1jugeX10?--

