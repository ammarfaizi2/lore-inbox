Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVJ0VyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVJ0VyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVJ0VyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:54:03 -0400
Received: from main.gmane.org ([80.91.229.2]:64212 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932236AbVJ0VyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:54:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH 4 of 6] tpm: move atmel driver off pci_dev
Date: Thu, 27 Oct 2005 23:51:58 +0200
Message-ID: <pan.2005.10.27.21.51.55.561589@free.fr>
References: <1130253722.4839.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
Cc: akpm@osdl.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 25 Oct 2005 10:22:02 -0500, Kylene Jo Hall a écrit :


> +static int __init init_atmel(void)
>  {
> -	u8 version[4];
>  	int rc = 0;
>  	int lo, hi;
>  
> -	if (pci_enable_device(pci_dev))
> -		return -EIO;
> +	driver_register(&atml_drv);
>  
>  	lo = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
>  	hi = tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> 
Hum shouldn't you check that this port isn't used with request_region ?

Matthieu

