Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSKWTSW>; Sat, 23 Nov 2002 14:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSKWTSW>; Sat, 23 Nov 2002 14:18:22 -0500
Received: from 3-238.ctame701-2.telepar.net.br ([200.181.171.238]:34052 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267048AbSKWTSV>; Sat, 23 Nov 2002 14:18:21 -0500
Date: Sat, 23 Nov 2002 17:09:12 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/ipv4/raw.c: add missing include <linux/mroute.h>
Message-ID: <20021123190911.GI25766@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

	Now there is just this changeset outstanding.

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.858, 2002-11-23 17:01:07-02:00, acme@conectiva.com.br
  o net/ipv4/raw.c: add missing include <linux/mroute.h>
  
  Also add a include <net/sock.h> to linux/mroute.h as it uses
  struct sock, etc.


 include/linux/mroute.h |    2 ++
 net/ipv4/raw.c         |    1 +
 2 files changed, 3 insertions(+)


diff -Nru a/include/linux/mroute.h b/include/linux/mroute.h
--- a/include/linux/mroute.h	Sat Nov 23 17:07:30 2002
+++ b/include/linux/mroute.h	Sat Nov 23 17:07:30 2002
@@ -126,6 +126,8 @@
  */
 
 #ifdef __KERNEL__
+#include <net/sock.h>
+
 extern int ip_mroute_setsockopt(struct sock *, int, char *, int);
 extern int ip_mroute_getsockopt(struct sock *, int, char *, int *);
 extern int ipmr_ioctl(struct sock *sk, int cmd, unsigned long arg);
diff -Nru a/net/ipv4/raw.c b/net/ipv4/raw.c
--- a/net/ipv4/raw.c	Sat Nov 23 17:07:30 2002
+++ b/net/ipv4/raw.c	Sat Nov 23 17:07:30 2002
@@ -55,6 +55,7 @@
 #include <linux/sockios.h>
 #include <linux/socket.h>
 #include <linux/in.h>
+#include <linux/mroute.h>
 #include <linux/netdevice.h>
 #include <linux/in_route.h>
 #include <linux/route.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.858
## Wrapped with gzip_uu ##


begin 664 bkpatch18799
M'XL(`/+1WST``^U576_3,!1]KG_%E?8(37SM.'$B.NT#!&A(3$5[`AX\QUJB
M-4D5.QU(^?&X`;IFZE:M\`:)G^+KDW///2<Y@BMKVFRB=&7($;QKK,LFNJF-
M=N5*!;JI@NO6;\R;QF^$15.9\.PBK(V;LD`0OW.IG"Y@95J;33#@FR?N^])D
MD_F;MU<?3N>$S&9P7JCZQGPR#F8SXIIVI1:Y/5&N6#1UX%I5V\JXX9W]IK1G
ME#)_"TPX%7&/,8V27F..J"(T.661C*-[M*6I;[KR:3A$QACR%.->,$QC\AHP
MD$("92%BR#A@DE',:#*E+*,4UN*</!0%7C"84G(&?[>3<Z*A`:]O6"Y74=BJ
MNT!GH/(<JM+:LKZ!LM:++C?P:E'6W;>P:IO.F:`X]@?].EW89BA7]X5K--OH
M6U_DV<+X'"@+I8/.&NN/6]=VVL&Z^B48IP-R`0+C2)++^_F1Z3,O0JBBY'B/
M5+_XAF-^V[JE$>UIRA/L\TB:ZP2-HKD0,H]VS^@I2.\"CE*DW$/*5(J]],8S
M&=$2LN><<>G'B3PQ$66*&Z%2^0BM'5!;="*&E`V)V4U_?WS^1$FR7,?W,%RY
M;K^G"95T"!7?BE2<B33C]'^DUI$:#/<1INW=L'Q"+A\9]@%9>X],`B-'N\B2
M+X.QQF+L-]0AWB>%M]'"NB`WGW^C?]UM?4Q0TC@2/4\3+@?KL/BYWL%_Q#L_
I/P\/S#-F>(AI1`*XY9F'W6S^Z[HP^M9VU<Q0R6/-D?P`5CO-NT0(````
`
end
