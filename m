Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSKEQcp>; Tue, 5 Nov 2002 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264921AbSKEQcp>; Tue, 5 Nov 2002 11:32:45 -0500
Received: from signup.localnet.com ([207.251.201.46]:41407 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S264920AbSKEQcn>;
	Tue, 5 Nov 2002 11:32:43 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [PATCH] [TRIVIAL COMPILE FIX] drivers/ieee1394/sbp2.[ch] 2.5.46+
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 05 Nov 2002 11:39:03 -0500
Message-ID: <m3pttkkm3c.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sbp2 needs this to compile.  It was posted to lkml but has not made it
into bk://linux.bkbits.net/linux-2.5 yet.

You can pull the cset from:

bk://cloos.bkbits.net/sbp2fix

Or you can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================

ChangeSet@1.903, 2002-11-05 11:24:46-05:00, cloos@lugabout.jhcloos.org
  sbp2.h:
    Update sbp2scsi_biosparam() declaration to match sbp2.c
  sbp2.c:
    C s/capacy/capacity/

 sbp2.c |    4 ++--
 sbp2.h |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff -Nru a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
--- a/drivers/ieee1394/sbp2.c	Tue Nov  5 11:33:12 2002
+++ b/drivers/ieee1394/sbp2.c	Tue Nov  5 11:33:12 2002
@@ -3139,12 +3139,12 @@
  */
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,44)
 static int sbp2scsi_biosparam (struct scsi_device *sdev,
-		struct block_device *dev, sector_t capacy, int geom[]) 
+		struct block_device *dev, sector_t capacity, int geom[]) 
 {
 #else
 static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]) 
 {
-	sector_t capacy = disk->capacity;
+	sector_t capacity = disk->capacity;
 #endif
 	int heads, sectors, cylinders;
 
diff -Nru a/drivers/ieee1394/sbp2.h b/drivers/ieee1394/sbp2.h
--- a/drivers/ieee1394/sbp2.h	Tue Nov  5 11:33:12 2002
+++ b/drivers/ieee1394/sbp2.h	Tue Nov  5 11:33:12 2002
@@ -549,10 +549,10 @@
 static int sbp2scsi_detect (Scsi_Host_Template *tpnt);
 static const char *sbp2scsi_info (struct Scsi_Host *host);
 void sbp2scsi_setup(char *str, int *ints);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,28)
-static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]);
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,44)
+static int sbp2scsi_biosparam (struct scsi_device *sdev, struct block_device *dev, sector_t capacity, int geom[]);
 #else
-static int sbp2scsi_biosparam (Scsi_Disk *disk, struct block_device *dev, int geom[]);
+static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]);
 #endif
 static int sbp2scsi_abort (Scsi_Cmnd *SCpnt); 
 static int sbp2scsi_reset (Scsi_Cmnd *SCpnt); 

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch5652
M'XL(`,CRQST``[66;V_B.!#&7^-/,5+?M'>0^"\A65%QUZ*[:JNVHNKII-4*
M&<>0M"%&L>FU4C[\.:%TU>V6ZZ(KH$P8X\?CQ[^).(`;JZNDHPIC+#J`/XUU
M2:=8+^3,K%UPF[4#@:D6?G!BC!\,E_+!F2IL1\*KRMQJY6QXGI?KA]#.5G2>
M/_1H()"?<26=RN!>5S;ID(`]9]SC2B>=R?B/F_/?)@@-AW"2R7*AK[6#X1!Y
M^7M9I'8D75:8,G"5+.U2.QDHLZR??UI3C*E_"Q(Q+/HUZ6,>U8JDA$A.=(HI
M'_0YJM;6/8Z:JS+5JI$(Y/H[%4*PP(P+1FHVH#Q"IT""&#/`-"0DQ`((22A/
M>+^'18(QM+L?_<@H^)5"#Z/?X?_=Q0E2T+@;9(F_`[A9I=+I-F65S:>SW-B5
MK.3R\`A2K0I_ZW)3^BI@V7K>3E9;%;51.0$;*KF2ZG$3<O<8HL_`!A$FZ.K;
MJ:#>3[X0PA*C8U@U:__8@;3*&S+"7&M-6,S#36'?_(@))8,:XPA'=3R;$Z:$
MUBK&WICYC@/8*=P<-.E3S$7M;69BGQ*S5R42RG&=IDQ[]3ZC7`SF6OY\B=F+
M$D5<\T%,^FU_O+&GIEL^RF)TJV]GH^6Z6%3R7@>'I2GUT6YS,8U]B!CSYM*8
MM5U$HI=-A!,NWM=$]$.:Z`WD6Q@NH5?]TWX\P5=OF;Y',YPRPBD0=/84.QWK
MJK5R,"N,NINF^CY7&G[QL0O6/T]--76P+:\+>>E@H<WRR]<C:+6B)ZTF=EY-
M`,]+;N]ZQ]O$IQT,97LQ],X>0#-EBB(O[2C5LUR6S=E^V9[IU]UM@`EK`N4U
M[Q,RV,!$OH=)Q.^`B4&/?0A,^SZ%/6]M:[\+N&P?X(2@0-&9$,R'@WP.YV<7
M-W]/_QI/KL\N+Z8GEZ=C.(;/X\G%^'R;/:1=T>7\"%GGRU8M=J^W!H=/[+;I
M+;IVP^Z>5']J"A8-U)OP'P5<-]]//>)>W%^[<.?7\-KM2B]DG_]RJ$RK.[M>
1#KE(XY@HC/X%SG@;K_P(````
`
end

