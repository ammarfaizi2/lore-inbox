Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWBTRhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWBTRhF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWBTRhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:37:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50332 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161072AbWBTRhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:37:03 -0500
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060220154404.0383313F93@rhn.tartu-labor>
References: <20060220154404.0383313F93@rhn.tartu-labor>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Feb 2006 17:40:57 +0000
Message-Id: <1140457257.26526.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-20 at 17:44 +0200, Meelis Roos wrote:
> AC> Various fixes and cleanups, some new functionality notably Promise
> AC> 20246/2026x support which although basic should get it going with disk.
> 
> So I enabled more config options as before and got a compile error:
> 
> --- drivers/scsi/pata_pcmcia.c.orig	2006-02-20 17:41:01.000000000 +0200
> +++ drivers/scsi/pata_pcmcia.c	2006-02-20 17:41:10.000000000 +0200
> @@ -377,7 +377,7 @@
>  
>  static struct pcmcia_driver pcmcia_driver = {
>  	.owner		= THIS_MODULE,
> -	.drv	{
> +	.drv	= {

Changed - strangely gcc 3.4.4 doesn't seem to mind the old code. Also
added the PCMCIA dep check you pointed out.

Thanks
Alan

