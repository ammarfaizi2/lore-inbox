Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbTD3UHE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbTD3UHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:07:03 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:40377 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262445AbTD3UHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:07:01 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: linux-dev@micro-solutions.com
Subject: [PATCH] Linux 2.5.68 - Debug statement after return in drivers/block/paride/bpck6.c
Date: Thu, 1 May 2003 16:17:25 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305011617.26267.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to 2.5.68, it is listed on kbugs.org. The verbose debug statement is after the return so it is never executed.

Please CC me with any discussion.
- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

- ---FILE---

- --- linux-2.5.68/drivers/block/paride/bpck6.c	2003-04-19 22:49:57.000000000 -0400
+++ linux-2.5.68-changed/drivers/block/paride/bpck6.c	2003-05-01 14:43:12.000000000 -0400
@@ -193,11 +193,11 @@
   	if(out)
  	{
 		ppc6_close(PPCSTRUCT(pi));
- -		return(1);	
 		if(verbose)
 		{
 			printk(KERN_DEBUG "leaving probe\n");
 		}
+		return(1);
 	}
   	else
   	{

- ---ENDFILE---
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sYDV7I5UBdiZaF4RAkODAJ4wmY1AYo3dONkEbTjGLyQ9gEI1mwCgkxJW
rJQttaDC4vtrXjaplT+9eAk=
=bUUN
-----END PGP SIGNATURE-----

