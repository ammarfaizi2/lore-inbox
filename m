Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318755AbSG0NnQ>; Sat, 27 Jul 2002 09:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSG0NnQ>; Sat, 27 Jul 2002 09:43:16 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:41864 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318755AbSG0NnO>; Sat, 27 Jul 2002 09:43:14 -0400
Subject: [BK PATCH 2.5] fs/ntfs/dir.c: use PAGE_CACHE_MASK_LL with 64-bit values
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 27 Jul 2002 14:46:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17YRtw-0006I7-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Following from previous patch which introduced PAGE_CACHE_MASK_LL, this
one fixes a bug in fs/ntfs/dir.c which was using PAGE_CACHE_MASK
on 64-bit values... It now uses PAGE_CACHE_MASK_LL.

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

 fs/ntfs/dir.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/27 1.479)
   fs/ntfs/dir.c: Use PAGE_CACHE_MASK_LL() on 64-bit values.


diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Sat Jul 27 14:24:09 2002
+++ b/fs/ntfs/dir.c	Sat Jul 27 14:24:09 2002
@@ -1232,7 +1232,8 @@
 	ntfs_debug("Handling index buffer 0x%Lx.",
 			(long long)bmp_pos + cur_bmp_pos);
 	/* If the current index buffer is in the same page we reuse the page. */
-	if ((prev_ia_pos & PAGE_CACHE_MASK) != (ia_pos & PAGE_CACHE_MASK)) {
+	if ((prev_ia_pos & PAGE_CACHE_MASK_LL) !=
+			(ia_pos & PAGE_CACHE_MASK_LL)) {
 		prev_ia_pos = ia_pos;
 		if (likely(ia_page != NULL))
 			ntfs_unmap_page(ia_page);

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch22037
M'XL(`/F>0CT``\V4T6K;,!2&KZVG.*,P$HIM2;:LV.#1-`WM2,I"2J^-K,B+
M66('2\DVIH>?FD*S)-U@91>SA(V.#D>__N_@"WC4JLL\40M*T`7<M=IDGA2-
M$670*.-"\[9UH7"KNU!W,ES5S?:;3P/F;];(;<^$D4O8J4YG'@FBEXCYOE&9
M-Q_?/DZ'<X3R'$9+T7Q6#\I`GB/3=CNQ6N@K89:KM@E,)QJ]5D8$LEW;EU1+
M,:9N,,(CS!)+$AQS*\F"$!$3M<`T'B0QVLN_.L@^+<`I)Q&E#%LV8`RC&R!!
MS%/`-,0\I!Q(G-$H8_P2DPQC.*T'EP1\C*[AW\H>(0F5#AOC7HNZ"V3VA`-F
MP]MQ,1J.[L;%_?!A4DRGO3ZT#22Q7]8&G("MT@&:@+M,G*+9P5GD_^6#$!88
M?8#KB3T28DG*,29N1#AEJ<5N06R%TVH@JRH5I;M1&9WY=%+D%^\CQFS,G1?[
M5CA*>VJ'MYU_SOVU\PFCQ+%/;)PPQO?L$WJ&GOT6/06?_'?HG[W\!'[W=3\=
MRMEQP3?TP@UQG("@C_LO15Y=0:^WZ=2NJ$6Q:36\?T5A'][ER/.\WI]R^O#C
:\+>02R6_Z.TZ'Z1110>E1#\!=V0"HX@$````
`
end
