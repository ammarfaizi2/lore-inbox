Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWGHD6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWGHD6F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 23:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWGHD6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 23:58:05 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:50352 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932506AbWGHD6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 23:58:04 -0400
Date: Fri, 7 Jul 2006 23:53:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] CONFIG_CIFS_DEBUG2 depends on CIFS
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Steven French <sfrench@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607072354_MC3-1-C46B-38F6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Config option for CIFS_DEBUG2 shows up even without CIFS.
Make it depend on that.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc1-nb.orig/fs/Kconfig
+++ 2.6.18-rc1-nb/fs/Kconfig
@@ -1801,6 +1801,7 @@ config CIFS_POSIX
 
 config CIFS_DEBUG2
 	bool "Enable additional CIFS debugging routines"
+	depends on CIFS
 	help
 	   Enabling this option adds a few more debugging routines
 	   to the cifs code which slightly increases the size of
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
