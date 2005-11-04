Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVKDWQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVKDWQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVKDWQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:16:45 -0500
Received: from verein.lst.de ([213.95.11.210]:11430 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751047AbVKDWQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:16:45 -0500
Date: Fri, 4 Nov 2005 23:16:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] remove TIOCGSERIAL/TIOCSSERIAL compat_ioctl entries for 390
Message-ID: <20051104221639.GA9384@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

these ioctls are defintily not compat clean, but we already have a
proper handler in common code, over-riding it in architecture code
is counter-productive.


Index: linux-2.6/arch/s390/kernel/compat_ioctl.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_ioctl.c	2005-11-02 11:19:07.000000000 +0100
+++ linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-11-02 11:19:08.000000000 +0100
@@ -45,10 +45,6 @@
 
 /* s390 only ioctls */
 COMPATIBLE_IOCTL(TAPE390_DISPLAY)
-
-/* s390 doesn't need handlers here */
-COMPATIBLE_IOCTL(TIOCGSERIAL)
-COMPATIBLE_IOCTL(TIOCSSERIAL)
 };
 
 int ioctl_table_size = ARRAY_SIZE(ioctl_start);
