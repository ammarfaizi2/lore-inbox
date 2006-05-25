Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWEYO11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWEYO11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWEYO10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:27:26 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:27572 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1030184AbWEYO10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:27:26 -0400
Date: Thu, 25 May 2006 10:17:14 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] Well, Linus seems to like Lordi...
Message-ID: <20060525141714.GA31604@skunkworks.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we're going to have release code names for the kernel, might as well
advertise them somewhere. :)

Signed-off-by: Kyle McMartin <kyle@there.is.no.cabal.ca>

--- a/Makefile
+++ b/Makefile
@@ -841,6 +841,7 @@ define filechk_version.h
 	  exit 1; \
 	fi; \
 	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\"; \
+	  echo \#define LINUX_CODE_NAME \"$(NAME)\"; \
 	  echo \#define LINUX_VERSION_CODE `expr $(VERSION) \\* 65536 + $(PATCHLEVEL) \\* 256 + $(SUBLEVEL)`; \
 	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
 	)
diff --git a/init/version.c b/init/version.c
index 3ddc3ce..97cc8ec 100644
--- a/init/version.c
+++ b/init/version.c
@@ -29,5 +29,6 @@ struct new_utsname system_utsname = {
 EXPORT_SYMBOL(system_utsname);
 
 const char linux_banner[] =
-	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+	"Linux version " UTS_RELEASE " \"" LINUX_CODE_NAME "\" (" 
+	LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") "
+	UTS_VERSION "\n";
