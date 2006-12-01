Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936478AbWLALyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936478AbWLALyJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 06:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936482AbWLALyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 06:54:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64006 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S936478AbWLALyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 06:54:05 -0500
Date: Fri, 1 Dec 2006 12:54:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Roy Zang <tie-fei.zang@freescale.com>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [2.6 patch] arch/powerpc/Kconfig: fix the EMBEDDED6xx dependencies
Message-ID: <20061201115410.GV11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the EMBEDDED6xx dependencies to the equivalent 
dependency that seems to have been intended.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Nov 2006

--- linux-2.6.19-rc5-mm2/arch/powerpc/Kconfig.old	2006-11-22 02:24:21.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/powerpc/Kconfig	2006-11-22 02:24:34.000000000 +0100
@@ -369,7 +369,7 @@ config PPC_MULTIPLATFORM
 
 config EMBEDDED6xx
 	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
+	depends on PPC32 && BROKEN_ON_SMP
 
 config APUS
 	bool "Amiga-APUS"

