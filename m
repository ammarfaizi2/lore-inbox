Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWEBLQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWEBLQs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWEBLQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:16:48 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34436 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932190AbWEBLQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:16:47 -0400
Date: Tue, 02 May 2006 20:16:11 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH](trivial) cleanup redundant EXPORT_SYMBOL in arch/ia64/mm/init.c
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060502201353.CF12.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is tiny cleanup patch.

EXPORT_SYMBOL(add_memory) in arch/ia64/mm/init.c is redundant.
The old add_memory() has been already arch_add_memory(),
but it is not called by acpi memhotplug modules.

This is for 2.6.17-rc3-mm1.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 arch/ia64/mm/init.c |    1 -
 1 files changed, 1 deletion(-)

Index: pgdat13/arch/ia64/mm/init.c
===================================================================
--- pgdat13.orig/arch/ia64/mm/init.c	2006-05-02 13:00:47.000000000 +0900
+++ pgdat13/arch/ia64/mm/init.c	2006-05-02 18:27:27.000000000 +0900
@@ -671,7 +671,6 @@ int arch_add_memory(int nid, u64 start, 
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(add_memory);
 
 int remove_memory(u64 start, u64 size)
 {

-- 
Yasunori Goto 


