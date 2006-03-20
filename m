Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWCTSEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWCTSEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWCTSEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:04:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:4323 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751177AbWCTSED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:04:03 -0500
Date: Mon, 20 Mar 2006 12:03:42 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Paul Mackerras <paulus@samba.org>
cc: linuxppc-dev@ozlabs.org, <linuxppc-embedded@ozlabs.org>,
       <linux-kernel@vger.kernel.org>
Subject: Please pull from '83xx' branch of powerpc
Message-ID: <Pine.LNX.4.44.0603201202240.23637-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from '83xx' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/platforms/83xx/misc.c    |    2 +-
 arch/ppc/platforms/83xx/mpc834x_sys.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Horst Kronstorfer:
      ppc32: Fix BCSR_SIZE for MPC834x SYS

Kumar Gala:
      powerpc: Fix mpc83xx restart bug

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 0eb3d99..1455bce 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -35,7 +35,7 @@ void mpc83xx_restart(char *cmd)
 	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
 
 	/* set software hard reset */
-	out_be32(reg + (RST_CTRL_REG >> 2), 0x52535445);
+	out_be32(reg + (RST_CTRL_REG >> 2), 0x2);
 	for (;;) ;
 }
 
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h b/arch/ppc/platforms/83xx/mpc834x_sys.h
index aa86c22..6727bbd 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.h
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
@@ -23,7 +23,7 @@
 #define VIRT_IMMRBAR		((uint)0xfe000000)
 
 #define BCSR_PHYS_ADDR		((uint)0xf8000000)
-#define BCSR_SIZE		((uint)(128 * 1024))
+#define BCSR_SIZE		((uint)(32 * 1024))
 
 #define BCSR_MISC_REG2_OFF	0x07
 #define BCSR_MISC_REG2_PORESET	0x01


