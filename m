Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTIASOC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTIASOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:14:02 -0400
Received: from 1-124.ctame701-2.telepar.net.br ([200.181.138.124]:18105 "EHLO
	oops.kerneljanitors.org") by vger.kernel.org with ESMTP
	id S263310AbTIASNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:13:54 -0400
Date: Mon, 1 Sep 2003 15:13:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: remove include procfs_h from hosts.h
Message-ID: <20030901181337.GA15280@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Willy noticed that proc_fs.h was being included in hosts.h, Christoph
confirmed that he left it there just not to break any driver that was
implicitely getting proc_fs.h from hosts.h, here is a patch that cleans this,
only megaraid was broken wrt this.

	Available at:

bk://kernel.bkbits.net/acme/scsi-2.6

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1384, 2003-09-01 18:01:44-03:00, acme@allegro.kerneljanitors.org
  o scsi: remove include procfs_h from hosts.h


 hosts.h    |    1 -
 megaraid.c |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
--- a/drivers/scsi/hosts.h	Mon Sep  1 18:05:43 2003
+++ b/drivers/scsi/hosts.h	Mon Sep  1 18:05:43 2003
@@ -25,7 +25,6 @@
 #define _HOSTS_H
 
 #include <linux/config.h>
-#include <linux/proc_fs.h>
 
 #include <scsi/scsi_host.h>
 
diff -Nru a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
--- a/drivers/scsi/megaraid.c	Mon Sep  1 18:05:43 2003
+++ b/drivers/scsi/megaraid.c	Mon Sep  1 18:05:43 2003
@@ -36,6 +36,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/proc_fs.h>
 #include <linux/reboot.h>
 #include <linux/module.h>
 #include <linux/list.h>

===================================================================


This BitKeeper patch contains the following changesets:
1.1384
## Wrapped with gzip_uu ##


M'XL( *>T4S\  \U536^;0!0\9W_%2CY6AK??@.K(;5*U52LU2I53%$7K96V(
M@8V N*G$C^]"FMA14[NV>@AP 1ZS\V;>+"-\T=@Z.=*FM&B$/[FF]3=%81>U
M"Y:VKFQQHZN\=743N'KA2\Z=\R5AYDH;]E^%LV78F"8?TT B__Y,MR;#*ULW
MR1$)V-.3]N>M38[./WR\^/KN'*')!)]DNEK8[[;%DPGR*ZQTD393W6:%JX*V
MUE53VE8'QI7=4VE' :@_!5$,A.R(!*XZ0U)"-"<V!<HCR9%>WI93UZ1%3_KR
M$?OJ.0Z#& @0)CT.$"45.L4D("SB&%@(<0@$DR@!DG ^!I8 X+[AZ=_EP6\H
M'@-ZC_]O-R?(8(=[D1-<V]*M+,XK4]RE%M_6SLR;ZPS/:U?BS-O7!!GZ@CF%
M")VM)4;C/0^$0 ,ZWM%)6N>]T\, A*5=Z%KG:6 V^N( L5>7*=Y%$,_US#!J
MYC%3('>IN0U]\,XO((7J6 24[D?UMU#/>:I.T)BS3A$3L;E65#$6&Z/WX[D!
MO4F2QX308>Q?JMZ=@,/IH\QDTZ)I@]1>WMB;V=46OI(*"HQX%$&$D$,@E-B(
M@TJ$3(3ZUS@ 'I-7$8=!_6]X7/\8+C_?9R\:<4!.3FF$R9_.KN=U3W/WC1%*
M]<J6TP?Y@]EREOM&*J_FUOA$1)*(2P$=$T)%@]."'^XT>24;W\-FL,WIM1('
MF/V9]6:/'EF\+?+J[C[LR5S//8'C]1_09-8LF[MR8CA35"J*?@$]&0'4; < 
!    
 
