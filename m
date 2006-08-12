Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWHLVBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWHLVBW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWHLVBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:01:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:28050 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422687AbWHLVBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:01:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=X38tkcxMP/nhz//7uRBE43XGaG9FOwIYDWCVyV6KYzp+2j555wvIebRBD1crryz/XG7Ol54RXkBlWrjlRWjCWmjOCLCOkRHlB4CVbn/2yWh5BovCDECln5m/ZXSC3Re2y6cVmusL4voROPNxVd7xwbTgtPA9yrVPFI4YgXbUjY4=
Message-ID: <44DE41C3.2050308@gmail.com>
Date: Sat, 12 Aug 2006 23:01:55 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH 1/9] drivers/scsi/dpt/dpti_i2o.h Removal of old
 scsi code
References: <44DE3E5E.3020605@gmail.com>
In-Reply-To: <44DE3E5E.3020605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/dpt/dpti_i2o.h linux-work/drivers/scsi/dpt/dpti_i2o.h
--- linux-work-clean/drivers/scsi/dpt/dpti_i2o.h	2006-08-12 01:51:16.000000000 +0200
+++ linux-work/drivers/scsi/dpt/dpti_i2o.h	2006-08-12 20:54:40.000000000 +0200
@@ -47,21 +47,11 @@
  *	I2O Interface Objects
  */

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-
-#define DECLARE_MUTEX(name) struct semaphore name=MUTEX
-
-typedef struct wait_queue *adpt_wait_queue_head_t;
-#define ADPT_DECLARE_WAIT_QUEUE_HEAD(wait) adpt_wait_queue_head_t wait = NULL
-typedef struct wait_queue adpt_wait_queue_t;
-#else
-
 #include <linux/wait.h>
 typedef wait_queue_head_t adpt_wait_queue_head_t;
 #define ADPT_DECLARE_WAIT_QUEUE_HEAD(wait) DECLARE_WAIT_QUEUE_HEAD(wait)
 typedef wait_queue_t adpt_wait_queue_t;

-#endif
 /*
  * message structures
  */


