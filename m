Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUBPRex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUBPRex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:34:53 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48522 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265764AbUBPRev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:34:51 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Any guides for adding new IDE chipset drivers?
Date: Mon, 16 Feb 2004 18:39:57 +0100
User-Agent: KMail/1.5.3
References: <1076951082.31859.60.camel@cambridge.braddahead.com>
In-Reply-To: <1076951082.31859.60.camel@cambridge.braddahead.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161839.57342.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 of February 2004 18:04, Alex Bennee wrote:
> Hi,
>
> We currently have implemented a simple (PIO) IDE interface on our
> embedded SH based board. The "driver" is just a simple call from
> ide_setup() that twiddles the various values in ide_hwifs to set the
> correct port addresses.

Most embedded people till now just _abused_ ide_init_default_hwifs() :-(.

> All this is all well and good and works fine. However I'm looking at
> adding DMA support to the driver to make better use of the hardware.
> I've been looking around the other arch IDE drivers (e.g. the ppc pmac
> driver) which seem to hook into the probe_for_hwifs() and then update
> the hwifs table itself. This makes me wonder am I initialising my driver
> the "correct" way.

No, it is not the "correct" way.

> As far as implementing the DMA features is concerned as far as I can
> tell I just need to code up routines for all the various
> hwifs[x].ide_dma* functions and be done with it. Am I missing anything?
>
> So my questions boil down to:
>
> Are there any guides for driver writers for what needs doing to add new
> IDE chipset drivers?

No, unfortunately.

> Is there a driver that can be held of as an example of good taste and
> the "right" way to implement a chipset driver?

Yep.  Please take a look at drivers/ide/arm/icside.c.
It is well written, quite simple and has DMA support.

If you have any questions/issues feel free to ask
on linux-ide@vger.kernel.org mailing list.

Cheers,
--bart

