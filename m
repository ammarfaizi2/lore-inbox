Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWGaN4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWGaN4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWGaN4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:56:37 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:12024 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750849AbWGaN4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:56:15 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 3/6] AVR32: Add nsproxy definition
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Mon, 31 Jul 2006 15:55:57 +0200
Message-Id: <11543541602148-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11543541601753-git-send-email-hskinnemoen@atmel.com>
References: <1154354160566-git-send-email-hskinnemoen@atmel.com> <11543541601753-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch namespaces-add-nsproxy.patch defines nsproxy in all arches'
init_task.c. This does the same for AVR32

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/init_task.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/kernel/init_task.c b/arch/avr32/kernel/init_task.c
index effcacf..0c1a379 100644
--- a/arch/avr32/kernel/init_task.c
+++ b/arch/avr32/kernel/init_task.c
@@ -10,6 +10,7 @@ #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/init_task.h>
 #include <linux/mqueue.h>
+#include <linux/nsproxy.h>
 
 #include <asm/pgtable.h>
 
@@ -18,6 +19,7 @@ static struct files_struct init_files = 
 static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
 static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
 struct mm_struct init_mm = INIT_MM(init_mm);
+struct nsproxy init_nsproxy = INIT_NSPROXY(init_nsproxy);
 
 EXPORT_SYMBOL(init_mm);
 
-- 
1.4.0

