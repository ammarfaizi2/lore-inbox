Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbTABV6K>; Thu, 2 Jan 2003 16:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbTABV5Y>; Thu, 2 Jan 2003 16:57:24 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:8901 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266652AbTABVaF>; Thu, 2 Jan 2003 16:30:05 -0500
From: Tomas Szepe <kala@pinerecords.com>
Date: Thu, 02 Jan 2003 22:38:29 +0100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [unify netdev config 18/22] net.0
Message-ID: <3E14B155.mailLYF11W8JM@louise.pinerecords.com>
User-Agent: nail 10.3 11/29/02
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/drivers/atm/Kconfig b/drivers/atm/Kconfig
--- a/drivers/atm/Kconfig	2002-10-31 02:33:41.000000000 +0100
+++ b/drivers/atm/Kconfig	2003-01-02 21:52:42.000000000 +0100
@@ -3,7 +3,8 @@
 #
 
 menu "ATM drivers"
-	depends on NETDEVICES && ATM
+# FIXME: should also include M68KNOMMU and CRIS!
+	depends on NETDEVICES && ATM && (SUPERH || PPC || X86 || MIPS || V850 || ALPHA || PPC64 || SPARC32 || SPARC64 || SGI_IP22 || SGI_IP27 || PARISC)
 
 config ATM_TCP
 	tristate "ATM over TCP"
