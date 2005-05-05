Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVEEN0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVEEN0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVEEN0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 09:26:25 -0400
Received: from everest.sosdg.org ([66.93.203.161]:12778 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S262104AbVEEN0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 09:26:23 -0400
From: "Coywolf Qi Hunt" <coywolf@lovecn.org>
Date: Thu, 5 May 2005 21:26:10 +0800
To: sam@ravnborg.org
Cc: kai@germaschewski.name, akpm@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <20050505132610.GA21833@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Scan-Signature: 5e46532232fd70c4de6004b73fafcbb3
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: [patch] kbuild: display compile version
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.2 (built Tue, 12 Apr 2005 17:41:13 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I am always trying to make sure I've booted the right kernel after a new install.
Too paranoid maybe. But I guess there're other people like me. So let's make kbuild
display the compile version number at the end to give us a hint. I know we may be
booting vmlinux someday, but don't care about it for now.


Signed-off-by: Coywolf Qi Hunt <coywolf@lovecn.org>

--- 2.6.12-rc3-mm3/arch/i386/boot/Makefile	2005-05-05 18:52:51.000000000 +0800
+++ 2.6.12-rc3-mm3-cy/arch/i386/boot/Makefile	2005-05-05 20:45:57.000000000 +0800
@@ -48,7 +48,7 @@
 $(obj)/zImage $(obj)/bzImage: $(obj)/bootsect $(obj)/setup \
 			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
 	$(call if_changed,image)
-	@echo 'Kernel: $@ is ready'
+	@echo 'Kernel: $@ is ready' '(#'`cat .version`')'
 
 $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
