Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbSKQT11>; Sun, 17 Nov 2002 14:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbSKQT11>; Sun, 17 Nov 2002 14:27:27 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:37903 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267559AbSKQT1Z>; Sun, 17 Nov 2002 14:27:25 -0500
Date: Sun, 17 Nov 2002 17:34:12 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] mcd/mcdx: fixup after header files cleanups: add include <linux/interrupt.h>
Message-ID: <20021117193412.GQ28227@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there are only this outstanding changeset.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.857, 2002-11-17 17:28:22-02:00, acme@conectiva.com.br
  o mcd/mcdx: fixup after header files cleanups: add include <linux/interrupt.h>
  
  request_irq/free_irq are now in linux/interrupt.h


 mcd.c  |    3 ++-
 mcdx.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/cdrom/mcd.c b/drivers/cdrom/mcd.c
--- a/drivers/cdrom/mcd.c	Sun Nov 17 17:28:51 2002
+++ b/drivers/cdrom/mcd.c	Sun Nov 17 17:28:51 2002
@@ -82,8 +82,8 @@
 #include <linux/module.h>
 
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/timer.h>
 #include <linux/fs.h>
@@ -99,6 +99,7 @@
 /* #define REALLY_SLOW_IO  */
 #include <asm/system.h>
 #include <asm/io.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 #include <linux/blk.h>
 
diff -Nru a/drivers/cdrom/mcdx.c b/drivers/cdrom/mcdx.c
--- a/drivers/cdrom/mcdx.c	Sun Nov 17 17:28:51 2002
+++ b/drivers/cdrom/mcdx.c	Sun Nov 17 17:28:51 2002
@@ -60,7 +60,7 @@
 #include <linux/module.h>
 
 #include <linux/errno.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/cdrom.h>
@@ -69,6 +69,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <asm/io.h>
+#include <asm/current.h>
 #include <asm/uaccess.h>
 
 #include <linux/major.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.857
## Wrapped with gzip_uu ##


begin 664 bkpatch23551
M'XL(`//MUST``^U674_;,!1]KG^%)1ZG)KZ.\ZD5=<"T(28-,?$T39.Q;TA$
M$Q<G*47*CY\;/K9!UT*UIVF)\Z'<Z^-CWW.L[-'S!FTVDJI"LD<_FJ;-1LK4
MJ-IR(3UE*N_"NL"9,2[@%Z9"_^#$+VLUZS0V8^Z%Q(5/9:L*ND#;9"/P@L<O
M[>T<L]'9^P_GG]Z=$3*9T,-"UI?X!5LZF9#6V(6<Z68JVV)F:J^ULFXJ;(>!
M^\?4GC/&W1E"'+`PZB%B(NX5:``I`#7C(HD$6<UA^I3[$Q0`B"'E#$3/(L$%
M.:+@)6%,&?<!?(@IQ!E/,L['C&>,T;6@]`VG8T8.Z-^=P"%1U-!*:=]=RXSF
MY;*;4YFW:&F!4KM'7LZPH6J&LN[F34:EUO2^&/3MK*R[I:N-R[?=O/6*?0?H
MFL7K#IOV>VFO_=PBKEZHM$AK<^-ZTV?]R`D-`\')Z<]RD?$K#T*89&1_RQ)I
M6ZY4XRMM335,VU._K)9@`#V#0(@^2EG*,00>HPPA7%^8/^/=%SZ!I`\#X.'K
MF:TAQB(&/<\QS$6D<Q9H%?*+ES)[3HS'<10,+EF3O-TO.S,F\FI>375YB68%
M]/5AF&\;2#M(1UFD/0^92`<;\?2IBR#9ZB+XIUUT5]'/=&QOAN9L<;JNN#NX
MZS@1%,C>)MI'2>12CH'!;YFRJ7S568OUD+56;\N=!/=2\Y)%:<VT<J#>O.D\
MU-TFS3U:F#G)14$4I+W3',"=Z)+_HGNV=:_VMVVB6^ZDNJ,H6$EJN&_4WG&\
;670/?PBJ0'75=-4DE1J2BX"3'_I_JWZ3"```
`
end
