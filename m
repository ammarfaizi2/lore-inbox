Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVE2RYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVE2RYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 13:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVE2RYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 13:24:11 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:46262 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261196AbVE2RYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 13:24:05 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <4299F4E2.4020305@pobox.com>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299EF16.2050208@pobox.com>
	 <1117385429.4851.8.camel@localhost.localdomain>
	 <4299F4E2.4020305@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 19:23:52 +0200
Message-Id: <1117387432.4851.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-29 at 12:59 -0400, Jeff Garzik wrote:

> >>Nope.  ata_piix does not support NCQ (because the h/w doesn't support).
> > If I understand this correctly: NCQ does not work on ICH7 in native mode
> > (using ata_piix) because in this mode there is no NCQ available, right?
> 
> To be more specific, there are these modes:
> 
> 	legacy mode		no NCQ
> 	combined mode		no NCQ
> 	native mode		no NCQ
> 	AHCI mode		NCQ

Thx.

> > My question was if there is a fundamental reason why the AHCI mode of
> > the ICH6/7 must be enabled by the BIOS, is there a reason why the kernel
> > doesn't do it, or can't do it?
> 
> The BIOS sets up PCI resources necessary to use AHCI mode.

Ok. So there's absolutely no way to do that afterwards? It'd really be a
pity :-(

On the same subject: is there a reason why ICH6 gets "BAR0-3 ignored"
and always gets the legacy i/o ports and IRQ's assigned? I'd say there
is absolutely no need to be compatible in this way, the PCI code can
assign the IRQ and I/O ports as with any other PCI device?
