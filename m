Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264337AbUEDNOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbUEDNOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 09:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbUEDNOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 09:14:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19864 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264337AbUEDNOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 09:14:06 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
Date: Tue, 4 May 2004 15:10:41 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       macro@ds2.pg.gda.pl
References: <200405040134.22092.bzolnier@elka.pw.edu.pl> <200405041428.50592.bzolnier@elka.pw.edu.pl> <20040504124349.GA15664@linux-mips.org>
In-Reply-To: <20040504124349.GA15664@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405041510.41731.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 of May 2004 14:43, Ralf Baechle wrote:
> On Tue, May 04, 2004 at 02:28:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > It is not integrated into -mm (2.6.6-rc3-mm1) yet so I couldn't see it.
> > [ Please cc: me on IDE patches. ]
>
> Will do.

Thanks.

> > If it looks the same as in linux-mips CVS it won't work because I've
> > killed ide_init_default_hwifs() recently (except ARM but patch is
> > pending).
> >
> > Sorry, this is what you get when using hacks. 8)
> >
> > While at swarm.c ...
> >
> > > * Boards with SiByte processors so far have supported IDE devices via
> > > * the Generic Bus, PCI bus, and built-in PCMCIA interface.  In all
> > > * cases, byte-swapping must be avoided for these devices (whereas
> > > * other PCI devices, for example, will require swapping).
> >
> > Why does byte-swapping must be avoided for PCI IDE
> > but not for other PCI devices?
>
> Simply a result of the way the IDE bus is hooked up to the generic bus of
> the Sibyte chip.  I'd have to research details if you're interested ...

The basic question is whether disk used on SiByte can be read i.e. on x86.
If not than we may have serious problems with some special commands with
current implementation (similar problem as on Atari Q40/Q60).

Bartlomiej

