Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265723AbSJYAQR>; Thu, 24 Oct 2002 20:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265716AbSJYAQR>; Thu, 24 Oct 2002 20:16:17 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:55540 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265730AbSJYAPv>; Thu, 24 Oct 2002 20:15:51 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15800.36506.919790.573523@wombat.chubb.wattle.id.au>
Date: Fri, 25 Oct 2002 10:21:46 +1000
To: willy@debian.org, trivial@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Subject: Fix name of discarded section in modules.h
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,
   Changeset 
	     willy@debian.org|ChangeSet|20021016154637|46581
in linux 2.5 changed the name of .exit.text to .text.exit.

Unfortunately, one change got missed.  Here it is:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.808   -> 1.809  
#	include/linux/module.h	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/25	peterc@gelato.unsw.edu.au	1.809
# Fix name of .text.exit section in include/linux/module.h
# --------------------------------------------
#
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Fri Oct 25 10:20:05 2002
+++ b/include/linux/module.h	Fri Oct 25 10:20:05 2002
@@ -311,7 +311,7 @@
  */
 #define MODULE_GENERIC_TABLE(gtype,name) \
 static const struct gtype##_id * __module_##gtype##_table \
-  __attribute__ ((unused, __section__(".data.exit"))) = name
+  __attribute__ ((unused, __section__(".exit.data"))) = name
 
 #ifndef __GENKSYMS__
 
