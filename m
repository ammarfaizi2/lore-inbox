Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbWBUU4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbWBUU4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWBUU4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:56:39 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3272 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932728AbWBUU4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:56:38 -0500
Date: Tue, 21 Feb 2006 12:56:36 -0800
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 6/6] PCI legacy I/O port free driver (take2) - Make Emulex lpfc driver legacy I/O port free
Message-ID: <20060221205636.GA12427@kroah.com>
References: <43FAB283.8090206@jp.fujitsu.com> <43FAB444.7010401@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FAB444.7010401@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 03:33:40PM +0900, Kenji Kaneshige wrote:
> This patch makes lpfc driver legacy I/O port free.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> 
>  drivers/scsi/lpfc/lpfc_init.c |   54 +++++++++++++++++++++---------------------
>  1 files changed, 27 insertions(+), 27 deletions(-)
> 
> Index: linux-2.6.16-rc4/drivers/scsi/lpfc/lpfc_init.c
> ===================================================================
> --- linux-2.6.16-rc4.orig/drivers/scsi/lpfc/lpfc_init.c	2006-02-21 14:40:03.000000000 +0900
> +++ linux-2.6.16-rc4/drivers/scsi/lpfc/lpfc_init.c	2006-02-21 14:40:57.000000000 +0900
> @@ -1715,59 +1715,59 @@
>  
>  static struct pci_device_id lpfc_id_table[] = {
>  	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_VIPER,
> -		PCI_ANY_ID, PCI_ANY_ID, },
> +	 PCI_ANY_ID, PCI_ANY_ID, .device_flags = PCI_DEVICE_ID_FLAG_NOIOPORT},

Might just be easier to use PCI_DEVICE() here instead, right?

thanks,

greg k-h
