Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbTEaLqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 07:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTEaLqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 07:46:13 -0400
Received: from ns.suse.de ([213.95.15.193]:53255 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264293AbTEaLqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 07:46:12 -0400
Date: Sat, 31 May 2003 13:58:07 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Copy nanosecond stat values for i386
Message-ID: <20030531115807.GA11153@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A brown paper bag bug, noticed by Ralf Baechtle. 

i386 needs to define STAT_HAVE_NSEC too, otherwise it won't copy
the nanosecond values to user space.

-Andi


Index: linux/include/asm-i386/stat.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/stat.h,v
retrieving revision 1.12
diff -u -u -r1.12 stat.h
--- linux/include/asm-i386/stat.h	30 May 2003 20:11:00 -0000	1.12
+++ linux/include/asm-i386/stat.h	31 May 2003 10:24:23 -0000
@@ -73,4 +73,6 @@
 	unsigned long long	st_ino;
 };
 
+#define STAT_HAVE_NSEC 1
+
 #endif
