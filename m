Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752387AbWJ0TND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbWJ0TND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 15:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbWJ0TNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 15:13:01 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:52629 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752387AbWJ0TNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 15:13:00 -0400
Date: Fri, 27 Oct 2006 12:08:26 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, sam@ravnborg.org
Subject: [PATCH 1/2] kconfig: PRINTK_TIME depends on PRINTK
Message-Id: <20061027120826.e842cbd9.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Make PRINTK_TIME depend on PRINTK.
Only display/offer it if PRINTK is enabled.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 lib/Kconfig.debug |    1 +
 1 files changed, 1 insertion(+)

--- linux-2619-rc3-pv.orig/lib/Kconfig.debug
+++ linux-2619-rc3-pv/lib/Kconfig.debug
@@ -1,6 +1,7 @@
 
 config PRINTK_TIME
 	bool "Show timing information on printks"
+	depends on PRINTK
 	help
 	  Selecting this option causes timing information to be
 	  included in printk output.  This allows you to measure


---
