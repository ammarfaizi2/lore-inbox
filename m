Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWGIO27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWGIO27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWGIO27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:28:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64269 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932154AbWGIO25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:28:57 -0400
Date: Sun, 9 Jul 2006 16:28:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Erich Chen <erich@areca.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [-mm patch] proper prototype for drivers/scsi/arcmsr/arcmsr_attr.c:arcmsr_free_sysfs_attr()
Message-ID: <20060709142856.GI13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 02:11:06AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm6:
>...
> +areca-raid-linux-scsi-driver-update7.patch
>...
>  Update drivers-scsi-arcmsr-cleanups.patch
>...

<--  snip  -->

...
  CC      drivers/scsi/arcmsr/arcmsr_hba.o
drivers/scsi/arcmsr/arcmsr_hba.c: In function ‘arcmsr_remove’:
drivers/scsi/arcmsr/arcmsr_hba.c:410: error: implicit declaration of function ‘arcmsr_free_sysfs_attr’

<--  snip  -->

Let's add a proper prototype for arcmsr_free_sysfs_attr().

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc1-mm1-full/drivers/scsi/arcmsr/arcmsr.h.old	2006-07-09 12:29:42.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/drivers/scsi/arcmsr/arcmsr.h	2006-07-09 12:33:29.000000000 +0200
@@ -468,3 +468,5 @@
 extern void arcmsr_post_Qbuffer(struct AdapterControlBlock *acb);
 extern struct class_device_attribute *arcmsr_host_attrs[];
 extern int arcmsr_alloc_sysfs_attr(struct AdapterControlBlock *acb);
+void arcmsr_free_sysfs_attr(struct AdapterControlBlock *acb);
+

