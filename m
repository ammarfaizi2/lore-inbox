Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUCHWI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCHWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:08:28 -0500
Received: from ns.suse.de ([195.135.220.2]:945 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261364AbUCHWIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:08:16 -0500
Date: Mon, 8 Mar 2004 23:08:14 +0100
From: Olaf Hering <olh@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, jejb <james.bottomley@steeleye.com>,
       gibbs@scsiguy.com
Subject: Re: 2.6.3 CONFIG_SCSI_AIC7 X X X Kconfig bug
Message-ID: <20040308220814.GA19147@suse.de>
References: <20040207162054.GA25651@suse.de> <20040209085817.055e1419.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040209085817.055e1419.rddunlap@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Feb 09, Randy.Dunlap wrote:


This one is still not applied.

> 
> product_versions: linux-262-pv
> description:	make Adaptec AIC7xyx drivers depend on SCSI tristate
> 
> diffstat:=
>  drivers/scsi/aic7xxx/Kconfig.aic79xx |    2 +-
>  drivers/scsi/aic7xxx/Kconfig.aic7xxx |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -Naurp ./drivers/scsi/aic7xxx/Kconfig.aic7xxx~depends ./drivers/scsi/aic7xxx/Kconfig.aic7xxx
> --- ./drivers/scsi/aic7xxx/Kconfig.aic7xxx~depends	2004-02-03 19:43:42.000000000 -0800
> +++ ./drivers/scsi/aic7xxx/Kconfig.aic7xxx	2004-02-09 09:04:01.000000000 -0800
> @@ -4,7 +4,7 @@
>  #
>  config SCSI_AIC7XXX
>  	tristate "Adaptec AIC7xxx Fast -> U160 support (New Driver)"
> -	depends on PCI || EISA
> +	depends on (PCI || EISA) && SCSI
>  	---help---
>  	This driver supports all of Adaptec's Fast through Ultra 160 PCI
>  	based SCSI controllers as well as the aic7770 based EISA and VLB
> diff -Naurp ./drivers/scsi/aic7xxx/Kconfig.aic79xx~depends ./drivers/scsi/aic7xxx/Kconfig.aic79xx
> --- ./drivers/scsi/aic7xxx/Kconfig.aic79xx~depends	2004-02-03 19:43:43.000000000 -0800
> +++ ./drivers/scsi/aic7xxx/Kconfig.aic79xx	2004-02-09 09:03:52.000000000 -0800
> @@ -4,7 +4,7 @@
>  #
>  config SCSI_AIC79XX
>  	tristate "Adaptec AIC79xx U320 support"
> -	depends on PCI
> +	depends on PCI && SCSI
>  	help
>  	This driver supports all of Adaptec's Ultra 320 PCI-X
>  	based SCSI controllers.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
