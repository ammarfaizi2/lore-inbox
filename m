Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWCUQgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWCUQgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWCUQf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:35:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28940 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932421AbWCUQVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:11 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 08/46] kbuild: avoid stale modules in $(MODVERDIR) for external modules
In-Reply-To: <11429580542554-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:55 +0100
Message-Id: <11429580552387-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid stale modules located in $(MODVERDIR) aka .tmp_versions/
always delete the directory when building an external module.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

fb3cbd2e575f9ac0700bfa1e7cb9f4119fbd0abd
diff --git a/Makefile b/Makefile
index 1db819e..fdb3dac 100644
--- a/Makefile
+++ b/Makefile
@@ -1126,6 +1126,7 @@ else # KBUILD_EXTMOD
 KBUILD_MODULES := 1
 .PHONY: crmodverdir
 crmodverdir:
+	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
 
 .PHONY: $(objtree)/Module.symvers
-- 
1.0.GIT


