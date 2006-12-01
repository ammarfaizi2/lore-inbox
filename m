Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967518AbWLAPug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967518AbWLAPug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967534AbWLAPug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:50:36 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:10250 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967518AbWLAPuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:50:35 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <wtarreau@hera.kernel.org>
Subject: [2.4 PATCH] ia64 kernel entry fix
Date: Fri, 1 Dec 2006 16:50:09 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011650.09717.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I noticed some parenthesis thing here but I'd be glad if anyone would 
confirm thath the patch below is correct. This code looks magic to me ;-)

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/ia64/kernel/entry.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.4.34-pre6-a/arch/ia64/kernel/entry.h	2003-11-28 19:26:19.000000000 +0100
+++ linux-2.4.34-pre6-b/arch/ia64/kernel/entry.h	2006-12-01 12:05:58.000000000 +0100
@@ -49,7 +49,7 @@
 	.spillsp @priunat,SW(AR_UNAT)+16+(off);					\
 	.spillsp ar.rnat,SW(AR_RNAT)+16+(off);					\
 	.spillsp ar.bspstore,SW(AR_BSPSTORE)+16+(off);				\
-	.spillsp pr,SW(PR)+16+(off))
+	.spillsp pr,SW(PR)+16+(off);
 
 #define DO_SAVE_SWITCH_STACK			\
 	movl r28=1f;				\


-- 
Regards,

	Mariusz Kozlowski
