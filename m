Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272272AbRIETLe>; Wed, 5 Sep 2001 15:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272268AbRIETLY>; Wed, 5 Sep 2001 15:11:24 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:1033 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S272270AbRIETLH>;
	Wed, 5 Sep 2001 15:11:07 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 19:44:29 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: Patch: fix error in building procfs-guide
Message-ID: <Pine.LNX.4.21.0109051939150.20371-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch fixes errors which cause building kernel docs to fail
(e.g. tulip user guide doesn't get built). Created on 2.4.7 while I was on
holiday, applies cleanly to 2.4.9-ac6 and 2.4.10-pre4.

diff -urN linux-2.4.7/Documentation/DocBook/procfs-guide.tmpl altered-2.4.7/Documentation/DocBook/procfs-guide.tmpl
--- linux-2.4.7/Documentation/DocBook/procfs-guide.tmpl	Sat Jul 21 22:47:23 2001
+++ altered-2.4.7/Documentation/DocBook/procfs-guide.tmpl	Wed Aug 22 20:39:44 2001
@@ -207,7 +207,7 @@
         will return <constant>NULL</constant>. <xref
         linkend="userland"> describes how to do something useful with
         regular files.
-      <para>
+      </para>
 
       <para>
         Note that it is specifically supported that you can pass a
@@ -577,7 +577,7 @@
         the <structfield>owner</structfield> field in the
         <structname>struct proc_dir_entry</structname> to
         <constant>THIS_MODULE</constant>.
-      <para>
+      </para>
 
       <programlisting>
 struct proc_dir_entry* entry;

Ken
-- 
         If a six turned out to be nine, I don't mind.

         Home page : http://www.kenmoffat.uklinux.net

