Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTECT3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 15:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTECT3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 15:29:17 -0400
Received: from AMarseille-201-1-2-221.abo.wanadoo.fr ([193.253.217.221]:29992
	"EHLO gaston") by vger.kernel.org with ESMTP id S263402AbTECT3Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 15:29:16 -0400
Subject: Re: Reserving an ATA interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0305032109390.10296-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0305032109390.10296-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051990830.7820.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 May 2003 21:40:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > With my patch, since the PCI interface will not set the "hold" flag,
> > ide_register_hw() called by ide-cs will call init_hwif_data(), thus
> > putting back the hwif to a sane state
> 
> So every time you remove your disks from one of your PCI IDE controllers,
> your ide-cs will get diffirent hwif and drives mappings and your RAID
> on ide-cs won't be recognized ;-)

Yes ;) Note that it's already the case today. Except that with the call
to init_hwif_data(), at least, it wont crash the kernel because of wrong
IOps, DMA ops or whatever in the hwif.

Ben.

