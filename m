Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270429AbTGaR0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270194AbTGaR0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:26:10 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47281 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S274832AbTGaRYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:24:53 -0400
Date: Thu, 31 Jul 2003 19:24:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to 2.6.0-test2
In-Reply-To: <200307311632.56813.eu@marcelopenna.org>
Message-ID: <Pine.SOL.4.30.0307311918170.19082-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jul 2003, Marcelo Penna Guerra wrote:

> > Are you aware of side effect?
> > [ Disabling DMA on ATAPI devices on SiI680. ]
> >
> > Please consult this change with Alan :-).
>
> No, I'm not. Sorry. I'm look for more information. But dma is working with
> my SiI3112A, everything is stable, so maybe it should be enabled by default
> for this chipset.

Real bug is in siimage_config_drive_for_dma():

		if (!(hwif->atapi_dma))
			goto fast_ata_pio;

Remove these two lines and DMA should be auto-enabled.

BTW unfortunately "it works for me" approach doesn't work in IDE ;-).
--
Bartlomiej

