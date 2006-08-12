Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbWHLVCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWHLVCG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWHLVCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:02:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422693AbWHLVCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:02:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=c2awOK0Y9nBJLpr5CXS+9qjJnqiCR8UT4z5DKUi6MhMwYW4/0bNs9MSvzWtW56BUKi5lhHwW4i7+WV3O6s9zvVfNIZjz+z8Y3WbOiKEVx+ceUldlLqe11n8dHnaexVjbm0bgj0wvdWYdSs32QaWdk8qVz3eDnz+g/Hq2Ir+njyE=
Message-ID: <44DE41ED.3090607@gmail.com>
Date: Sat, 12 Aug 2006 23:02:37 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       Achim Leubner <achim_leubner@adaptec.com>
Subject: Re: [RFC] [PATCH 3/9] drivers/scsi/gdth.h Removal of old scsi code
References: <44DE3E5E.3020605@gmail.com>
In-Reply-To: <44DE3E5E.3020605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/gdth.h linux-work/drivers/scsi/gdth.h
--- linux-work-clean/drivers/scsi/gdth.h	2006-08-12 01:51:16.000000000 +0200
+++ linux-work/drivers/scsi/gdth.h	2006-08-12 20:49:38.000000000 +0200
@@ -936,18 +936,12 @@ typedef struct {
     gdth_binfo_str      binfo;                  /* controller info */
     gdth_evt_data       dvr;                    /* event structure */
     spinlock_t          smp_lock;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     struct pci_dev      *pdev;
-#endif
     char                oem_name[8];
 #ifdef GDTH_DMA_STATISTICS
     ulong               dma32_cnt, dma64_cnt;   /* statistics: DMA buffer */
 #endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
     struct scsi_device         *sdev;
-#else
-    struct scsi_device         sdev;
-#endif
 } gdth_ha_str;

 /* structure for scsi_register(), SCSI bus != 0 */
@@ -1029,10 +1023,6 @@ typedef struct {

 /* function prototyping */

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 int gdth_proc_info(struct Scsi_Host *, char *,char **,off_t,int,int);
-#else
-int gdth_proc_info(char *,char **,off_t,int,int,int);
-#endif

 #endif



