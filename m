Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317405AbSHCBSe>; Fri, 2 Aug 2002 21:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317419AbSHCBSe>; Fri, 2 Aug 2002 21:18:34 -0400
Received: from ool-182fa350.dyn.optonline.net ([24.47.163.80]:33924 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id <S317405AbSHCBSd>;
	Fri, 2 Aug 2002 21:18:33 -0400
Date: Fri, 2 Aug 2002 21:22:04 -0400
From: Nick Orlov <nick.orlov@mail.ru>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
Message-ID: <20020803012204.GA9047@nikolas.hn.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208022004150.3717-100000@freak.distro.conectiva> <Pine.SOL.4.30.0208030241540.18115-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0208030241540.18115-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 02:55:21AM +0200, Bartlomiej Zolnierkiewicz wrote:
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
> 
> And second problem is that 20265 is used as primary onboard
> sometimes and sometimes as offboard (another config option?).
> 

I think that question is _how often_ pdc20265 is used as primary
controller? Actually I know a lot of mobos with pdc20265 as additional
controller (and I don't see the one that uses it as primary). 

Don't forget about "ide=reverse" parameter that allows you to treat
pdc20265 as primary if by default kernel treat pdc20265 as secondary.

So I don't see _any_ reason to force pdc20265 to be primary (onboard)
unless CONFIG_PDC202XX_FORCE is set.

-- 
With best wishes,
	Nick Orlov.

