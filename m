Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266884AbRGTJ5w>; Fri, 20 Jul 2001 05:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbRGTJ5m>; Fri, 20 Jul 2001 05:57:42 -0400
Received: from t2.redhat.com ([199.183.24.243]:25336 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266884AbRGTJ5Z>; Fri, 20 Jul 2001 05:57:25 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <01072012460800.09910@kiwiunix.ihug.co.nz> 
In-Reply-To: <01072012460800.09910@kiwiunix.ihug.co.nz> 
To: Matthew Gardiner <kiwiunix@ihug.co.nz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Re: MTD compiling error 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Jul 2001 10:57:18 +0100
Message-ID: <27335.995623038@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


kiwiunix@ihug.co.nz said:
> /usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: `do_softirq' undeclared  (first use in this function)

Linus, please apply:

Index: include/linux/mtd/cfi.h
===================================================================
RCS file: /inst/cvs/linux/include/linux/mtd/cfi.h,v
retrieving revision 1.1.1.1.2.4
diff -u -r1.1.1.1.2.4 cfi.h
--- include/linux/mtd/cfi.h	2001/06/13 06:41:40	1.1.1.1.2.4
+++ include/linux/mtd/cfi.h	2001/07/20 09:56:41
@@ -1,7 +1,7 @@
 
 /* Common Flash Interface structures 
  * See http://support.intel.com/design/flash/technote/index.htm
- * $Id: cfi.h,v 1.21 2001/06/03 01:32:57 nico Exp $
+ * $Id: cfi.h,v 1.22 2001/07/06 09:29:07 dwmw2 Exp $
  */
 
 #ifndef __MTD_CFI_H__
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/types.h>
+#include <linux/interrupt.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/cfi_endian.h>
 


--
dwmw2


