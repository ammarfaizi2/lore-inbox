Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVLZM6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVLZM6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 07:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVLZM6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 07:58:15 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:16359 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750722AbVLZM6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 07:58:14 -0500
Date: Mon, 26 Dec 2005 02:47:18 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tags file generation fixup
Message-ID: <20051226014718.GA4766@implementation>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a fixup for tags file generation, for proper tags of
__releases/__acquires functions.

Regards,
Samuel

Signed-off-by: samuel.thibault@ens-lyon.org

--- Makefile.orig	2005-12-26 02:43:06.000000000 +0100
+++ Makefile	2005-12-26 02:43:46.000000000 +0100
@@ -1227,7 +1227,7 @@
 quiet_cmd_TAGS = MAKE   $@
 define cmd_TAGS
 	rm -f $@; \
-	ETAGSF=`etags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
+	ETAGSF=`etags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,__acquires,__releases,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
 	$(all-sources) | xargs etags $$ETAGSF -a
 endef
 
@@ -1238,7 +1238,7 @@
 quiet_cmd_tags = MAKE   $@
 define cmd_tags
 	rm -f $@; \
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,__acquires,__releases,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
 	$(all-sources) | xargs ctags $$CTAGSF -a
 endef
 
