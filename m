Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVJCRcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVJCRcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVJCRcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:32:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22035 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932476AbVJCRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:32:15 -0400
Date: Mon, 3 Oct 2005 19:32:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/ldt.c should #include <asm/mmu_context.h>
Message-ID: <20051003173213.GA3652@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header files containing the prototypes of 
it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc2-mm2-full/arch/i386/kernel/ldt.c.old	2005-10-02 02:07:44.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/i386/kernel/ldt.c	2005-10-02 02:10:57.000000000 +0200
@@ -18,6 +18,7 @@
 #include <asm/system.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
+#include <asm/mmu_context.h>
 
 #ifdef CONFIG_SMP /* avoids "defined but not used" warnig */
 static void flush_ldt(void *null)
