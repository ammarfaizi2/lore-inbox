Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbTKJR6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 12:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTKJR6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 12:58:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19669 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264020AbTKJR6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 12:58:50 -0500
Date: Mon, 10 Nov 2003 18:58:42 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] give SATA its' own menu
Message-ID: <20031110175842.GO22185@fs.tum.de>
References: <20031026001554.GC23291@fs.tum.de> <20031026011145.GB23690@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026011145.GB23690@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 02:11:46AM +0100, Petr Vandrovec wrote:
> On Sun, Oct 26, 2003 at 02:15:54AM +0200, Adrian Bunk wrote:
> > Hi Jeff,
> > 
> > for an average user it's non-obvious to search for SATA support under 
> > SCSI. The patch below moves SATA suport out of SCSI and gives it an own 
> > menu below SCSI.
> 
> Will users know that they have to enable SCSI disk & cdrom support to get
> it really to work?

I don't know the internals of the SATA driver, but this is unchanged 
from the current dependencies.

If this is required, I can send a patch that adds disk an cdrom options 
to SATA and select's the appropriate SCSI options.

> 								Petr
>  
> > +config SCSI_SATA
> > +	bool "Serial ATA (SATA) support"
> > +	depends on EXPERIMENTAL
> > +	select SCSI
> > +	help
> > +	  This driver family supports Serial ATA host controllers
> > +	  and devices.
> > +
> > +	  If unsure, say N.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

