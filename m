Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264806AbUEPTcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbUEPTcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 15:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264805AbUEPTcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 15:32:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20701 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264804AbUEPTcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 15:32:07 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marc Singer <elf@buici.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sun, 16 May 2004 21:34:30 +0200
User-Agent: KMail/1.5.3
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <40A69848.9020304@pobox.com> <20040516010008.GC23743@buici.com>
In-Reply-To: <20040516010008.GC23743@buici.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405162134.30564.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 of May 2004 03:00, Marc Singer wrote:
> On Sat, May 15, 2004 at 06:23:04PM -0400, Jeff Garzik wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > >On Saturday 15 of May 2004 19:34, Jeff Garzik wrote:
> > >>On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > >>>- host drivers should request/release IO resource
> > >>> themelves and set hwif->mmio to 2
> > >>
> > >>Don't you mean, hwif->mmio==2 for MMIO hardware?
> > >
> > >It is was historically for MMIO, now it means that driver
> > >handles IO resource itself (per comment in <linux/ide.h>).
> >
> > Maybe then create a constant HOST_IO_RESOURCES (value==2) to make that
> > more obvious?
>
> Please allow me to advocate for the naive.
>
> While I do not in favor of lengthy commented discourses within the
> code for all of the usual reasons, I do believe that interface
> documentation is always welcome.  It encourages everyone to learn and
> follow the rules.  It allows the subsystem maintainer to establish a
> boundary so that accessing lower-level structures are left alone.
>
> I'm not talking about a HOWTO as we know it.  Let's look at this mmio
> flag.  How about writing this at a very minimum.
>
>   	int mmio; /* 0: iommio; <insert appropriate direction */
> 		  /* 2: custom; driver must reserve & release system resources */

I think this is good for ide.h

> Certainly, I'd rather see something along the lines of a full
> description.
>
> 	int mmio;
> 	    /* This field controls whether or not the driver blah,
> 	       blah.  If the driver needs to reserve system resources,
> 	       e.g. ports of memory, set the value to 2 and blah, blah. */

and this is good for documentation file.

> It isn't much, but it goes a long way.

Thanks.

