Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUCQPTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 10:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUCQPTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 10:19:47 -0500
Received: from mail1.kontent.de ([81.88.34.36]:64157 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261580AbUCQPTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 10:19:44 -0500
From: Oliver Neukum <oliver@neukum.org>
To: emoenke@gwdg.de
Subject: compilation error in cdu31a
Date: Wed, 17 Mar 2004 16:20:19 +0100
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403171620.19764.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

cdu31a doesn't compile. It looks like a simple oversight.

	Regards
		Oliver

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1179, 2004-03-17 16:02:41+01:00, oliver@vermuden.neukum.org
  - fix syntax error


 cdu31a.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
--- a/drivers/cdrom/cdu31a.c	Wed Mar 17 16:19:34 2004
+++ b/drivers/cdrom/cdu31a.c	Wed Mar 17 16:19:34 2004
@@ -3315,7 +3315,7 @@
 	unsigned int res_size;
 	char msg[255];
 	char buf[40];
-	int i;
+	int i, tmp_irq;
 
 	/*
 	 * According to Alex Freed (freed@europa.orion.adobe.com), this is
@@ -3335,7 +3335,7 @@
 
 	if (cdu31a_port != 0) {
 		/* Need IRQ 0 because we can't sleep here. */
-		int tmp_irq = cdu31a_irq;
+		tmp_irq = cdu31a_irq;
 		cdu31a_irq = 0;
 		if (!get_drive_configuration(cdu31a_port,
 					    drive_config.exec_status,
@@ -3487,4 +3487,4 @@
 module_exit(cdu31a_exit);
 
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_BLOCKDEV_MAJOR(CDU31A_CDROM_MAJOR);
+MODULE_ALIAS_BLOCKDEV_MAJOR(CDU31A_CDROM_MAJOR);
\ No newline at end of file

===================================================================


This BitKeeper patch contains the following changesets:
1.1179
## Wrapped with gzip_uu ##


begin 664 bkpatch20543
M'XL(`(9L6$```[U4:V^;,!3]C'_%E?IE4P?XVN81*J:D2;1U398H7?9EFB(*
M3H,2(#/0M1(_?LZC[3:US5Z:L;C(YW!][O61CV!:2A48Q2J]EHH<P=NBK`)#
M?V=U(G,KE_6RSJQ"76EL4A0:LQ=%)NW=#_8')65IK]*\+DUF.42SQE$5+T"#
M96"@Q>]7JMNU#(Q)_\UTT)D0$H;0743YE;R0%80AJ0IU':V2LAU5BU616Y6*
M\C*3563%1=;<4QM&*=./@QZGCMN@2X77Q)@@1@)E0IGP74%V\MJ/U/%C*D$Y
M>L@=SEN-2WU$T@.T$+T64&%3;J,'Z`:4!0*/*0:4PM.IX1C!I.04_FTM71*#
M"?/T!LK;O(IN0"I5*'(.+B(R,G[H(S%_<Q!"(TI>'Q"<J$W%I1TGJLCTN^:H
M@>_4"XJTX<QI.<V<2E<7PRX='DOA/].M9]+N3L6AC(F&,D^(K5T>YQ_VSE_(
M)]%RG;6+,EEM%'^ZV^?S`>TN.N@S7VMGGK=UE,"?_<3$+_B)@\G_GY^VG1Z!
MJ;YNI[;'^(FF_X'1>IRC#TC.]M%(\PK25U!EZUFJOIQL"'Q/V$;#V$,0PF[?
M.YYH48V_W\?AJ#<=]&>=P5GG8G8Z&'7/>_V/LV'GW6CRHMN;<NS,NKW):+A;
=>GGR<$?%"QDORSH+*9][SF5K3KX!#=7SH`\%````
`
end

