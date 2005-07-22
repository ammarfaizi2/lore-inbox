Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVGVVSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVGVVSI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVGVVR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:17:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22026 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261402AbVGVVRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:17:37 -0400
Date: Fri, 22 Jul 2005 23:17:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Gerrit Huizenga <gh@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Vivek Kashyap <vivk@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/ckrm/rbce/rbce_core.c: fix -Wundef warning
Message-ID: <20050722211732.GQ3160@stusta.de>
References: <20050715013653.36006990.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc2-mm2:
>...
> +ckrm-rule-based-classification-engine-full-ce.patch
>...
>  Class-based kernel resource management
>...

This patch fixes the following warning with -Wundef:

<--  snip  -->

...
  CC      kernel/ckrm/rbce/rbce_core.o
kernel/ckrm/rbce/rbce_core.c:323:5: warning: "__NOT_YET__" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/kernel/ckrm/rbce/rbce_core.c.old	2005-07-22 18:04:28.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/kernel/ckrm/rbce/rbce_core.c	2005-07-22 18:04:36.000000000 +0200
@@ -320,7 +320,7 @@
 
 			case RBCE_RULE_CMD_PATH:
 			case RBCE_RULE_CMD:
-#if __NOT_YET__
+#ifdef __NOT_YET__
 				if (!*filename) {	/* get this once */
 					if (((*filename =
 					      kmalloc(NAME_MAX,

