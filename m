Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUIGTHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUIGTHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUIGTEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:04:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14093 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268449AbUIGTCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:02:43 -0400
Date: Tue, 7 Sep 2004 21:02:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.9-rc1-mm4: Makefile: remove tabs from empty lines
Message-ID: <20040907190212.GB2454@fs.tum.de>
References: <20040907020831.62390588.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907020831.62390588.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
>...
>  bk-kbuild.patch
>...
>  Latest versions of external trees
>...


Emacs warns me at every saving of the toplevel Makefile since it 
considers empty lines with a tab suspicious.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm4-full-3.4/Makefile.old	2004-09-07 20:54:15.000000000 +0200
+++ linux-2.6.9-rc1-mm4-full-3.4/Makefile	2004-09-07 20:56:16.000000000 +0200
@@ -591,7 +591,7 @@
 	. $(srctree)/scripts/mkversion > .tmp_version;	\
 	mv -f .tmp_version .version;			\
 	$(MAKE) $(build)=init
-	
+
 # Generate System.map
 quiet_cmd_sysmap = SYSMAP 
       cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
@@ -602,10 +602,10 @@
 
 define rule_vmlinux__
 	$(if $(CONFIG_KALLSYMS),,$(call cmd,vmlinux_version))
-	
+
 	$(call cmd,vmlinux__)
 	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
-	
+
 	$(Q)$(if $($(quiet)cmd_sysmap),                 \
 	  echo '  $($(quiet)cmd_sysmap) System.map' &&) \
 	$(cmd_sysmap) $@ System.map;                    \

