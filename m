Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVBBNFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVBBNFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVBBNFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:05:15 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50173 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262432AbVBBNFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:05:02 -0500
Subject: [PATCH] Minor Kexec bug fix (2.6.11-rc2-mm2)
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-26Rfb7gATS1Xf5ynPvNi"
Organization: 
Message-Id: <1107352593.11609.146.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Feb 2005 19:26:34 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-26Rfb7gATS1Xf5ynPvNi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch has been generated against 2.6.11-rc2-mm2. This fixes a very
minor bug in kexec.

Thanks
Vivek


--=-26Rfb7gATS1Xf5ynPvNi
Content-Disposition: attachment; filename=kexec_minor_bug_fix.patch
Content-Type: text/plain; name=kexec_minor_bug_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch fixes a minor bug in kexec. Changing the data type of flags makes 
sure proper control flow of code during crash event.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.11-rc2-mm2-kdump-vivek/include/linux/kexec.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/kexec.h~kexec_minor_bug_fix include/linux/kexec.h
--- linux-2.6.11-rc2-mm2-kdump/include/linux/kexec.h~kexec_minor_bug_fix	2005-02-02 16:28:18.000000000 +0530
+++ linux-2.6.11-rc2-mm2-kdump-vivek/include/linux/kexec.h	2005-02-02 16:29:01.000000000 +0530
@@ -79,7 +79,7 @@ struct kimage {
 	unsigned long control_page;
 
 	/* Flags to indicate special processing */
-	int type : 1;
+	unsigned int type : 1;
 #define KEXEC_TYPE_DEFAULT 0
 #define KEXEC_TYPE_CRASH   1
 };
_

--=-26Rfb7gATS1Xf5ynPvNi--

