Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUHNOYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUHNOYm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUHNOYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:24:42 -0400
Received: from verein.lst.de ([213.95.11.210]:16555 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262905AbUHNOYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:24:41 -0400
Date: Sat, 14 Aug 2004 16:24:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix compile warning in init/main.c
Message-ID: <20040814142436.GA25899@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.150/init/main.c	2004-08-14 07:12:08 +02:00
+++ edited/init/main.c	2004-08-14 16:15:53 +02:00
@@ -96,7 +96,7 @@
 #ifdef	CONFIG_ACPI
 extern void acpi_early_init(void);
 #else
-static inline acpi_early_init() { }
+static inline void acpi_early_init(void) { }
 #endif
 
 #ifdef CONFIG_TC
