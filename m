Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313589AbSD3QJa>; Tue, 30 Apr 2002 12:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313657AbSD3QJ3>; Tue, 30 Apr 2002 12:09:29 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:54167 "HELO
	kleikamp.austin.ibm.com") by vger.kernel.org with SMTP
	id <S313589AbSD3QJ2>; Tue, 30 Apr 2002 12:09:28 -0400
To: torvalds@transmeta.com
Subject: [BK PATCH] JFS needs to initialize log->bdev
Cc: linux-kernel@vger.kernel.org
Message-Id: <20020430160917.9B6A33871@kleikamp.austin.ibm.com>
Date: Tue, 30 Apr 2002 11:09:17 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
This patch fixes a trap during mount of a JFS volume on linux-2.5.11.
The BK patch was built in a clean tree against your tree on bkbits,
so it will apply cleanly.

Thanks,
Shaggy

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.548, 2002-04-30 10:57:25-05:00, shaggy@kleikamp.austin.ibm.com
  JFS: log->bdev must be initialized for inline log
  
  log->bdev was not being initialized.  It had not been used until
  Al Viro's recent change from using bio->b_dev to bio->b_bdev.


 jfs_logmgr.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
--- a/fs/jfs/jfs_logmgr.c	Tue Apr 30 10:58:11 2002
+++ b/fs/jfs/jfs_logmgr.c	Tue Apr 30 10:58:11 2002
@@ -1072,6 +1072,7 @@
 	 */
 
 	log->sb = sb;		/* This should be a list */
+	log->bdev = sb->s_bdev;
 	log->flag = JFS_INLINELOG;
 	log->base = addressPXD(&JFS_SBI(sb)->logpxd);
 	log->size = lengthPXD(&JFS_SBI(sb)->logpxd) >>

===================================================================


This BitKeeper patch contains the following changesets:
1.548
## Wrapped with gzip_uu ##


begin 664 bkpatch2801
M'XL(`!._SCP``\V4RVZ<,!2&U^.G.%(67508VV!N%:.DZ2UMI8XF2K>1`3/0
M`3S"9J)4/'P-23-=9%*E:J6"61B?\Y_;)Y_`E99]LM"5V&QNT0E\4-HDBVTC
MZZUH=U@,VM0=KK,6YZJUYVNE[+E;J5:Z=TYNMG6_E=IAF"-KL!(FKV`O>YTL
M*/8>_IC;G4P6Z[?OKSZ?K1%*4SBO1+>1E])`FB*C^KUH"GTJ3-6H#IM>=+J5
M1DQQQP?3D1'"[,MIZ!$>C#0@?CCFM*!4^%06A/E1X!_4ICR?UO)93!AGE(PL
MB$F,W@#%W(^`,)?XKD>`DH2'">,.X0DA<%?TZ9$.P4L*#D&OX>_6<XYR^/CN
M,H%&;9QE5L@]M#8N9!+JKC:U:.KOLH!2]7;?U)V<#*V/70>/&Z&A4Y-3W6U^
M]<,`%P8J4=P?RPX&;>6&SM2-E3AKX&O=JQ<:>IG+SD`^IP]E;PL>]*26U<I&
MN9["&/5S-T7%Z!.PB!&*5H>!(^>9#T)$$+2$W832L=Z/I9Y`G+YK6W6[Z7%^
MWU_&*">4L]&+61"-N6!91,(HLUTNRUS^9JC'A7W/JO*0\9%1YL<SUH\83X#_
MH]31WD[FM+64X9T>L"R&)[*UG!-..!]IS+@WHT[I_T?ZLR"W>,VM_P).?S,O
MB\OJL2G\`747E(0^4+0XI)2"SIREGN%^=;CP\DKF6SVT:2G*(**>1#\`"28>
%+5L%````
`
end
