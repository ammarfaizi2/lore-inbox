Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267874AbUHPSl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267874AbUHPSl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267869AbUHPSkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:40:55 -0400
Received: from the-village.bc.nu ([81.2.110.252]:9445 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266257AbUHPSkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:40:49 -0400
Subject: Re: PATCH: add drive_to_key functions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <200408161912.26595.bzolnier@elka.pw.edu.pl>
References: <20040815145844.GA10778@devserv.devel.redhat.com>
	 <200408161912.26595.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092677889.20838.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 18:38:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 18:12, Bartlomiej Zolnierkiewicz wrote:
> >  	hwif->atapi_dma = 0;		/* disable all atapi dma */
> >  	hwif->ultra_mask = 0x80;	/* disable all ultra */
> >  	hwif->mwdma_mask = 0x80;	/* disable all mwdma */
> >  	hwif->swdma_mask = 0x80;	/* disable all swdma */
> >
> > +	hwif->pci_dev = NULL;
> > +	hwif->remove = NULL;
> > +
> 
> not needed - memsetting to zero is done earlier

Ok fixed in my tree.

> > +EXPORT_SYMBOL_GPL(ide_drive_to_key);
> 
> AFAICS ide_drive_[from,to]_key are to be used only from ide-proc.c
> so EXPORT_SYMBOLs are not needed

Good point I forgot they were linked together. Fixed


