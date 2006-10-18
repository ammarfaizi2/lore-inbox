Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWJRCjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWJRCjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 22:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWJRCjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 22:39:55 -0400
Received: from gw.goop.org ([64.81.55.164]:28369 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750898AbWJRCjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 22:39:54 -0400
Message-ID: <4535902E.1000608@goop.org>
Date: Tue, 17 Oct 2006 19:23:42 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix generic WARN_ON message
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A warning is a warning, not a BUG.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>

diff -r 6c118d4e4240 include/asm-generic/bug.h
--- a/include/asm-generic/bug.h	Tue Oct 17 12:43:22 2006 -0700
+++ b/include/asm-generic/bug.h	Tue Oct 17 18:56:59 2006 -0700
@@ -35,7 +35,7 @@ struct bug_entry {
 #define WARN_ON(condition) ({						\
 	typeof(condition) __ret_warn_on = (condition);			\
 	if (unlikely(__ret_warn_on)) {					\
-		printk("BUG: warning at %s:%d/%s()\n", __FILE__,	\
+		printk("WARNING at %s:%d %s()\n", __FILE__,	\
 			__LINE__, __FUNCTION__);			\
 		dump_stack();						\
 	}								\



