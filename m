Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSHCAz3>; Fri, 2 Aug 2002 20:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSHCAz2>; Fri, 2 Aug 2002 20:55:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28688 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317421AbSHCAz2>; Fri, 2 Aug 2002 20:55:28 -0400
Date: Fri, 2 Aug 2002 21:08:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Nick Orlov <nick.orlov@mail.ru>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <Pine.SOL.4.30.0208030241540.18115-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0208022107560.3863-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Aug 2002, Bartlomiej Zolnierkiewicz wrote:

>
> On Fri, 2 Aug 2002, Marcelo Tosatti wrote:
> > On Fri, 2 Aug 2002, Bartlomiej Zolnierkiewicz wrote:
> > > > Just FYI,
> > > >
> > > > before these "#ifdef" fixes it was treated as OFF_BOARD unless
> > > > CONFIG_PDC202XX_FORCE is set. (now it's inverted)
> > >
> > > This should be fixed.
> >
> > If we change the #ifdef on ide-pci.c it will skip some controllers which
> > worked before _without_ CONFIG_PDC202XX_FORCE set.
>
> I was thinking about changing it globally to do what its name suggest.
>
> Main problem is that before introducing skipping Promises, FORCE
> controlled overriding BIOS only (?) and now it is also used to control
> 'skipping'. (FORCE should be by default on of course)
> Probably 'skipping' should be separated to another config option...

Indeed. I appreciate patches ;)

>
> And second problem is that 20265 is used as primary onboard
> sometimes and sometimes as offboard (another config option?).

