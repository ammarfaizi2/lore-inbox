Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUEUTQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUEUTQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 15:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUEUTQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 15:16:11 -0400
Received: from outmx006.isp.belgacom.be ([195.238.2.99]:4020 "EHLO
	outmx006.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265978AbUEUTQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 15:16:08 -0400
Subject: [PATCH 2.6.6-mm4] ring_info spinlock initialization
From: FabF <Fabian.Frederick@skynet.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-pdfLmtdsTfJC2xou1hxu"
Message-Id: <1085167134.7954.3.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 May 2004 21:18:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pdfLmtdsTfJC2xou1hxu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
	ring_info spinlock was not initialized in INIT_KIOCTX.

Regards,
FabF

--=-pdfLmtdsTfJC2xou1hxu
Content-Disposition: attachment; filename=inittask1.diff
Content-Type: text/x-patch; name=inittask1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/include/linux/init_task.h edited/include/linux/init_task.h
--- orig/include/linux/init_task.h	2004-05-10 04:32:00.000000000 +0200
+++ edited/include/linux/init_task.h	2004-05-21 14:26:56.000000000 +0200
@@ -29,6 +29,7 @@
 	.ctx_lock	= SPIN_LOCK_UNLOCKED,		\
 	.reqs_active	= 0U,				\
 	.max_reqs	= ~0U,				\
+	.ring_info.ring_lock = SPIN_LOCK_UNLOCKED	\
 }
 
 #define INIT_MM(name) \

--=-pdfLmtdsTfJC2xou1hxu--

