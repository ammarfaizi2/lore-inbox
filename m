Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVHCW7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVHCW7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 18:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVHCW5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 18:57:15 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:41127 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261624AbVHCW4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 18:56:54 -0400
Message-ID: <42F14BAF.6020608@acm.org>
Date: Wed, 03 Aug 2005 17:56:47 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] IPMI driver update part 4, allow userland to include ipmi.h
Content-Type: multipart/mixed;
 boundary="------------070709010700010102010304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070709010700010102010304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070709010700010102010304
Content-Type: unknown/unknown;
 name="ipmi_compiler_h_include.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_compiler_h_include.patch"

The IPMI driver include file needs to include compiler.h so it
has definitions for __user and such.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.13-rc5/include/linux/ipmi.h
===================================================================
--- linux-2.6.13-rc5.orig/include/linux/ipmi.h
+++ linux-2.6.13-rc5/include/linux/ipmi.h
@@ -35,6 +35,7 @@
 #define __LINUX_IPMI_H
 
 #include <linux/ipmi_msgdefs.h>
+#include <linux/compiler.h>
 
 /*
  * This file describes an interface to an IPMI driver.  You have to

--------------070709010700010102010304--
