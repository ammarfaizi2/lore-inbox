Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWFWSII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWFWSII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWFWSII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:08:08 -0400
Received: from mga05.intel.com ([192.55.52.89]:43162 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751848AbWFWSIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:08:06 -0400
X-IronPort-AV: i="4.06,169,1149490800"; 
   d="scan'208"; a="88389905:sNHT3918482890"
Message-ID: <449C2DE0.4000907@foo-projects.org>
Date: Fri, 23 Jun 2006 11:07:28 -0700
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: netdev@vger.kernel.org, john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: e1000: Janitor: Use #defined values for literals
References: <20060623163624.GM8866@austin.ibm.com>
In-Reply-To: <20060623163624.GM8866@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2006 18:08:04.0742 (UTC) FILETIME=[F91D1260:01C696EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> Minor janitorial patch: use #defines for literal values.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Ack! I thought we had gotten these out already.

Cheers,

Auke



> 
> ----
>  drivers/net/e1000/e1000_main.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.17-rc6-mm2/drivers/net/e1000/e1000_main.c
> ===================================================================
> --- linux-2.6.17-rc6-mm2.orig/drivers/net/e1000/e1000_main.c	2006-06-13 18:13:30.000000000 -0500
> +++ linux-2.6.17-rc6-mm2/drivers/net/e1000/e1000_main.c	2006-06-23 11:27:47.000000000 -0500
> @@ -4663,8 +4663,8 @@ static pci_ers_result_t e1000_io_slot_re
>  	}
>  	pci_set_master(pdev);
>  
> -	pci_enable_wake(pdev, 3, 0);
> -	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
> +	pci_enable_wake(pdev, PCI_D3hot, 0);
> +	pci_enable_wake(pdev, PCI_D3cold, 0);
>  
>  	/* Perform card reset only on one instance of the card */
>  	if (PCI_FUNC (pdev->devfn) != 0)
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
