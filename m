Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267526AbSKQRP5>; Sun, 17 Nov 2002 12:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbSKQRP5>; Sun, 17 Nov 2002 12:15:57 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:46862 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267526AbSKQRP4>; Sun, 17 Nov 2002 12:15:56 -0500
Date: Sun, 17 Nov 2002 15:22:40 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trivial Patch Bot <trivial@rustcorp.com.au>
Subject: [PATCH] dquot: fix up header file cleanups
Message-ID: <20021117172240.GL28227@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Trivial Patch Bot <trivial@rustcorp.com.au>
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

	In this tree there will be several similar changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.854, 2002-11-17 15:10:44-02:00, acme@conectiva.com.br
  o ps2esdi: fixups after header file cleanups
  
  Also fix a printk usage.


 ps2esdi.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)


diff -Nru a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
--- a/drivers/block/ps2esdi.c	Sun Nov 17 15:11:09 2002
+++ b/drivers/block/ps2esdi.c	Sun Nov 17 15:11:09 2002
@@ -37,14 +37,13 @@
 #define DEVICE_NR(device) (minor(device) >> 6)
 
 #include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/mm.h>
+#include <linux/wait.h>
+#include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/genhd.h>
 #include <linux/ps2esdi.h>
 #include <linux/blk.h>
-#include <linux/blkpg.h>
 #include <linux/mca.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
@@ -508,7 +507,7 @@
 	}
 
 	if (req->sector+req->current_nr_sectors > get_capacity(req->rq_disk)) {
-		printk("Grrr. error. ps2esdi_drives: %d, %lu %llu\n",
+		printk("Grrr. error. ps2esdi_drives: %d, %llu %llu\n",
 		    ps2esdi_drives, req->sector,
 		    (unsigned long long)get_capacity(req->rq_disk));
 		end_request(req, FAIL);

===================================================================


This BitKeeper patch contains the following changesets:
1.854
## Wrapped with gzip_uu ##


begin 664 bkpatch15417
M'XL(`*W-UST``\U4;6O;,!#^;/V*HZ$P6&WK',EO+*4O*5WI8"6CWP9#D978
MQ+&#9*<=^,=/<4(S^DJW?9@LZ4!W?O3<W8,&<&N43ATAEXH,X'-MFM21=:5D
M4ZR%)^NE-]76,:EKZ_#S>JG\LVN_J&399LJX@<>)==^(1N:P5MJD#GK#AY/F
MYTJESN3B\O;+Z820T0C.<U'-U3?5P&A$FEJO19F9$]'D95UYC1:56:JFO[A[
M".T"2@/[<8R&E(<=AI1%G<0,43!4&0U8'#*RR>'D,?='*(@8(3*DM+,KBLD8
MT(LY`QKXB#Y&@#Q%FC+FTB"E%)X%A8\(+B5G\&\3."<2:EB90)FL2&%6W+<K
M`V+6*`VY$IDULZ)4($LE*NNRX7:>EJ;>Q(*`E2ZJ9@&M$7/ED6M(Z)"2FWW-
MB?O.00@5E!R_D6>FBTWK_6E9RX6_X^_)W[)FE+(NX#&/.L6%3+*0\BG#A,GD
M^0J_BMDW,4+*;!-CC'DOK!=^>%MF?\5^C[U2U;PMW@..:,'C(.#88<*3L-=B
M2)](D;XNQ2&X[/^7XK917\'5=_VTVKIYJ6=_(-,QHQ"0*X9V'^Q>)_A4%E5[
M[]^)HO'RXR?GEJ#2NEWUSC&S]29CCFC-U=8XSC:+#P>76FL/;'1MS8[GCYZ]
G2>$P.X+#LFS[[7MU<+1_$66NY,*TRY%(V#2.>$!^`:@15[!Q!0``
`
end
