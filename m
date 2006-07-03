Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWGCMSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWGCMSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWGCMSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:18:46 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:49645 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751150AbWGCMSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:18:46 -0400
Date: Mon, 3 Jul 2006 14:17:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Martin Peschke <mp3@de.ibm.com>
Subject: Re: 2.6.17-mm6
Message-ID: <20060703121732.GC9420@osiris.boeblingen.de.ibm.com>
References: <20060703030355.420c7155.akpm@osdl.org> <44A90A62.8050202@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A90A62.8050202@fr.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the statistic infrastructure is required when compiling the ZFCP driver on
> zSeries.
> ---
>  drivers/scsi/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: 2.6.17-mm6/drivers/scsi/Kconfig
> ===================================================================
> --- 2.6.17-mm6.orig/drivers/scsi/Kconfig
> +++ 2.6.17-mm6/drivers/scsi/Kconfig
> @@ -2200,6 +2200,7 @@ config ZFCP
>  	tristate "FCP host bus adapter driver for IBM eServer zSeries"
>  	depends on S390 && QDIO && SCSI
>  	select SCSI_FC_ATTRS
> +	select STATISTICS
>  	help
>            If you want to access SCSI devices attached to your IBM eServer
>            zSeries by means of Fibre Channel interfaces say Y.

That's the wrong approach. We rather need some no-op defines that make
this compile for !CONFIG_STATISTICS. Martin is working on it, I think.

