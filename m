Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbVJ0WBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbVJ0WBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbVJ0WBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:01:48 -0400
Received: from main.gmane.org ([80.91.229.2]:53721 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932656AbVJ0WBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:01:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH 5 of 6] tpm: move nsc driver off pci_dev
Date: Thu, 27 Oct 2005 23:55:08 +0200
Message-ID: <pan.2005.10.27.21.55.05.503639@free.fr>
References: <1130253727.4839.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 25 Oct 2005 10:22:07 -0500, Kylene Jo Hall a écrit :

> This patch changes the nsc driver from a pci driver to a platform
> driver.

> +static int __init init_nsc(void)
>  {
>  	int rc = 0;
>  	int lo, hi;
>  	int nscAddrBase = TPM_ADDR;
>  
> -
> -	if (pci_enable_device(pci_dev))
> -		return -EIO;
> +	driver_register(&nsc_drv);
>  
>  	/* select PM channel 1 */
>  	tpm_write_index(nscAddrBase,NSC_LDN_INDEX, 0x12);
Idem as tpm_atmel, you seem to write some bits before knowing if the port
isn't used.


