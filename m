Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265820AbUF2Q7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUF2Q7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUF2Q73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:59:29 -0400
Received: from havoc.gtf.org ([216.162.42.101]:27081 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265820AbUF2Q6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:58:31 -0400
Date: Tue, 29 Jun 2004 12:58:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: David Jez <dave.jez@seznam.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3512 & seagate ST3120026AS in 2.4.27-rc2
Message-ID: <20040629165829.GB23191@havoc.gtf.org>
References: <20040629060900.GA20895@kangaroo.instrat.cz> <20040629082405.GA22226@kangaroo.instrat.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629082405.GA22226@kangaroo.instrat.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 10:24:05AM +0200, David Jez wrote:
> >   I have sil3512 controller and 2x Seagate ST3120026AS (yes, with mod15
> > problem...) discs. When i try some writes to disc sata_sil driver hangs.
> > Nothing ooops or something like this only following messages:
> > ata1: DMA timeout, stat 0x4
> > ata2: DMA timeout, stat 0x4
> >   I tried add this discs to sil_blacklist with SIL_QUIRK_MOD15WRITE,
> > tried your try4 patch and nothing helps.
> >   Any ideas?
>   2.6.7 with [PATCH] fix sata_sil quirk and blacklisted Seagate seems working.
> hdparm says only 13 MB/sec :( but it WORKS. Any chance for working in 2.4
> or should i buy old&good Maxtor instead :-) ?

Unfortunately for users I must choose "stability first, performance
later."  So 13MB/sec is probably about the maximum for that list of
SIL_QUICK_MOD15WRITE drives.

I am surprised that 2.4 is affected, since it should not have the
max_sectors problem that was present in 2.6.x.

	Jeff



