Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWGJSYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWGJSYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422747AbWGJSYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:24:53 -0400
Received: from xenotime.net ([66.160.160.81]:45196 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422746AbWGJSYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:24:53 -0400
Date: Mon, 10 Jul 2006 11:27:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, erich@areca.com.tw
Subject: [PATCH -mm] arcmsr: fix implicit func. decl.
Message-Id: <20060710112736.77a45088.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix implicit function declaration:
drivers/scsi/arcmsr/arcmsr_hba.c:410: warning: implicit declaration of function 'arcmsr_free_sysfs_attr'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/arcmsr/arcmsr.h |    1 +
 1 files changed, 1 insertion(+)

--- linux-2618-rc1mm1.orig/drivers/scsi/arcmsr/arcmsr.h
+++ linux-2618-rc1mm1/drivers/scsi/arcmsr/arcmsr.h
@@ -468,3 +468,4 @@ struct SENSE_DATA
 extern void arcmsr_post_Qbuffer(struct AdapterControlBlock *acb);
 extern struct class_device_attribute *arcmsr_host_attrs[];
 extern int arcmsr_alloc_sysfs_attr(struct AdapterControlBlock *acb);
+extern void arcmsr_free_sysfs_attr(struct AdapterControlBlock *acb);


---
