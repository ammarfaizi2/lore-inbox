Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVIIU4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVIIU4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVIIU4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:56:47 -0400
Received: from mail20.bluewin.ch ([195.186.19.65]:62876 "EHLO
	mail20.bluewin.ch") by vger.kernel.org with ESMTP id S1030338AbVIIU4q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:56:46 -0400
Date: Fri, 9 Sep 2005 16:56:28 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: Kill off CONFIG_PC
Message-ID: <20050909205628.GA3795@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

CONFIG_PC is defined but isn't actually used anywhere:

  apgo@krypton:~/devel/kernel/b$ grep -rw CONFIG_PC *
  arch/i386/defconfig:CONFIG_PC=y
  apgo@krypton:~/devel/kernel/b$

My impression is that this is left-over cruft after the introduction
of CONFIG_X86_PC with the subarch split..

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 arch/i386/Kconfig |    5 -----
 1 file changed, 5 deletions(-)

--- a/arch/i386/Kconfig	2005-08-29 16:49:22.000000000 -0400
+++ b/arch/i386/Kconfig	2005-09-09 16:44:39.000000000 -0400
@@ -1332,8 +1332,3 @@ config X86_TRAMPOLINE
 	bool
 	depends on X86_SMP || (X86_VOYAGER && SMP)
 	default y
-
-config PC
-	bool
-	depends on X86 && !EMBEDDED
-	default y
