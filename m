Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131226AbRAaIcQ>; Wed, 31 Jan 2001 03:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRAaIcG>; Wed, 31 Jan 2001 03:32:06 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:18836 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131226AbRAaIbr>; Wed, 31 Jan 2001 03:31:47 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200101310831.JAA01369@sunrise.pg.gda.pl>
Subject: Re: Multiple SCSI host adapters, naming of attached devices
To: wolfgang@leila.ping.de (Wolfgang Wegner)
Date: Wed, 31 Jan 2001 09:31:29 +0100 (MET)
Cc: michael@wd21.co.uk (Michael Pacey), linux-kernel@vger.kernel.org
In-Reply-To: <200101310038.BAA21051@noefs.ping.de> from "Wolfgang Wegner" at Jan 31, 2001 01:38:39 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Wolfgang Wegner wrote:"
> > Given two host adapters each with 1 disk of ID 0, how do I tell Linux which
> > is sda and which sdb?
> [...]
> which leads me to the question:
> Is there any reason for the (IMHO stupid) "dynamic" naming of
> SCSI devices (in contrast to e.g. IDE devices or the "physical"
> device naming used in Solaris)?

Yes. Shortage of 16-bit major/minor numbers.

> It may be possible always maintaining the "right" order with
> one SCSI chain, but as soon as there is a second bus, it is
> really a pain. Is devfs the only solution?

You can try:
- loading scsi drivers as modules in appropriate order (possibly using
  initrd if root filesystem is located on any of them)
- using devfs names.

--
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
