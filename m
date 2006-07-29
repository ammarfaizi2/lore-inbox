Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422678AbWG2HTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422678AbWG2HTz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWG2HTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:19:55 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:31104 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422678AbWG2HTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:19:54 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kbuild: hardcode value of YACC&LEX for aic7-triple-x
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:33 +0200
Message-Id: <11541575812597-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <20060729071540.GA6738@mars.ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

When we introduced -rR then aic7xxx no loger could pick up definition
of YACC&LEX from make - so do it explicit now.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/scsi/aic7xxx/aicasm/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aicasm/Makefile b/drivers/scsi/aic7xxx/aicasm/Makefile
index 8c91fda..b98c5c1 100644
--- a/drivers/scsi/aic7xxx/aicasm/Makefile
+++ b/drivers/scsi/aic7xxx/aicasm/Makefile
@@ -14,6 +14,8 @@ LIBS=	-ldb
 clean-files:= ${GENSRCS} ${GENHDRS} $(YSRCS:.y=.output) $(PROG)
 # Override default kernel CFLAGS.  This is a userland app.
 AICASM_CFLAGS:= -I/usr/include -I.
+LEX= flex
+YACC= bison
 YFLAGS= -d
 
 NOMAN=	noman
-- 
1.4.1.rc2.gfc04

