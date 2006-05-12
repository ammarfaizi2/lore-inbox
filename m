Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWELWK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWELWK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWELWK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:10:58 -0400
Received: from mail0.lsil.com ([147.145.40.20]:21945 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932267AbWELWK6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:10:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Bug 6537] New: #ifdef CONFIG_PM causes MPT to not compile
Date: Fri, 12 May 2006 16:10:34 -0600
Message-ID: <664A4EBB07F29743873A87CF62C26D700F9DBD@NAMAIL4.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Bug 6537] New: #ifdef CONFIG_PM causes MPT to not compile
Thread-Index: AcZ147gcuE5GbQnEQLmSBOU832SFlAALNO3g
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Cc: <linux-kernel@vger.kernel.org>, <bill@crowellsystems.com>,
       <bugme-daemon@osdl.org>
X-OriginalArrivalTime: 12 May 2006 22:10:36.0106 (UTC) FILETIME=[E50D82A0:01C67610]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 12, 2006 10:46 AM, Alexey Dobriyan wrote:  

> This patch fixes your anonymous compilation problems?
> 
> [PATCH] mptspi: fix compilation with CONFIG_PM=n
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> --- a/drivers/message/fusion/mptspi.c
> +++ b/drivers/message/fusion/mptspi.c
> @@ -831,6 +831,7 @@ mptspi_ioc_reset(MPT_ADAPTER *ioc, int r
>  	return rc;
>  }
>  
> +#ifdef CONFIG_PM
>  /*
>   * spi module resume handler
>   */
> @@ -846,6 +847,7 @@ mptspi_resume(struct pci_dev *pdev)
>  
>  	return rc;
>  }
> +#endif
>  

ACK

Alex, thanks.  Can you post this patch over on the linux-scsi@ list, and
copy James Bottomley?   

Thankyou,
Eric Moore
