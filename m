Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261798AbSJIQOU>; Wed, 9 Oct 2002 12:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbSJIQOU>; Wed, 9 Oct 2002 12:14:20 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:46074 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261798AbSJIQOS>; Wed, 9 Oct 2002 12:14:18 -0400
Date: Wed, 9 Oct 2002 09:13:37 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] last sysrq fixes.
Message-ID: <Pine.LNX.4.33.0210090912450.8024-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the last of the handle_sysrq breakage.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.691, 2002-10-08 13:40:24-07:00, jsimmons@maxwell.earthlink.net
  Already fixed.


 arch/um/kernel/um_arch.c |    2 +-
 drivers/tc/zs.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
--- a/arch/um/kernel/um_arch.c	Wed Oct  9 08:36:23 2002
+++ b/arch/um/kernel/um_arch.c	Wed Oct  9 08:36:23 2002
@@ -337,7 +337,7 @@
 		      void *unused2)
 {
 #ifdef CONFIG_SYSRQ
-	handle_sysrq('p', &current->thread.regs, NULL, NULL);
+	handle_sysrq('p', &current->thread.regs, NULL);
 #endif
 	machine_halt();
 	return(0);
diff -Nru a/drivers/tc/zs.c b/drivers/tc/zs.c
--- a/drivers/tc/zs.c	Wed Oct  9 08:36:23 2002
+++ b/drivers/tc/zs.c	Wed Oct  9 08:36:23 2002
@@ -443,7 +443,7 @@
 		if (break_pressed && info->line == sercons.index) {
 			if (ch != 0 &&
 			    time_before(jiffies, break_pressed + HZ*5)) {
-				handle_sysrq(ch, regs, NULL, NULL);
+				handle_sysrq(ch, regs, NULL);
 				break_pressed = 0;
 				goto ignore_char;
 			}

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch7145
M'XL(`/=,I#T``\U674_;,!1]QK_"$H]3DWMM)[$C=2J#:9-8-<3$\V0<0T.3
M!B4I'U-^_)RT?(HVI<"TME*MQ#X^]][C<[U+3RI;QCL759KGQ:PBN_1[4=7Q
M3JYOKFV6>5:7]21+9U-O9FOW]K@HW%M_7I5^51K?N#5%9@=5K4\S2]R$(UV;
M";VR917OH,?OG]2WES;>.?[Z[>3'WC$APR'=G^C9N?UE:SH<DKHHKW265"/M
MMBMF7EWJ697;6GNFR)O[J0T#8.X;8,0A"!L,042-P011"[0),"%#0>["&;T8
MQC,X!)`.D[.P"8142`XH>J%""LQ'\$%2Y+&`F(D!1#$`78]./W$Z`/*%OF](
M^\30O:RT.KFE9^F-33R2]C!YOH?"")6+%QN(%,@MUDL4G`>\X4Q*M=7ZD$F4
M#0\C9.20!C+D`1F_$>?H04ID\,H/(:"!?.XI5E*FK:+]VOA_*L\\*ID`1P,1
M1-`X5AH,!MR&8`+9IY,701=:="D6#:A02,?L(DFG=C35I;Y=D-&EF?CSW)_:
M<F8S-_K=/KECI9!AQ"(A&A8QAHVQG">G@$:*T$V(^EBM17]$3Z`+W=&[;$_W
M^JQ57(%O)KKT35UF[>!Q"J4#Q095%$;-62@2$W&TD53@2KMI"E?NL"#LF';Y
M5$%G/*M";'WHG;/=YT1]Z)W0(6B$0AYVQL2?V!(/8KZI+<&'V=*\+FANRW.;
MM)[097">9][F661MA3B"4U6D6F-8J&O\'F`_Z:"\[G[NM!^M+/X6SM%J:9T"
M6SU]Z/'H4U?_#@\*XUP%T"DL>-[X\!4*PW_3^"HSN4X3>U9-;T>)]=+3?+.4
MNF0*E"(`M@SXK5"!\_ZEM1S2[F_\?HC/I+L.8`OY'C!!\8F(EYVH_SZV53_<
M5*U/0!\$"LJ=YTZ@T?]N@7IZF8^2]-P6*[/5-B8'ZZK=N"%7G7I<OQ]OM7B%
?4)9KMK&VNVN[F5@SK>;YT-74W91`D+\2(U7K,PP`````
`
end

