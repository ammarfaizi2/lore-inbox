Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVHTD7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVHTD7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbVHTD7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:59:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:7941 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030193AbVHTD67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:58:59 -0400
Date: Sat, 20 Aug 2005 05:58:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] adapt scripts/ver_linux to new util-linux version strings
Message-ID: <20050820035853.GM3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/scripts/ver_linux.old	2005-08-20 05:54:50.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/scripts/ver_linux	2005-08-20 05:55:36.000000000 +0200
@@ -25,9 +25,11 @@
 '/BFD/{print "binutils              ",$NF} \
 /^GNU/{print "binutils              ",$4}'
 
-fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
+fdformat --version | awk '{print "util-linux            ", $NF}' \
+| awk -F\) '{print $1}'
 
-mount --version | awk -F\- '{print "mount                 ", $NF}'
+mount --version | awk '{print "mount                 ", $NF}' | \
+awk -F\) '{print $1}'
 
 depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 

