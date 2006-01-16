Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWAPPkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWAPPkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWAPPkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:40:24 -0500
Received: from xenotime.net ([66.160.160.81]:37775 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750991AbWAPPkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:40:23 -0500
Date: Mon, 16 Jan 2006 07:40:15 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Erik Mouw <erik@harddisk-recovery.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jgarzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
In-Reply-To: <20060116115607.GA18307@harddisk-recovery.nl>
Message-ID: <Pine.LNX.4.58.0601160740020.24990@shark.he.net>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
 <20060116115607.GA18307@harddisk-recovery.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, Erik Mouw wrote:

> On Fri, Jan 13, 2006 at 10:42:52PM -0800, Randy.Dunlap wrote:
> > --- linux-2615-g9.orig/drivers/scsi/Kconfig
> > +++ linux-2615-g9/drivers/scsi/Kconfig
> > @@ -599,6 +599,11 @@ config SCSI_SATA_INTEL_COMBINED
> >  	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
> >  	default y
> >
> > +config SCSI_SATA_ACPI
> > +	bool
> > +	depends on SCSI_SATA && ACPI
> > +	default y
> > +
>
> Could you add some help text over here? At first glance I got the
> impression this was a host driver that works through ACPI calls, but by
> reading the rest of your patches it turns out it is a suspend/resume
> helper.

OK, will do.

> For quite some time we had no help text with the mysterious
> "ACPI0004,PNP0A05 and PNP0A06 Container Driver", no need to add another
> mysterious ACPI feature.

-- 
~Randy
