Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVBHFyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVBHFyC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 00:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVBHFyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 00:54:02 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:20538 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S261470AbVBHFxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 00:53:55 -0500
Message-ID: <420853A2.2010405@spirentcom.com>
Date: Mon, 07 Feb 2005 21:52:34 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.29-bk8] Resend: sym53c8xx.c: Add ULL suffix to fix
 warning
References: <420845CE.50908@spirentcom.com>
In-Reply-To: <420845CE.50908@spirentcom.com>
Content-Type: multipart/mixed;
 boundary="------------080502000901090002030300"
X-OriginalArrivalTime: 08 Feb 2005 05:53:54.0571 (UTC) FILETIME=[929F65B0:01C50DA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502000901090002030300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mark F. Haigh wrote:
> 
> --- drivers/scsi/sym53c8xx.c.orig	2005-02-07 19:53:05.741527608 -0800
> +++ drivers/scsi/sym53c8xx.c	2005-02-07 19:53:36.782808616 -0800

Apologies.  Patch now -p1-able.


Mark F. Haigh
Mark.Haigh@spirentcom.com

Signed-off-by: Mark F. Haigh  <Mark.Haigh@spirentcom.com>

--------------080502000901090002030300
Content-Type: text/plain;
 name="sym53c8xx-patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym53c8xx-patch2"

--- linux-2.4.29-bk8/drivers/scsi/sym53c8xx.c.orig	2005-02-07 19:53:05.000000000 -0800
+++ linux-2.4.29-bk8/drivers/scsi/sym53c8xx.c	2005-02-07 19:53:36.000000000 -0800
@@ -13182,7 +13182,7 @@
 	** descriptors.
 	*/
 	if (chip && (chip->features & FE_DAC)) {
-		if (pci_set_dma_mask(pdev, (u64) 0xffffffffff))
+		if (pci_set_dma_mask(pdev, (u64) 0xffffffffffULL))
 			chip->features &= ~FE_DAC_IN_USE;
 		else
 			chip->features |= FE_DAC_IN_USE;

--------------080502000901090002030300--
