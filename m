Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319488AbSIGNfb>; Sat, 7 Sep 2002 09:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319489AbSIGNfb>; Sat, 7 Sep 2002 09:35:31 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:51587 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S319488AbSIGNf3>; Sat, 7 Sep 2002 09:35:29 -0400
Subject: NTFS: fix modular compile
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 7 Sep 2002 14:40:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17nfon-000247-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please apply the below patch (against you current BK tree) which exports
fs/buffer.c::unmap_underlying_metadata() which is required to fix NTFS
as a module. (It is broken at the moment...)

Patch is against your current BK tree.

Thanks,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/buffer.c |    1 +
 1 files changed, 1 insertion(+)

through these ChangeSets:

<aia21@cantab.net> (02/09/07 1.622)
   Export unmap_underlying_metadata() to fix NTFS as a module.


diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Sat Sep  7 14:36:10 2002
+++ b/fs/buffer.c	Sat Sep  7 14:36:10 2002
@@ -1623,6 +1623,7 @@
 		__brelse(old_bh);
 	}
 }
+EXPORT_SYMBOL(unmap_underlying_metadata);
 
 /*
  * NOTE! All mapped/uptodate combinations are valid:

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch53396
M'XL(`,H`>CT``]6446O;,!#'GZ-/(>A+2[%\)\EV[)&1M<NZL6X)20O;4Y!E
MI0F-[2#+7EK\X>=FT(2%43KV,DE/)^FON__]T`F]K8Q->FJE.)(3^K&L7-+3
MJG`J985Q76A:EEW(KROK5U;[ZU51;SW.`B^M%Z3;GRBGE[0QMDIZR,1SQ#UL
M3-*;CJYNK]]-"1D,Z.52%7=F9AP=#(@K;:/66354;KDN"^:L*JK<.,5TF;?/
M1UL.P+L98"0@"%L,04:MQ@Q12309<-D/)6E4D=FR,<-&,]W4CNG'WS5B"`$Q
MPK@%V8]"\IXB"SFGP'V(?8@HRD0$B0S/`1,`NK-DN+>"GB/U@%S0?YOY)=%T
MM-V4UM&ZR-5F7A>9L>N'57$W?Q+-E%.G9]VC=+':TJ\W'V945531O,SJM6'D
M,^VJD62R=Y=XKQR$@`+R]H7"%I7?=7QA+-.'I<6BWP)'P#9-#9>APDAK'J=A
M?.3@L40,$0H1"-FY(R+<47)PZ&5.7IT44?>;?/BXVCQ=9ZH^5N@+X%S&'2?(
M.ZT=)RB/.!'R?^/DE\5CZMD?N]4U?G+H]E]P\PE#'E`DHV^3\?1F/OO^Y6)\
???K'_,[>[#\,O33ZOJKS08H+$"EH\A.SC=.KC`0`````
`
end
