Return-Path: <linux-kernel-owner+w=401wt.eu-S1762261AbWLJRJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762261AbWLJRJo (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762268AbWLJRJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:09:44 -0500
Received: from il.qumranet.com ([62.219.232.206]:33982 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762261AbWLJRJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:09:43 -0500
Subject: [PATCH 1/4] KVM: Add missing include
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 10 Dec 2006 17:09:42 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457C3F26.2090100@qumranet.com>
In-Reply-To: <457C3F26.2090100@qumranet.com>
Message-Id: <20061210170942.6AB862500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Liguori <anthony@codemonkey.ws>

load_TR_desc() lives in asm/desc.h, so #include that file.

Signed-off-by: Anthony Liguori <anthony@codemonkey.ws>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <asm/io.h>
+#include <asm/desc.h>
 
 #include "segment_descriptor.h"
 
