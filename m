Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVE2QvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVE2QvK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 12:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVE2QvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 12:51:10 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:40630 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261354AbVE2QvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 12:51:05 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <4299EF16.2050208@pobox.com>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299EF16.2050208@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 18:50:29 +0200
Message-Id: <1117385429.4851.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-29 at 12:34 -0400, Jeff Garzik wrote:
> >>Now, this patch is not complete. It should work and work well, but error
> >>handling isn't really tested or finished yet (by any stretch of the
> >>imagination). So don't use this on a production machine, it _should_ be
> >>safe to use on your test boxes and for-fun workstations though (I run it
> >>here...). I have tested on ich6 and ich7 generation ahci, and with
> >>Maxtor and Seagate drives.
> > Is this supposed to work on ICH7 in legacy mode as well?
> Nope.  ata_piix does not support NCQ (because the h/w doesn't support).

If I understand this correctly: NCQ does not work on ICH7 in native mode
(using ata_piix) because in this mode there is no NCQ available, right?

> > Another question: is there a fundamental problem to have the ICH6/7
> > enabled AHCI mode by the kernel instead of the BIOS? I know some BIOSes
> > don't offer the choice to enable AHCI (like mine :-().
> Not a problem.  You just don't get to use AHCI and such.

Huh?

My question was if there is a fundamental reason why the AHCI mode of
the ICH6/7 must be enabled by the BIOS, is there a reason why the kernel
doesn't do it, or can't do it?

And of course I'd like to have my ICH6/7 in AHCI mode, for obvious
reasons.
