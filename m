Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUHDObt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUHDObt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbUHDObt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:31:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:45810 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264299AbUHDObr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:31:47 -0400
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add PCI-dependency for donauboe irda driver
Date: Wed, 4 Aug 2004 16:31:44 +0200
User-Agent: KMail/1.6.2
Cc: irda-users@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408041631.44396.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The donauboe driver needs a PCI bus to work. This patch adds the dependency to 
Kconfig.

cheers Christian

Signed-off-by: Christian Bornträger <linux-kernel@borntraeger.net>

diff -u -r1.12 Kconfig
--- a/drivers/net/irda/Kconfig	11 Mar 2004 09:59:30 -0000	1.12
+++ b/drivers/net/irda/Kconfig	4 Aug 2004 14:13:10 -0000
@@ -333,7 +333,7 @@
 
 config TOSHIBA_FIR
 	tristate "Toshiba Type-O IR Port"
-	depends on IRDA
+	depends on IRDA && PCI
 	help
 	  Say Y here if you want to build support for the Toshiba Type-O IR
 	  and Donau oboe chipsets. These chipsets are used by the Toshiba
