Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUJVRZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUJVRZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUJVRVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:21:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9680 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266547AbUJVROe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:14:34 -0400
Date: Fri, 22 Oct 2004 12:14:26 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] increase max LOG_BUF_SHIFT value
Message-ID: <20041022171425.GN3887@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've run into problems at 512p with the kernel log buffer wrapping and
overwriting some of the early boot output.  This is with a
CONFIG_LOG_BUF_SHIFT value of 20 (1MB).  The patch below just bumps the
max possible setting to 21 (2MB).

Signed-off-by: Greg Edwards <edwardsg@sgi.com>

Regards,
Greg Edwards


 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work-26-bk/init/Kconfig
===================================================================
--- work-26-bk.orig/init/Kconfig	2004-10-21 15:38:25.000000000 -0500
+++ work-26-bk/init/Kconfig	2004-10-22 11:54:55.000000000 -0500
@@ -171,7 +171,7 @@ config AUDITSYSCALL
 
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
-	range 12 20
+	range 12 21
 	default 17 if ARCH_S390
 	default 16 if X86_NUMAQ || IA64
 	default 15 if SMP
