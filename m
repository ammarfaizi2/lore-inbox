Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbVKWWhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbVKWWhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbVKWWfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:35:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:787 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030439AbVKWWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:35:06 -0500
Date: Wed, 23 Nov 2005 23:35:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [-mm patch] init/main.c: dummy mark_rodata_ro() should be static
Message-ID: <20051123223505.GF3963@stusta.de>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123033550.00d6a6e8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every inline dummy function should be static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc2-mm1-full/init/main.c.old	2005-11-23 16:50:45.000000000 +0100
+++ linux-2.6.15-rc2-mm1-full/init/main.c	2005-11-23 16:50:55.000000000 +0100
@@ -101,7 +101,7 @@
 static inline void acpi_early_init(void) { }
 #endif
 #ifndef CONFIG_DEBUG_RODATA
-inline void mark_rodata_ro(void) { }
+static inline void mark_rodata_ro(void) { }
 #endif
 
 #ifdef CONFIG_TC

