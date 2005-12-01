Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVLAAK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVLAAK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVK3X5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:57:31 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:37282
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751287AbVK3X5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:18 -0500
Subject: [patch 05/43] Export deinlined mktime
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:02:54 +0100
Message-Id: <1133395374.32542.448.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (deinline-mktime-export.patch)
From: Andrew Morton <akpm@osdl.org>

This is now uninlined, but some modules use it.

Make it a non-GPL export, since the inlined mktime() was also available that
way.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/time.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.15-rc2-rework/kernel/time.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/time.c
+++ linux-2.6.15-rc2-rework/kernel/time.c
@@ -597,6 +597,8 @@ mktime(const unsigned int year0, const u
 	)*60 + sec; /* finally seconds */
 }
 
+EXPORT_SYMBOL(mktime);
+
 /**
  * set_normalized_timespec - set timespec sec and nsec parts and normalize
  *

--

