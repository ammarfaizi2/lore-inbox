Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUF3Aex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUF3Aex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUF3Aex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:34:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3042 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S266163AbUF3Adr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:33:47 -0400
Date: Tue, 29 Jun 2004 17:33:40 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PPC4xx preempt fix
Message-ID: <20040629173340.G27896@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PPC4xx preempt fixes. Based on previous Classic PPC patch.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

 arch/ppc/kernel/head_44x.S |    2 +-
 arch/ppc/kernel/head_4xx.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
--- 1.9/arch/ppc/kernel/head_44x.S	2004-06-02 12:08:05 -07:00
+++ edited/arch/ppc/kernel/head_44x.S	2004-06-08 12:02:32 -07:00
@@ -680,7 +680,7 @@
 	mfspr	r4,SPRN_ESR		/* Grab the ESR and save it */
 	stw	r4,_ESR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x700, ProgramCheckException)
+	EXC_XFER_STD(0x700, ProgramCheckException)
 
 	/* Floating Point Unavailable Interrupt */
 	EXCEPTION(0x2010, FloatingPointUnavailable, UnknownException, EXC_XFER_EE)
--- 1.34/arch/ppc/kernel/head_4xx.S	2004-06-02 12:08:05 -07:00
+++ edited/arch/ppc/kernel/head_4xx.S	2004-06-08 12:02:48 -07:00
@@ -451,7 +451,7 @@
 	mfspr	r4,SPRN_ESR		/* Grab the ESR and save it */
 	stw	r4,_ESR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0x700, ProgramCheckException)
+	EXC_XFER_STD(0x700, ProgramCheckException)
 
 	EXCEPTION(0x0800, Trap_08, UnknownException, EXC_XFER_EE)
 	EXCEPTION(0x0900, Trap_09, UnknownException, EXC_XFER_EE)
