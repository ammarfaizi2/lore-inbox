Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVAPIIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVAPIIl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 03:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVAPIIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 03:08:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27919 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262452AbVAPIFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 03:05:08 -0500
Date: Sun, 16 Jan 2005 09:05:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, discuss@x86-64.org
Subject: [2.6 patch] i386/x86_64 i8259.c: make mask_and_ack_8259A static
Message-ID: <20050116080505.GE4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


diffstat output:
 arch/i386/kernel/i8259.c   |    4 ++--
 arch/x86_64/kernel/i8259.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/i8259.c.old	2005-01-16 04:36:28.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/i8259.c	2005-01-16 04:36:48.000000000 +0100
@@ -50,7 +50,7 @@
 
 #define shutdown_8259A_irq	disable_8259A_irq
 
-void mask_and_ack_8259A(unsigned int);
+static void mask_and_ack_8259A(unsigned int);
 
 unsigned int startup_8259A_irq(unsigned int irq)
 { 
@@ -170,7 +170,7 @@
  * first, _then_ send the EOI, and the order of EOI
  * to the two 8259s is important!
  */
-void mask_and_ack_8259A(unsigned int irq)
+static void mask_and_ack_8259A(unsigned int irq)
 {
 	unsigned int irqmask = 1 << irq;
 	unsigned long flags;
--- linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/i8259.c.old	2005-01-16 04:38:11.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/i8259.c	2005-01-16 04:37:07.000000000 +0100
@@ -149,7 +149,7 @@
 
 #define shutdown_8259A_irq	disable_8259A_irq
 
-void mask_and_ack_8259A(unsigned int);
+static void mask_and_ack_8259A(unsigned int);
 
 static unsigned int startup_8259A_irq(unsigned int irq)
 { 
@@ -273,7 +273,7 @@
  * first, _then_ send the EOI, and the order of EOI
  * to the two 8259s is important!
  */
-void mask_and_ack_8259A(unsigned int irq)
+static void mask_and_ack_8259A(unsigned int irq)
 {
 	unsigned int irqmask = 1 << irq;
 	unsigned long flags;

