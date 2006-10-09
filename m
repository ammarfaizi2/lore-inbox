Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932919AbWJIPWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932919AbWJIPWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbWJIPWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:22:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35768 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932919AbWJIPWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:22:15 -0400
Date: Mon, 9 Oct 2006 16:22:09 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] extern doesn't make sense on a definition of function...
Message-ID: <20061009152209.GP29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kernel/irq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 829ac18..5e37bf1 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -572,8 +572,8 @@ unsigned int irq_create_mapping(struct i
 }
 EXPORT_SYMBOL_GPL(irq_create_mapping);
 
-extern unsigned int irq_create_of_mapping(struct device_node *controller,
-					  u32 *intspec, unsigned int intsize)
+unsigned int irq_create_of_mapping(struct device_node *controller,
+				   u32 *intspec, unsigned int intsize)
 {
 	struct irq_host *host;
 	irq_hw_number_t hwirq;
-- 
1.4.2.GIT
