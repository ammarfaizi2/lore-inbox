Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWIZUoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWIZUoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWIZUog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:44:36 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:1811 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932303AbWIZUog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:44:36 -0400
Date: Tue, 26 Sep 2006 22:44:33 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata-sff: use our IRQ defines
Message-ID: <20060926204433.GA77171@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
References: <1159289737.11049.261.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159289737.11049.261.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 05:55:37PM +0100, Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/libata-sff.c linux-2.6.18-mm1/drivers/ata/libata-sff.c
> --- linux.vanilla-2.6.18-mm1/drivers/ata/libata-sff.c	2006-09-25 12:10:08.000000000 +0100
> +++ linux-2.6.18-mm1/drivers/ata/libata-sff.c	2006-09-25 16:04:41.000000000 +0100
> @@ -881,7 +881,7 @@
>  	probe_ent->private_data = port[0]->private_data;
>  
>  	if (port_mask & ATA_PORT_PRIMARY) {
> -		probe_ent->irq = 14;
> +		probe_ent->irq = ATA_PRIMARY_IRQ;
>  		probe_ent->port[0].cmd_addr = ATA_PRIMARY_CMD;
>  		probe_ent->port[0].altstatus_addr =
>  		probe_ent->port[0].ctl_addr = ATA_PRIMARY_CTL;
> @@ -896,7 +896,7 @@
>  
>  	if (port_mask & ATA_PORT_SECONDARY) {
>  		if (probe_ent->irq)
> -			probe_ent->irq2 = 15;
> +			probe_ent->irq2 = ATA_SECONDARY_IRQ;
>  		else
>  			probe_ent->irq = 15;

Isn't that one supposed to be ATA_SECONDARY_IRQ too?

>  		probe_ent->port[1].cmd_addr = ATA_SECONDARY_CMD;
> 

  OG.
