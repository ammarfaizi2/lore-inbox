Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTAFAD7>; Sun, 5 Jan 2003 19:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTAFAD6>; Sun, 5 Jan 2003 19:03:58 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8678 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265508AbTAFAD4>;
	Sun, 5 Jan 2003 19:03:56 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 6 Jan 2003 01:12:30 +0100 (MET)
Message-Id: <UTC200301060012.h060CUg15266.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] htmldoc fix
Cc: dgilbert@interlog.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I told someone to do "make htmldocs" and just to be sure
checked myself. Below two fixes.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/DocBook/journal-api.tmpl b/Documentation/DocBook/journal-api.tmpl
--- a/Documentation/DocBook/journal-api.tmpl	Thu Nov 28 15:28:17 2002
+++ b/Documentation/DocBook/journal-api.tmpl	Mon Jan  6 00:06:57 2003
@@ -206,6 +206,7 @@
 	journal_unlock_updates() // carry on with filesystem use.
 </programlisting>
 
+<para>
 The opportunities for abuse and DOS attacks with this should be obvious,
 if you allow unprivileged userspace to trigger codepaths containing these
 calls.
@@ -250,7 +251,6 @@
    }
    journal_destroy(my_jrnl);
 </programlisting>
-</para>
 </sect1>
 
 </chapter>
diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/DocBook/scsidrivers.tmpl b/Documentation/DocBook/scsidrivers.tmpl
--- a/Documentation/DocBook/scsidrivers.tmpl	Fri Nov 22 22:40:12 2002
+++ b/Documentation/DocBook/scsidrivers.tmpl	Sun Jan  5 23:35:15 2003
@@ -52,7 +52,7 @@
   </para>
 <para>
 This document can been found in an ASCII text file in the linux kernel 
-source: <filename>drivers/scsi/scsi_mid_low_api.txt</filename> .
+source: <filename>Documentation/scsi/scsi_mid_low_api.txt</filename> .
 It currently hold a little more information than this document. The
 <filename>drivers/scsi/hosts.h</filename> and <filename>
 drivers/scsi/scsi.h</filename> headers contain descriptions of members
@@ -107,7 +107,7 @@
 
   <chapter id="intfunctions">
      <title>Interface Functions</title>
-!Edrivers/scsi/scsi_mid_low_api.txt
+!EDocumentation/scsi/scsi_mid_low_api.txt
   </chapter>
 
   <chapter id="locks">
