Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUFGS44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUFGS44 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUFGS4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:56:55 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27352 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264997AbUFGS4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 14:56:54 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Sam Ravnborg <sam@ravnborg.org>, Mikael Starvik <mikael.starvik@axis.com>
Subject: Re: [PATCH] CRIS architecture update
Date: Mon, 7 Jun 2004 21:00:12 +0200
User-Agent: KMail/1.5.3
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
References: <BFECAF9E178F144FAEF2BF4CE739C668D47C24@exmail1.se.axis.com> <BFECAF9E178F144FAEF2BF4CE739C66818F49D@exmail1.se.axis.com> <20040607184309.GA3152@mars.ravnborg.org>
In-Reply-To: <20040607184309.GA3152@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406072100.12444.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 of June 2004 20:43, Sam Ravnborg wrote:
> On Mon, Jun 07, 2004 at 07:53:30AM +0200, Mikael Starvik wrote:
> > >The general rule is to locate drivers under drivers/, even the arch
> > >specific ones. This allows for easier grepping after users of a
> > >given API etc.
> >
> > Ok, if that is a general rule I can move them (but the patch will
> > be large...).
>
> Please do so. As Bartlomiej note the rule is to keep drivers under:
> drivers/<subsystem>/<arch>
>
> The most efficient way to do the move is to send Linus a direct
> mail with a simple shell script that does the moving of the files.
> Along the lines of:
>
> mkdir -p drivers/ide/cris
> mv arch/cris/drivers/ide/* drivers/ide/cris

If you decide to do this please rename you driver
to i.e. ide_etrax100.c as we already have ide.c file. ;-)

[ BTW thanks for explaining e100_read_command usage,
  I somehow overlooked that it is a variable not an enum ]

> etc.
>
> 	Sam

