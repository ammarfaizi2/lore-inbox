Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUHEXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUHEXbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267942AbUHEXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:31:32 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:61427 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S267940AbUHEXbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:31:11 -0400
Message-ID: <4112C33A.40904@am.sony.com>
Date: Thu, 05 Aug 2004 16:31:06 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mporter@mvista.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix ebony uart clock
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebony-uart-clock-04.08.05.patch:

This patch corrects the Ebony board's uart clock value to the rate
of the external Epson SG-615P clock source.  Now good to 115Kbps.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF
---

  ebony.h |    3 ++-
  1 files changed, 2 insertions(+), 1 deletion(-)

  diff -X dontdiff -ruN 
linux-2.6.8-rc3.orig/arch/ppc/platforms/4xx/ebony.h 
branch_KGDB/arch/ppc/platforms/4xx/ebony.h
--- linux-2.6.8-rc3.orig/arch/ppc/platforms/4xx/ebony.h	2004-07-17 
21:59:03.000000000 -0700
+++ branch_KGDB/arch/ppc/platforms/4xx/ebony.h	2004-08-05 
15:58:40.000000000 -0700
@@ -64,7 +64,8 @@
  #define UART0_IO_BASE	(u8 *) 0xE0000200
  #define UART1_IO_BASE	(u8 *) 0xE0000300

-#define BASE_BAUD	33000000/3/16
+/* external Epson SG-615P */
+#define BASE_BAUD	691200

  #define STD_UART_OP(num)					\
  	{ 0, BASE_BAUD, 0, UART##num##_INT,			\


