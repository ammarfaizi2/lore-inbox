Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSHVXnu>; Thu, 22 Aug 2002 19:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSHVXnu>; Thu, 22 Aug 2002 19:43:50 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:10377 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318061AbSHVXnt>; Thu, 22 Aug 2002 19:43:49 -0400
Subject: [BK-2.4 PATCH] Fix compile with highmem and highio
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Fri, 23 Aug 2002 00:47:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17i1gF-00034U-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Below patchlet is required to make your current bk tree compile with
highmem and highio enabled.

Please apply.

You can also get this changeset by doing a:

	bk pull http://linux-ntfs.bkbits.net/linux-2.4-kmapfix

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 kernel/ksyms.c |    2 --
 1 files changed, 2 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/23 1.588)
   Remove duplicate & bogus kmap_prot and kmap_pte exports.
   These are arch specific and only four architectures implement them. So
   on all other orchitectures with highmem enabled compilation would fail with
   these exports in ksyms.c... The architectures which need them already
   export them via their arch-ksyms files.


diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Fri Aug 23 00:39:13 2002
+++ b/kernel/ksyms.c	Fri Aug 23 00:39:13 2002
@@ -123,8 +123,6 @@
 EXPORT_SYMBOL(kunmap_high);
 EXPORT_SYMBOL(highmem_start_page);
 EXPORT_SYMBOL(create_bounce);
-EXPORT_SYMBOL(kmap_prot);
-EXPORT_SYMBOL(kmap_pte);
 #endif
 
 /* filesystem internal functions */

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch2875
M'XL(`"%V93T``^U576O;,!1]CG[%A<)>2AQ)=AP[D)&M'1MLL)*NST.5KVL1
MV3*2G#3@'S_%">V:=925/>QA_L#VU='AW(^#S^#&H9V/A!*<D3/X9)R?CZ1H
MO+B-&O0AM#(FA":=LQ-GY:065J(V8QXEXW4MVE+=DX"Z$EY6L$'KYB,6Q0\1
MOVMQ/EI]^'CSY=V*D,4"+BK1W.$U>E@LB#=V(W3AEL)7VC21MZ)Q-7H125/W
M#]">4\K#.66SF$[3GJ4TF?62%8R)A&%!>9*E"3EJ6[:ZD^M=5"CGK0E,#4JO
M-N*4+V,YCWF:Q#WG.<W));!HFF5`^81F$QX#I?,XG2?TG+(YI3`4:?E8'#AG
M,*;D/?S=+"Z(A!769H-0=*U64GB$-W!K[CH'^Y)_;ZWQ()KB^!66\;XUUKLH
M;/U6H4,0=G^'!K@6I2J5'/"FT3LH36>'->5#73J+#E3=:JRQ\>`KK".X-H'(
M-""T!A-"%LP3_%;Y"BIU5]58`S;B5F,!(==6:>%5V+@UG2Z@%$H/V,#F!UE'
MG:`:6+M=[2(91=%>\HF@;:6"]@8#[5Y1$&)1%+O`<V`X1#=*[%_4(9WQP`BE
MTA@*\1EX'.<9N7H<.#+^PX,0*BAY^T)_UV@;U)-C/C\W.8_S/CQIW,^*65QF
M0A;3,N/Y3/XR2\^R9)R')-)XVL<Y3=+!/D]Q+WOH->I():NE=CXJ\'E=C+,\
MF25YGP3_\,$X*3OU33S]K6\HC/E_W_RCOCG,VE<8V^UP!1]<G8S=*YQTR7@*
:_/%7(2N4:]?5"Y&GLIREC/P`F%1GGHP&````
`
end
