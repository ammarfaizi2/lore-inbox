Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268552AbTANDdV>; Mon, 13 Jan 2003 22:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268549AbTANDdQ>; Mon, 13 Jan 2003 22:33:16 -0500
Received: from fmr01.intel.com ([192.55.52.18]:8140 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268548AbTANDdK>;
	Mon, 13 Jan 2003 22:33:10 -0500
Subject: [TRIVIAL PATCH] fix and export kset_find_obj
From: Louis Zhuang <louis.zhuang@linux.co.intel.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       FITHML <fault-injection-developer@lists.sourceforge.net>
Content-Type: text/plain
Organization: Intel Crop.
Message-Id: <1042515724.3951.5.camel@hawk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 14 Jan 2003 11:42:05 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mochel,
	I suggest to export kset_find_obj. Pls apply. ;-)
-- 
Yours truly,
Louis Zhuang
---------------
Fault Injection Test Harness Project
BK tree: http://fault-injection.bkbits.net/linux-2.5
Home Page: http://sf.net/projects/fault-injection

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.970, 2003-01-14 11:34:48+08:00, louis@hawk.sh.intel.com
  trivial fix and export kset_find_obj


 include/linux/kobject.h |    2 +-
 lib/kobject.c           |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Tue Jan 14 11:36:05 2003
+++ b/include/linux/kobject.h	Tue Jan 14 11:36:05 2003
@@ -87,7 +87,7 @@
 }
 
 
-extern struct kobject * kset_find_obj(struct kset *, char *);
+extern struct kobject * kset_find_obj(struct kset *, const char *);
 
 
 struct subsystem {
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Tue Jan 14 11:36:05 2003
+++ b/lib/kobject.c	Tue Jan 14 11:36:05 2003
@@ -295,7 +295,7 @@
  *	looking for a matching kobject. Return object if found.
  */
 
-struct kobject * kset_find_obj(struct kset * kset, char * name)
+struct kobject * kset_find_obj(struct kset * kset, const char * name)
 {
 	struct list_head * entry;
 	struct kobject * ret = NULL;
@@ -386,6 +386,8 @@
 EXPORT_SYMBOL(kobject_unregister);
 EXPORT_SYMBOL(kobject_get);
 EXPORT_SYMBOL(kobject_put);
+
+EXPORT_SYMBOL(kset_find_obj);
 
 EXPORT_SYMBOL(subsystem_init);
 EXPORT_SYMBOL(subsystem_register);

===================================================================


This BitKeeper patch contains the following changesets:
1.970
## Wrapped with gzip_uu ##


begin 664 bkpatch3959
M'XL(`*6%(SX``\55:VO;,!3]'/V*"_W2Q^)<O6S'(Z/K@ZVLHR%=88-!46VY
M]N)8Q5;2#/SC)[MK2]9FI:50VTB@*QT=G7.$-^"LUE74*\P\K\D&?#:UC7J9
MNIYZ=>;EI=6%%YN9JTR,<95!9F9ZT,T>,$_VTYRXVEC9.(.%KNJH1SU^-V)_
M7^FH-SG\=';\<4+(:`3[F2HO]:FV,!H1:ZJ%*I)Z5]FL,*5G*U76,VU5NV5S
M-[5AB,R]D@8<I=]0'T70Q#2A5`FJ$V0B]`7I2.T^H+Z*PY%2X5K&_(8)I)P<
M`/6&`0+R`=(!%4!IQ$4DPAT,(T18`PL[#/I(]N!U#[%/8K!5OLA5`6F^!%4F
MH)=7IK(PK;4]3_,R.3<7O\@78%(*2<;WDI+^,Q]"4"'Y`#,39[K8-752>*:Z
M;(K\8C!UF^C8>G%'G#K)G')#%`W*H>0-9VE*&2J%88B)3-?)]!#KKP-<"-9@
MZ/OL$0)Y&1?SQ.4L+^?+N^79*I6@010A-MSW*4L%7H2!#(20:ZG\!_6>%&VD
M#,.@"^N:!6UT7Y7Q<]!:IIPZCD(XIAQ%%V`:/,@O?2J_%/KT+?-[H_,)]*OK
M[G-Y'*^3_`71/A@B4'+4M7II=55";:MY[(C<H,+V*J7-V[(;A.UW$)NRMA!G
MJH+MK?==(%;"_%@,7G!SGL9H+4<JF=\&2$I*UUG.GK*<O['EW77_Q_&5X[[$
M9S8,6Z-ONN=8W'6K/D.I9GJ+'/$P!$9^DL/OXY/)M_/3'U_W3HXW5[#:2-S^
7YYR!\;2>ST9*.[.%4N0/H;:>H5@'````
`
end

