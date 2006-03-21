Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWCUQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWCUQVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWCUQVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:35 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29196 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030336AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 42/46] kbuild: add -fverbose-asm to i386 Makefile
In-Reply-To: <1142958057424-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <11429580574142-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add -fverbose-asm to i386 Makefile rule for building .s files.  This makes
the assembler output much more readable for humans.

Suggested by Der Herr Hofrat <der.herr@hofr.at>

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/Makefile.build |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

7d1859835cd6c0afd1773d249300da82b1b868a5
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 19ef2bc..e48e60d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -129,7 +129,7 @@ $(multi-objs-y:.o=.s)   : modname = $(mo
 $(multi-objs-y:.o=.lst) : modname = $(modname-multi)
 
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
+cmd_cc_s_c       = $(CC) $(c_flags) -fverbose-asm -S -o $@ $<
 
 %.s: %.c FORCE
 	$(call if_changed_dep,cc_s_c)
-- 
1.0.GIT


