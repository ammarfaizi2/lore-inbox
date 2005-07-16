Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVGPR3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVGPR3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 13:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVGPR3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 13:29:13 -0400
Received: from main.gmane.org ([80.91.229.2]:4746 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261779AbVGPR21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 13:28:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: 2.6.13-rc3-mm1: horribly drivers/scsi/qla2xxx/Makefile
Date: Sat, 16 Jul 2005 19:26:44 +0200
Message-ID: <dbbg0k$p8g$1@sea.gmane.org>
References: <20050715013653.36006990.akpm@osdl.org> <20050715102744.GA3569@stusta.de> <20050715144037.GA25648@plap.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 195.70.138.133.adsl.nextra.cz
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
In-Reply-To: <20050715144037.GA25648@plap.qlogic.org>
Cc: linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Vasquez wrote:
> Yes, quite.  How about the following to correct the intention.
> 
> 
> 
> Add correct Kconfig option for ISP24xx support.
> 
> Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
> ---
> 
> diff --git a/drivers/scsi/qla2xxx/Kconfig b/drivers/scsi/qla2xxx/Kconfig
> --- a/drivers/scsi/qla2xxx/Kconfig
> +++ b/drivers/scsi/qla2xxx/Kconfig
> @@ -39,3 +39,11 @@ config SCSI_QLA6312
>  	---help---
>  	This driver supports the QLogic 63xx (ISP6312 and ISP6322) host
>  	adapter family.
> +
> +config SCSI_QLA24XX
> +	tristate "QLogic ISP24xx host adapter family support"
> +	depends on SCSI_QLA2XXX
> +        select SCSI_FC_ATTRS

there should be also "select FW_LOADER", as it uses request_firmware &
release_firmware

> +	---help---
> +	This driver supports the QLogic 24xx (ISP2422 and ISP2432) host
> +	adapter family.

-- 
Jindrich Makovicka

