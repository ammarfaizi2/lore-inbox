Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSKOKax>; Fri, 15 Nov 2002 05:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266106AbSKOKaw>; Fri, 15 Nov 2002 05:30:52 -0500
Received: from babsi.intermeta.de ([212.34.181.3]:56848 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S266101AbSKOKav>; Fri, 15 Nov 2002 05:30:51 -0500
Subject: [2.4.20-rc1-ac3] Compile Fix for smplock.h
From: Henning Schmiedehausen <hps@intermeta.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: multipart/mixed; boundary="=-X6V4Q79qgwoKGS6OG9/h"
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Nov 2002 11:37:43 +0100
Message-Id: <1037356664.27932.32.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X6V4Q79qgwoKGS6OG9/h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I needed the attached patch to compile 2.4.20-rc1-ac3 on Uniprocessor.
Alan, you seem to have too many multiprocessor boxes these days... :-)

It might be possible that the same patch is needed in 

./arch/ppc64/kernel/ppc_ksyms.c
./arch/mips/sibyte/sb1250/bcm1250_tbprof.c
./arch/ppc/kernel/ppc_ksyms.c
./arch/ia64/kernel/ia64_ksyms.c
./arch/parisc/kernel/parisc_ksyms.c

But as I own none of these architectures, I can't be too sure.

	Regards
		Henning



-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

--=-X6V4Q79qgwoKGS6OG9/h
Content-Disposition: attachment; filename=linux-2.4.20-rc1-ac3-compile.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=linux-2.4.20-rc1-ac3-compile.patch; charset=ISO-8859-1

--- linux-2.4.20-rc1-ac3/mm/rmap.c~	Fri Nov 15 10:49:55 2002
+++ linux-2.4.20-rc1-ac3/mm/rmap.c	Fri Nov 15 11:29:16 2002
@@ -25,10 +25,10 @@
 #include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
=20
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
-#include <asm/smplock.h>
=20
 /* #define DEBUG_RMAP */
=20

--=-X6V4Q79qgwoKGS6OG9/h--

