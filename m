Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262550AbVGKVOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbVGKVOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262654AbVGKVNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:13:15 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:8398 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262751AbVGKVKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:10:35 -0400
Subject: [PATCH 27/29v2] Hook up userspace CM to the make system
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110436.4389.5038.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 17:02:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hook up userspace CM to the make system 
Signed-off-by: Libor Michalek <libor@topspin.com>
Signed-off-by: Hal Rosenstock <halr@voltaire.com>

This patch depends on patch 26/29.

--
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
diff -uprN linux-2.6.13-rc2-mm1-26/drivers/infiniband/core/Makefile linux-2.6.13-rc2-mm1-27/drivers/infiniband/core/Makefile
-- linux-2.6.13-rc2-mm1-26/drivers/infiniband/core/Makefile	2005-07-10 16:50:04.000000000 -0400
+++ linux-2.6.13-rc2-mm1-27/drivers/infiniband/core/Makefile	2005-07-10 16:59:52.000000000 -0400
@@ -1,7 +1,7 @@
 EXTRA_CFLAGS += -Idrivers/infiniband/include
 
 obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_mad.o ib_sa.o \
-					ib_cm.o ib_umad.o
+					ib_cm.o ib_umad.o ib_ucm.o
 obj-$(CONFIG_INFINIBAND_USER_VERBS) +=	ib_uverbs.o
 
 ib_core-y :=			packer.o ud_header.o verbs.o sysfs.o \
@@ -15,4 +15,6 @@ ib_cm-y :=			cm.o
 
 ib_umad-y :=			user_mad.o
 
+ib_ucm-y :=			ucm.o
+
 ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_mem.o


