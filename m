Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318804AbSG0TF6>; Sat, 27 Jul 2002 15:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318805AbSG0TFz>; Sat, 27 Jul 2002 15:05:55 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:51592 "EHLO gagarin")
	by vger.kernel.org with ESMTP id <S318804AbSG0TFx>;
	Sat, 27 Jul 2002 15:05:53 -0400
Date: Sat, 27 Jul 2002 21:09:10 +0200
To: linux-kernel@vger.kernel.org
Cc: kaos@ocs.com.au
Subject: [PATCH] remove trailing space in calltrace?
Message-ID: <20020727190910.GA1786@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an extra space at the end of the "Call Trace"-lines on i386 (dont
know about other archs) that causes my terminal to wrap the line and giving
me blank lines beetween the ones containing addresses.

Is that extra space there for a reson?

This patch removes it, saving me precious lines on the screen.

//anders/g

===================================================================


ChangeSet@1.479, 2002-07-27 20:55:47+02:00, andersg@heineken.0x63.nu
  Remove trailing space on Call Trace-lines in OOPSes on i386.


 traps.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Sat Jul 27 21:00:35 2002
+++ b/arch/i386/kernel/traps.c	Sat Jul 27 21:00:35 2002
@@ -143,14 +143,14 @@
 	if (!stack)
 		stack = (unsigned long*)&stack;
 
-	printk("Call Trace: ");
+	printk("Call Trace:");
 	i = 1;
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		if (kernel_text_address(addr)) {
-			if (i && ((i % 6) == 0))
-				printk("\n   ");
-			printk("[<%08lx>] ", addr);
+			if ((i % 6) == 0)
+				printk("\n  ");
+			printk(" [<%08lx>]", addr);
 			i++;
 		}
 	}

===================================================================


This BitKeeper patch contains the following changesets:
1.479
## Wrapped with gzip_uu ##


begin 664 bkpatch555
M'XL(`-/M0CT``\U476O;,!1]MG[%):70T-F69'W%6TJVM&QC@X1T?=KVH-AJ
M;&++P7;3#OSCIZ1=6@(A[.-AMD'V/><>WZM[T`G<-*:./6U34S<+=`(?JJ:-
MO<SDUBR-#?"#B`)[YX!953D@S*K2A$_T<&EJ:XIPO@SG177OTX`CQYSJ-LE@
M[1BQ1X)H%VE_K$SLS:[>WWQ^.T-H.(1QINW"7)L6AD/45O5:%VDSTFU65#9H
M:VV;TK0Z2*JRVU$[BC%U-R<RPEQT1&`FNX2DA&A&3(HI4X*AIQ)'^YWL"TDJ
M"<>"B0YCA26Z!!(P.0!,0RQ#*H'BF/.8R7-,8XSAD"Z<$_`Q>@?_MHTQ2F!F
MRFIMP`GE16X7T*QT8J"R,-9%`5]J]^4[P#206YA,IM?NS:%YI$2`/@&1`J/I
M\UXC_S<OA+#&Z.)(9[I.LG#SSU^N</"J"9(7C3),2<<B*GEWBXD9:$58&AFJ
MA#BXKT=T-^-3G$>JX]0I;UUU*..XR?ZN!U2ZZ50C4[0FR(X7+BAA+"*N<$7I
MUG=4[=LN4D=MQ\!G_Z/M'N<Q`;^^WS[.1].#H_D#3UX2)H"@CX^+MZISVR[/
M>L_%Q;W^:\?B!"+'XI%;/,_+;^'L+(=3$'WG!\#]37"7_<T";-)>A.#KFU.L
DBH>+[[U7H-.T=O#N2$LRDRR;NW(H!UP(-:?H)VYYGH-2!0``
`
end
