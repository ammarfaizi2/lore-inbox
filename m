Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264335AbUEDM3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264335AbUEDM3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 08:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUEDM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 08:29:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17040 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264337AbUEDM3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 08:29:10 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] remove dead drivers/ide/ppc/swarm.c
Date: Tue, 4 May 2004 14:28:50 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       macro@ds2.pg.gda.pl
References: <200405040134.22092.bzolnier@elka.pw.edu.pl> <20040504111902.GA14240@linux-mips.org>
In-Reply-To: <20040504111902.GA14240@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405041428.50592.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ralf,

On Tuesday 04 of May 2004 13:19, Ralf Baechle wrote:
> On Tue, May 04, 2004 at 01:34:22AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > This driver was merged in 2.5.32 but depends on <asm/sibyte/swarm_ide.h>
> > which hasn't been merged in 2.5.  Additionally it is a MIPS specific
> > driver so it should be in drivers/ide/mips/ if somebody ever decides to
> > re-add it.
>
> No.  I've already sent a proper patch instead of just a chainsaw massacre
> to akpm.

It is not integrated into -mm (2.6.6-rc3-mm1) yet so I couldn't see it.
[ Please cc: me on IDE patches. ]

If it looks the same as in linux-mips CVS it won't work because I've killed
ide_init_default_hwifs() recently (except ARM but patch is pending).

Sorry, this is what you get when using hacks. 8)

While at swarm.c ...

> * Boards with SiByte processors so far have supported IDE devices via
> * the Generic Bus, PCI bus, and built-in PCMCIA interface.  In all
> * cases, byte-swapping must be avoided for these devices (whereas
> * other PCI devices, for example, will require swapping).

Why does byte-swapping must be avoided for PCI IDE
but not for other PCI devices?

Cheers,
Bartlomiej

