Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbUKDRh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbUKDRh2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbUKDRh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:37:27 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:21124 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262306AbUKDRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:37:13 -0500
Date: Thu, 4 Nov 2004 10:37:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2.6.10-rc1] Add __KERNEL__ to <linux/crc-ccitt.h>
Message-ID: <20041104173712.GA13456@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following adds a __KERNEL__ check to <linux/crc-ccitt.h>.
The problem is that the ppp package includes <linux/ppp_defs.h> via
<net/ppp_defs.h>, which in turn gets <linux/crc-ccitt.h>.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.2/include/linux/crc-ccitt.h	2004-07-11 01:54:19 -07:00
+++ edited/include/linux/crc-ccitt.h	2004-11-04 10:34:24 -07:00
@@ -1,5 +1,6 @@
 #ifndef _LINUX_CRC_CCITT_H
 #define _LINUX_CRC_CCITT_H
+#ifdef __KERNEL__
 
 #include <linux/types.h>
 
@@ -12,4 +13,5 @@
 	return (crc >> 8) ^ crc_ccitt_table[(crc ^ c) & 0xff];
 }
 
+#endif /* __KERNEL__ */
 #endif /* _LINUX_CRC_CCITT_H */

-- 
Tom Rini
http://gate.crashing.org/~trini/
