Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbTIKEVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 00:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbTIKEVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 00:21:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:20960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266034AbTIKEVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 00:21:15 -0400
Message-ID: <3F5FF829.6060706@osdl.org>
Date: Wed, 10 Sep 2003 21:20:57 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <linus@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ps2esdi broken
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has problems all over the place and needs
to be be disabled (or deleted)

In file included from include/linux/mca.h:140,
                 from drivers/block/ps2esdi.c:42:
include/linux/mca-legacy.h:10:2: warning: #warning "MCA legacy - please 
move your driver to the new sysfs api"
drivers/block/ps2esdi.c:186: error: redefinition of `init_module'
drivers/block/ps2esdi.c:172: error: `init_module' previously defined here
drivers/block/ps2esdi.c: In function `init_module':
drivers/block/ps2esdi.c:190: warning: initialization from incompatible 
pointer type
drivers/block/ps2esdi.c:193: error: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:193: error: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:194: error: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:197: error: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:198: error: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:200: error: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c: In function `cleanup_module':
drivers/block/ps2esdi.c:216: error: `i' undeclared (first use in this 
function)
drivers/block/ps2esdi.c:216: error: (Each undeclared identifier is 
reported only once
drivers/block/ps2esdi.c:216: error: for each function it appears in.)
make[2]: *** [drivers/block/ps2esdi.o] Error 1

diff -Nru a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig    Wed Sep 10 21:15:51 2003
+++ b/drivers/block/Kconfig    Wed Sep 10 21:15:51 2003
@@ -44,7 +44,7 @@
 
 config BLK_DEV_PS2
     tristate "PS/2 ESDI hard disk support"
-    depends on MCA
+    depends on MCA && BROKEN
     help
       Say Y here if you have a PS/2 machine with a MCA bus and an ESDI
       hard disk.


