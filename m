Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUBPESl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUBPESl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:18:41 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59315 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265370AbUBPER6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:17:58 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Chip Salzenberg <chip@pobox.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
Date: Mon, 16 Feb 2004 05:24:04 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <E1AsO6X-0003hW-1u@tytlal> <40303D59.4030605@pobox.com> <20040216040811.GF3789@perlsupport.com>
In-Reply-To: <20040216040811.GF3789@perlsupport.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402160524.04046.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 of February 2004 05:08, Chip Salzenberg wrote:
> According to Jeff Garzik:
> > Other equally smart people argue that modern IDE disks reserve space for
> > remapping bad sectors.  If you run out of sectors that the drive is
> > willing to silently remap for you, you should toss the disk and buy a
> > new one.
>
> OK, I get the theory.  But AFAICT this drive hasn't remapped *any*
> sectors.  Yet.  (Which would not be impossible; it's a relatively
> new drive, a few months old at most.)  Quoting smartctl:
>
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED 
> WHEN_FAILED RAW_VALUE 5 Reallocated_Sector_Ct   0x0033   100   100   050   
> Pre-fail  Always       -       0 196 Reallocated_Event_Count 0x0032   100  
> 100   000    Old_age   Always       -       0 197 Current_Pending_Sector 
> 0x0032   100   100   000    Old_age   Always       -       3 198
> Offline_Uncorrectable   0x0030   100   100   000    Old_age   Offline     
> -       0
>
> This seems to suggest that there are three *candidate* sectors with
> reallocation pending, none of which have actually been remapped (yet).

Because you hit them during READ access, you may try to WRITE them.
[ Hmm.  It reminds me quite recent thread about remapping of bad sectors. ]

> If so, drive replacement would perhaps be premature.
>
> I suppose it's time to read up on the details of the SMART spec.

