Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWGTJ6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWGTJ6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 05:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWGTJ6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 05:58:35 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:1255 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP
	id S1030187AbWGTJ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 05:58:34 -0400
Message-Id: <200607201000.k6KA0qY10526@saur.se.axis.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow make kernelrelease & make kernelversion without .config
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Jul 2006 12:00:52 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The make targets kernelrelease and kernelversion do not need the .config 
file to exist for them to be useable.  Add them to no-dot-config-targets.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Index: Makefile
===================================================================
RCS file: /usr/local/cvs/linux/os/linux-2.6/Makefile,v
retrieving revision 1.1.1.31
diff -p -u -r1.1.1.31 Makefile
--- Makefile	25 Jun 2006 12:57:55 -0000	1.1.1.31
+++ Makefile	20 Jul 2006 09:42:20 -0000
@@ -362,7 +362,8 @@ endif
 # of make so .config is not included in this case either (for *config).
 
 no-dot-config-targets := clean mrproper distclean \
-			 cscope TAGS tags help %docs check%
+			 cscope TAGS tags help %docs check% \
+			 kernelrelease kernelversion
 
 config-targets := 0
 mixed-targets  := 0


------------------------------------------------------------
Peter Kjellerstedt       E-Mail: Peter.Kjellerstedt@axis.com
Axis Communications AB   Phone:  +46 46 272 18 69
Emdalav. 14              Fax:    +46 46 13 61 30
SE-223 69  LUND          URL:    http://www.axis.com/


