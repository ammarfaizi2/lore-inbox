Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVAJCv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVAJCv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVAJCvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:51:55 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:51390 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262056AbVAJCvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:51:47 -0500
Date: Mon, 10 Jan 2005 03:51:12 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: [PATCH] Fix gcc 4 compilation in ACPI
Message-ID: <20050110025112.GA5672@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc 4 compilation in ACPI processor driver

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/acpi/processor.h
===================================================================
--- linux.orig/include/acpi/processor.h	2005-01-04 18:48:48.%N +0100
+++ linux/include/acpi/processor.h	2005-01-09 01:34:55.%N +0100
@@ -177,7 +177,6 @@
 /* for communication between multiple parts of the processor kernel module */
 extern struct acpi_processor	*processors[NR_CPUS];
 extern struct acpi_processor_errata errata;
-extern void (*pm_idle_save)(void);
 
 /* in processor_perflib.c */
 #ifdef CONFIG_CPU_FREQ
