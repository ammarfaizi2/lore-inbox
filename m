Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbSLDPg6>; Wed, 4 Dec 2002 10:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266701AbSLDPg6>; Wed, 4 Dec 2002 10:36:58 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:49027 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S266693AbSLDPg5>;
	Wed, 4 Dec 2002 10:36:57 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Wed, 4 Dec 2002 16:44:28 +0100
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] debug messages in ide-floppy.c
Message-ID: <20021204154428.GA3668@pc11.op.pod.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  The debug messages are on by mistake IMHO in ide-floppy.c since 2.5.50.
This patch fixes it. Please, apply this patch.

	Cheers,
		Vita Samel

diff -X dontdiff -urN clean-2.5.50/drivers/ide/ide-floppy.c linux-2.5.50/drivers/ide/ide-floppy.c
--- clean-2.5.50/drivers/ide/ide-floppy.c	Thu Nov 28 08:30:32 2002
+++ linux-2.5.50/drivers/ide/ide-floppy.c	Wed Dec  4 16:36:34 2002
@@ -115,10 +115,10 @@
 /* #define IDEFLOPPY_DEBUG(fmt, args...) printk(KERN_INFO fmt, ## args) */
 #define IDEFLOPPY_DEBUG( fmt, args... )
 
-#ifndef IDEFLOPPY_DEBUG_LOG
-#define debug_log(fmt, args... ) do {} while(0)
-#else
+#if IDEFLOPPY_DEBUG_LOG
 #define debug_log printk
+#else
+#define debug_log(fmt, args... ) do {} while(0)
 #endif
 
 
