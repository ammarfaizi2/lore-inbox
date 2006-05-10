Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWEJC54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWEJC54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWEJC5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:30 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:6462 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932443AbWEJC4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:50 -0400
Date: Tue, 9 May 2006 19:56:08 -0700
Message-Id: <200605100256.k4A2u88J031785@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] tpm_register_hardware gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

drivers/char/tpm/tpm.c: In function 'tpm_register_hardware':
drivers/char/tpm/tpm.c:1157: warning: assignment from incompatible pointer type

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/char/tpm/tpm.h
===================================================================
--- linux-2.6.16.orig/drivers/char/tpm/tpm.h
+++ linux-2.6.16/drivers/char/tpm/tpm.h
@@ -140,7 +140,7 @@ extern int tpm_pm_resume(struct device *
 extern struct dentry ** tpm_bios_log_setup(char *);
 extern void tpm_bios_log_teardown(struct dentry **);
 #else
-static inline struct dentry* tpm_bios_log_setup(char *name)
+static inline struct dentry ** tpm_bios_log_setup(char *name)
 {
 	return NULL;
 }
