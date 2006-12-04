Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936962AbWLDO4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936962AbWLDO4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936956AbWLDO4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:56:12 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:16621 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936962AbWLDO4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:56:03 -0500
Date: Mon, 4 Dec 2006 15:55:58 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] set KBUILD_IMAGE.
Message-ID: <20061204145558.GZ32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] set KBUILD_IMAGE.

Set KBUILD_IMAGE to a sane value. This enables "make rpm"

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Makefile |    3 +++
 1 files changed, 3 insertions(+)

diff -urpN linux-2.6/arch/s390/Makefile linux-2.6-patched/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/Makefile	2006-12-04 14:50:58.000000000 +0100
@@ -35,6 +35,9 @@ cflags-$(CONFIG_MARCH_Z900) += $(call cc
 cflags-$(CONFIG_MARCH_Z990) += $(call cc-option,-march=z990)
 cflags-$(CONFIG_MARCH_Z9_109) += $(call cc-option,-march=z9-109)
 
+#KBUILD_IMAGE is necessary for make rpm
+KBUILD_IMAGE	:=arch/s390/boot/image
+
 #
 # Prevent tail-call optimizations, to get clearer backtraces:
 #
