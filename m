Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbTHYKEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTHYKEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:04:55 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:38076 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261621AbTHYKEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:04:53 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: insecure@mail.od.ua
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308251301.00267.insecure@mail.od.ua>
References: <1061730317.31688.10.camel@gaston>
	 <200308251301.00267.insecure@mail.od.ua>
Message-Id: <1061805866.779.51.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 25 Aug 2003 12:04:26 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [PATCH] Fix ide unregister vs. driver model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-25 at 12:01, insecure wrote:
> On Sunday 24 August 2003 16:05, Benjamin Herrenschmidt wrote:
> >  static void hwif_register (ide_hwif_t *hwif)
> >  {
> >  	/* register with global device tree */
> >  	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
> >  	hwif->gendev.driver_data = hwif;
> > +	if (hwif->gendev.parent == NULL) {
> >  	if (hwif->pci_dev)
> >  		hwif->gendev.parent = &hwif->pci_dev->dev;
> >  	else
> >  		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
> > +	}
> 
> inner if() should be indented

Ah shit, I keep fixing that and for some reason, it keeps re-breaking...
I must have confused bitkeeper someway

Anyway, Bart, you know how to fix that ;)

Ben.


