Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSCTT50>; Wed, 20 Mar 2002 14:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312096AbSCTT5Q>; Wed, 20 Mar 2002 14:57:16 -0500
Received: from maild.telia.com ([194.22.190.101]:5370 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S293194AbSCTT5L>;
	Wed, 20 Mar 2002 14:57:11 -0500
To: linux-kernel@vger.kernel.org
Cc: linux_udf@hpesjro.fc.hp.com, Ben Fennema <bfennema@ix.netcom.com>
Subject: [patch] UDF write support problem in 2.5.7
From: Peter Osterlund <petero2@telia.com>
Date: 20 Mar 2002 20:56:59 +0100
Message-ID: <m2663r108k.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I can't get UDF write support to work in kernel 2.5.7 or 2.5.7-pre2.
The problem is that linux/config.h is not included, so CONFIG_UDF_RW
is undefined and the driver is compiled without write support. This
patch fixes my problem:

--- linux/include/linux/udf_fs.h.old	Wed Mar 20 20:49:55 2002
+++ linux/include/linux/udf_fs.h	Wed Mar 20 20:25:54 2002
@@ -34,6 +34,8 @@
 #ifndef _UDF_FS_H
 #define _UDF_FS_H 1
 
+#include <linux/config.h>
+
 #define UDF_PREALLOCATE
 #define UDF_DEFAULT_PREALLOC_BLOCKS	8
 

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
