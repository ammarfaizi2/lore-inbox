Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVHQWTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVHQWTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 18:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVHQWTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 18:19:39 -0400
Received: from rrcs-24-123-59-149.central.biz.rr.com ([24.123.59.149]:63668
	"EHLO galon.ev-en.org") by vger.kernel.org with ESMTP
	id S1751281AbVHQWTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 18:19:39 -0400
Message-ID: <4303B7F4.4060407@ev-en.org>
Date: Wed, 17 Aug 2005 23:19:32 +0100
From: Baruch Even <baruch@ev-en.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>, kernel-janitors@osdl.org,
       Corey Minyard <minyard@mvista.com>
Subject: [PATCH] proc_ipmi_root depends on CONFIG_PROC_FS
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------040000080707000904000306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040000080707000904000306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------040000080707000904000306
Content-Type: text/x-patch;
 name="ipmi_proc_fs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_proc_fs.patch"

proc_ipmi_root is only defined for CONFIG_PROC_FS, #ifdef it for export as well.

Signed-Off-By: Baruch Even <baruch@ev-en.org>

--
 drivers/char/ipmi/ipmi_msghandler.c |    2 ++
 1 files changed, 2 insertions(+)

Index: k/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- k.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ k/drivers/char/ipmi/ipmi_msghandler.c
@@ -3194,5 +3194,7 @@ EXPORT_SYMBOL(ipmi_get_my_address);
 EXPORT_SYMBOL(ipmi_set_my_LUN);
 EXPORT_SYMBOL(ipmi_get_my_LUN);
 EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
+#ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(proc_ipmi_root);
+#endif
 EXPORT_SYMBOL(ipmi_user_set_run_to_completion);

--------------040000080707000904000306--
