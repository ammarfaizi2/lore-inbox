Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317386AbSHCAwK>; Fri, 2 Aug 2002 20:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSHCAwK>; Fri, 2 Aug 2002 20:52:10 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11166 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317386AbSHCAwJ>; Fri, 2 Aug 2002 20:52:09 -0400
Date: Sat, 3 Aug 2002 02:55:21 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Nick Orlov <nick.orlov@mail.ru>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <Pine.LNX.4.44.0208022004150.3717-100000@freak.distro.conectiva>
Message-ID: <Pine.SOL.4.30.0208030241540.18115-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Aug 2002, Marcelo Tosatti wrote:
> On Fri, 2 Aug 2002, Bartlomiej Zolnierkiewicz wrote:
> > > Just FYI,
> > >
> > > before these "#ifdef" fixes it was treated as OFF_BOARD unless
> > > CONFIG_PDC202XX_FORCE is set. (now it's inverted)
> >
> > This should be fixed.
>
> If we change the #ifdef on ide-pci.c it will skip some controllers which
> worked before _without_ CONFIG_PDC202XX_FORCE set.

I was thinking about changing it globally to do what its name suggest.

Main problem is that before introducing skipping Promises, FORCE
controlled overriding BIOS only (?) and now it is also used to control
'skipping'. (FORCE should be by default on of course)
Probably 'skipping' should be separated to another config option...

And second problem is that 20265 is used as primary onboard
sometimes and sometimes as offboard (another config option?).


Regards
--
puzzled Bartlomiej

