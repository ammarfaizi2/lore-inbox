Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWJKQWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWJKQWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWJKQWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:22:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47548 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161102AbWJKQWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:22:45 -0400
To: torvalds@osdl.org
Subject: [PATCH] arm __user annotations
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Message-Id: <E1GXgqy-0005U2-Ct@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:22:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/vfp/vfpmodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index dedbb44..a657a28 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -90,7 +90,7 @@ void vfp_raise_sigfpe(unsigned int sicod
 
 	info.si_signo = SIGFPE;
 	info.si_code = sicode;
-	info.si_addr = (void *)(instruction_pointer(regs) - 4);
+	info.si_addr = (void __user *)(instruction_pointer(regs) - 4);
 
 	/*
 	 * This is the same as NWFPE, because it's not clear what
-- 
1.4.2.GIT


