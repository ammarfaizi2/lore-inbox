Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTDJSdM (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 14:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbTDJSdL (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 14:33:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8832 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id S264152AbTDJSdL (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 14:33:11 -0400
Date: Thu, 10 Apr 2003 11:44:49 -0700
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au, mbligh@aracnet.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.67] Fix compiler errors in drivers/char/rio/rio_linux.c
Message-ID: <20030410184449.GA3607@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the compatmac.h include file was deleted the indirect include
of asm/uaccess.h was lost.  This patch adds a direct include of
asm/uaccess.h.

This fixes bugme.osdl.org bug number 566.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

===== drivers/char/rio/rio_linux.c 1.16 vs edited =====
--- 1.16/drivers/char/rio/rio_linux.c	Mon Mar 31 15:55:28 2003
+++ edited/drivers/char/rio/rio_linux.c	Thu Apr 10 11:25:23 2003
@@ -60,6 +60,7 @@
 #include <linux/init.h>
 
 #include <linux/generic_serial.h>
+#include <asm/uaccess.h>
 
 #if BITS_PER_LONG != 32
 #  error FIXME: this driver only works on 32-bit platforms
