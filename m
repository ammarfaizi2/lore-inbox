Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSK1Ovn>; Thu, 28 Nov 2002 09:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265581AbSK1Ovm>; Thu, 28 Nov 2002 09:51:42 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:4261 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265567AbSK1Ovm>;
	Thu, 28 Nov 2002 09:51:42 -0500
Date: Thu, 28 Nov 2002 17:13:03 -0500
From: Christoph Hellwig <hch@sgi.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cure compiler warning in acct.h
Message-ID: <20021128171303.A6592@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't ask me why, but since 2.5.50 we need this forward-declaration

--- 1.2/include/linux/acct.h	Tue Feb  5 16:23:04 2002
+++ edited/include/linux/acct.h	Thu Nov 28 14:23:25 2002
@@ -75,6 +75,8 @@
 
 #include <linux/config.h>
 
+struct super_block;
+
 #ifdef CONFIG_BSD_PROCESS_ACCT
 extern void acct_auto_close(struct super_block *sb);
 extern int acct_process(long exitcode);
