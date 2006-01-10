Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWAJU5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWAJU5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWAJU5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:57:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63497 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932628AbWAJU5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:57:05 -0500
Date: Tue, 10 Jan 2006 21:57:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: schwidefsky@de.ibm.com, linux390@de.ibm.com
Cc: linux-390@vm.marist.edu, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/s390/Makefile: remove -finline-limit=10000
Message-ID: <20060110205704.GD3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-finline-limit might have been required for older compilers, but 
nowadays it does no longer make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-full/arch/s390/Makefile.old	2006-01-08 16:25:53.000000000 +0100
+++ linux-2.6.15-mm2-full/arch/s390/Makefile	2006-01-08 16:25:59.000000000 +0100
@@ -67,7 +67,6 @@
 endif
 
 CFLAGS		+= -mbackchain -msoft-float $(cflags-y)
-CFLAGS		+= $(call cc-option,-finline-limit=10000)
 CFLAGS 		+= -pipe -fno-strength-reduce -Wno-sign-compare 
 AFLAGS		+= $(aflags-y)
 

