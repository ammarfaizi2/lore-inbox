Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318754AbSG0Nl3>; Sat, 27 Jul 2002 09:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318755AbSG0Nl3>; Sat, 27 Jul 2002 09:41:29 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:34026 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318754AbSG0Nl1>; Sat, 27 Jul 2002 09:41:27 -0400
Subject: [BK PATCH 2.5] fs/binfmt_aout.c: Use PAGE_ALIGN_LL() on 64-bit values
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 27 Jul 2002 14:44:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17YRsD-0006Hw-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Following from previous patch which introduced PAGE_ALIGN_LL, this
one fixes a bug in fs/binfmt_aout.c which was using PAGE_ALIGN
on 64-bit values... It now uses PAGE_ALIGN_LL.

Patch together with the other two patches available from:

	bk pull http://linux-ntfs.bkbits.net/linux-2.5-pm

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/binfmt_aout.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/27 1.478)
   fs/binfmt_aout.c: Use PAGE_ALIGN_LL() on 64-bit values.


diff -Nru a/fs/binfmt_aout.c b/fs/binfmt_aout.c
--- a/fs/binfmt_aout.c	Sat Jul 27 14:23:02 2002
+++ b/fs/binfmt_aout.c	Sat Jul 27 14:23:02 2002
@@ -493,7 +493,7 @@
 	if (error != start_addr)
 		goto out;
 
-	len = PAGE_ALIGN(ex.a_text + ex.a_data);
+	len = PAGE_ALIGN_LL(ex.a_text + ex.a_data);
 	bss = ex.a_text + ex.a_data + ex.a_bss;
 	if (bss > len) {
 		error = do_brk(start_addr + len, bss - len);

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch21945
M'XL(`+:>0CT``\U476O;,!1]CG[%A;ZL%,OZ]-?P2-:6K"QT(://09;5V32V
M@RUW*?C'3W.A*2Y=6=G#)('$U>7HW',/.H&;SK3)3)6*470"7YK.)C.M:JLR
M7!OK0INF<2&_[UJ_:[6_*^O^X#$LO7V%W/5:65W`O6F[9$8Q?XK8A[U)9IO+
MY<UJL4$H3>&\4/4/\]U82%-DF_9>[?)NKFRQ:VIL6U5WE;$*ZZ8:GE('1@AS
M4]*0$QD,-"`B'#3-*56"FIPP$04"C?3G1]I3@)"%E--8BD'&,J#H`B@6802$
M^23T60A4)(PEDIP1FA`"4SPXH^`1]!G^+>USI.&V\[.ROJWL5C6]Q3KYW1%8
M+Y:7V\7J:GF]7:T^G$)30R"\K+3@GN]-A]%7D)&4!*V/NB+O+P="1!'TZ8VJ
MI@R?%Q?S:&!<\F#(,N(*HYQIE6>,1R\T?`5G;`UC3AXFJ."C4Z:9;QOF?1S1
MG2KG=D]QVQ>MU]>EES6ZZ"N<FU<0)>.NEQ$7#C&*@]%(E$]]),(_^8C^9SYZ
MU/T;>.W/<3E?K%_`O<-;%R(.@**KQVVV,S6D$T+F@-76FH,3!L9SKJPZ_7C\
75W1A]%W75VD@=2Q89M`O@6G#F+($````
`
end
