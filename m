Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVKCSdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVKCSdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbVKCSdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:33:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11280 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030413AbVKCSdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:33:41 -0500
Date: Thu, 3 Nov 2005 19:33:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/message/fusion/mptbase.c: make code static
Message-ID: <20051103183330.GI23366@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following previously global and EXPORT_SYMBOL'ed 
code static:
- struct mpt_proc_root_dir
- int mpt_stm_index


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/message/fusion/mptbase.c |    6 ++----
 drivers/message/fusion/mptbase.h |    2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/message/fusion/mptbase.h.old	2005-11-03 18:19:05.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/message/fusion/mptbase.h	2005-11-03 18:19:56.000000000 +0100
@@ -995,10 +995,8 @@
  *  Public data decl's...
  */
 extern struct list_head	  ioc_list;
-extern struct proc_dir_entry	*mpt_proc_root_dir;
 
 extern int		  mpt_lan_index;	/* needed by mptlan.c */
-extern int		  mpt_stm_index;	/* needed by mptstm.c */
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 #endif		/* } __KERNEL__ */
--- linux-2.6.14-rc5-mm1-full/drivers/message/fusion/mptbase.c.old	2005-11-03 18:19:19.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/message/fusion/mptbase.c	2005-11-03 18:20:07.000000000 +0100
@@ -92,9 +92,9 @@
  *  Public data...
  */
 int mpt_lan_index = -1;
-int mpt_stm_index = -1;
+static int mpt_stm_index = -1;
 
-struct proc_dir_entry *mpt_proc_root_dir;
+static struct proc_dir_entry *mpt_proc_root_dir;
 
 #define WHOINIT_UNKNOWN		0xAA
 
@@ -6274,7 +6274,6 @@
 EXPORT_SYMBOL(mpt_suspend);
 #endif
 EXPORT_SYMBOL(ioc_list);
-EXPORT_SYMBOL(mpt_proc_root_dir);
 EXPORT_SYMBOL(mpt_register);
 EXPORT_SYMBOL(mpt_deregister);
 EXPORT_SYMBOL(mpt_event_register);
@@ -6292,7 +6291,6 @@
 EXPORT_SYMBOL(mpt_GetIocState);
 EXPORT_SYMBOL(mpt_print_ioc_summary);
 EXPORT_SYMBOL(mpt_lan_index);
-EXPORT_SYMBOL(mpt_stm_index);
 EXPORT_SYMBOL(mpt_HardResetHandler);
 EXPORT_SYMBOL(mpt_config);
 EXPORT_SYMBOL(mpt_toolbox);

