Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWCXSNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWCXSNb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWCXSNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:13:31 -0500
Received: from [198.99.130.12] ([198.99.130.12]:38038 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751202AbWCXSNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:30 -0500
Message-Id: <200603241814.k2OIEY8R005505@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/16] UML - Fix declaration of exit()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:14:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a conflict between a header and what gcc "knows" the declaration'
to be.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/include/kern.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/kern.h	2006-02-21 16:02:19.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/kern.h	2006-02-21 16:15:14.000000000 -0500
@@ -29,7 +29,7 @@ extern int getuid(void);
 extern int getgid(void);
 extern int pause(void);
 extern int write(int, const void *, int);
-extern int exit(int);
+extern void exit(int);
 extern int close(int);
 extern int read(unsigned int, char *, int);
 extern int pipe(int *);

