Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWG2HV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWG2HV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWG2HT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:19:59 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:31360 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422684AbWG2HTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:19:54 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kbuild: -fno-stack-protector is not good
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:38 +0200
Message-Id: <11541575811787-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <11541575813138-git-send-email-sam@ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <11541575813716-git-send-email-sam@ravnborg.org> <11541575811267-git-send-email-sam@ravnborg.org> <1154157581409-git-send-email-sam@ravnborg.org> <11541575813138-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Ubuntu gcc has hardcoded -fstack-protector - but does not understand
-fno-stack-protector-all. So only try -fno-stack-protector.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 60e09f2..07b8f34 100644
--- a/Makefile
+++ b/Makefile
@@ -310,8 +310,8 @@ CPPFLAGS        := -D__KERNEL__ $(LINUXI
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                    -fno-strict-aliasing -fno-common
 # Force gcc to behave correct even for buggy distributions
-CFLAGS          += $(call cc-option, -fno-stack-protector-all \
-                                     -fno-stack-protector)
+CFLAGS          += $(call cc-option, -fno-stack-protector)
+
 AFLAGS          := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
-- 
1.4.1.rc2.gfc04

