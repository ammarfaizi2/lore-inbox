Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264461AbUGAKaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbUGAKaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 06:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbUGAKaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 06:30:23 -0400
Received: from av.isp.contactel.cz ([212.65.193.173]:45525 "EHLO
	av3.isp.contactel.cz") by vger.kernel.org with ESMTP
	id S264461AbUGAKaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 06:30:20 -0400
Date: Thu, 1 Jul 2004 12:30:17 +0200
From: David Jez <dave.jez@seznam.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3512 & seagate ST3120026AS in 2.4.27-rc2
Message-ID: <20040701103017.GC2462@kangaroo.instrat.cz>
References: <20040629060900.GA20895@kangaroo.instrat.cz> <20040629082405.GA22226@kangaroo.instrat.cz> <20040629165829.GB23191@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629165829.GB23191@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: athlon i686 Linux-2.4.20-28.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 12:58:29PM -0400, Jeff Garzik wrote:
> > >   I have sil3512 controller and 2x Seagate ST3120026AS (yes, with mod15
> > > problem...) discs. When i try some writes to disc sata_sil driver hangs.
> > > Nothing ooops or something like this only following messages:
> > > ata1: DMA timeout, stat 0x4
> > > ata2: DMA timeout, stat 0x4
> > >   I tried add this discs to sil_blacklist with SIL_QUIRK_MOD15WRITE,
> > > tried your try4 patch and nothing helps.
> > >   Any ideas?
> >   2.6.7 with [PATCH] fix sata_sil quirk and blacklisted Seagate seems working.
> > hdparm says only 13 MB/sec :( but it WORKS. Any chance for working in 2.4
> > or should i buy old&good Maxtor instead :-) ?
> 
> Unfortunately for users I must choose "stability first, performance
> later."  So 13MB/sec is probably about the maximum for that list of
> SIL_QUICK_MOD15WRITE drives.
> 
> I am surprised that 2.4 is affected, since it should not have the
> max_sectors problem that was present in 2.6.x.
  I'm sorry maybe i was confused. This is strange because 2.4.26 with
libata3 works fine (libata in kernel not as module) even without
blacklisted seagate. Performance is 55 MB/s... I'll try it once more
in 2.4.27-rc2 and 2.6.7 with libata as module.

> 	Jeff
  Dave
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
