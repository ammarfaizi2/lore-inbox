Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUHEFRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUHEFRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUHEFRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:17:35 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:39172 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S267410AbUHEFRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:17:33 -0400
Message-ID: <4111C2B0.809@snapgear.com>
Date: Thu, 05 Aug 2004 15:16:32 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: section names for m68k assembler routines, .text.init ->
 .init.text
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

In linux-2.6.7...

The section specifiers in the include/asm-m68k/init.h are
not the same as those used in the linker scripts. It currently
has .text.init while the linker scripts use .init.text. Same
goes for .data.init and .init.data. Looks like the init.h
is out of date...

Signed-of-by: Greg Ungerer <gerg@snapgear.com>

Regards
Greg



--- linux-2.6.x/include/asm-m68k/init.h.org     2002-02-28 
09:01:48.000000000 +1000
+++ linux-2.6.x/include/asm-m68k/init.h 2004-08-05 14:52:23.000000000 +1000
@@ -1,11 +1,11 @@
  #ifndef _M68K_INIT_H
  #define _M68K_INIT_H

-#define __init __attribute__ ((__section__ (".text.init")))
-#define __initdata __attribute__ ((__section__ (".data.init")))
+#define __init __attribute__ ((__section__ (".init.text")))
+#define __initdata __attribute__ ((__section__ (".init.data")))
  /* For assembly routines */
-#define __INIT         .section        ".text.init",#alloc,#execinstr
+#define __INIT         .section        ".init.text",#alloc,#execinstr
  #define __FINIT                .previous
-#define __INITDATA     .section        ".data.init",#alloc,#write
+#define __INITDATA     .section        ".init.data",#alloc,#write

  #endif

------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
