Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVCCKtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVCCKtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVCCKsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:48:04 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:10420 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261540AbVCCKnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:43:03 -0500
Date: Thu, 3 Mar 2005 11:42:51 +0100
Message-Id: <200503031042.j23AgpXi020764@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 12/16] DocBook: fix XML in templates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: fix XML in templates
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2036  -> 1.2037 
#	Documentation/DocBook/sis900.tmpl	1.6     -> 1.7    
#	Documentation/DocBook/mtdnand.tmpl	1.2     -> 1.3    
#	Documentation/DocBook/procfs-guide.tmpl	1.6     -> 1.7    
#	Documentation/DocBook/librs.tmpl	1.3     -> 1.4    
#	Documentation/DocBook/videobook.tmpl	1.8     -> 1.9    
#	Documentation/DocBook/via-audio.tmpl	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/02/09	tali@admingilde.org	1.2037
# DocBook: fix XML in templates
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/librs.tmpl b/Documentation/DocBook/librs.tmpl
--- a/Documentation/DocBook/librs.tmpl	Thu Mar  3 11:42:55 2005
+++ b/Documentation/DocBook/librs.tmpl	Thu Mar  3 11:42:55 2005
@@ -225,7 +225,7 @@
 .....
 /* Decode 512 byte in data8.*/
 numerr = decode_rs8 (rs_decoder, NULL, NULL, 512, syn, 0, errpos, 0, corr);
-for (i = 0; i < numerr; i++) {
+for (i = 0; i &lt; numerr; i++) {
 	do_error_correction_in_your_buffer(errpos[i], corr[i]);
 }
 		</programlisting>
diff -Nru a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
--- a/Documentation/DocBook/mtdnand.tmpl	Thu Mar  3 11:42:55 2005
+++ b/Documentation/DocBook/mtdnand.tmpl	Thu Mar  3 11:42:55 2005
@@ -240,9 +240,9 @@
 	struct nand_chip *this = (struct nand_chip *) mtd->priv;
 	switch(cmd){
 		case NAND_CTL_SETCLE: this->IO_ADDR_W |= CLE_ADRR_BIT;  break;
-		case NAND_CTL_CLRCLE: this->IO_ADDR_W &= ~CLE_ADRR_BIT; break;
+		case NAND_CTL_CLRCLE: this->IO_ADDR_W &amp;= ~CLE_ADRR_BIT; break;
 		case NAND_CTL_SETALE: this->IO_ADDR_W |= ALE_ADRR_BIT;  break;
-		case NAND_CTL_CLRALE: this->IO_ADDR_W &= ~ALE_ADRR_BIT; break;
+		case NAND_CTL_CLRALE: this->IO_ADDR_W &amp;= ~ALE_ADRR_BIT; break;
 	}
 }
 		</programlisting>
@@ -393,7 +393,7 @@
 	/* Deselect all chips, set all nCE pins high */
 	GPIO(BOARD_NAND_NCE) |= 0xff;	
 	if (chip >= 0)
-		GPIO(BOARD_NAND_NCE) &= ~ (1 << chip);	
+		GPIO(BOARD_NAND_NCE) &amp;= ~ (1 &lt;&lt; chip);	
 }
 		</programlisting>
 		<para>
@@ -407,8 +407,8 @@
 	struct nand_chip *this = (struct nand_chip *) mtd->priv;
 	
 	/* Deselect all chips */
-	this->IO_ADDR_R &= ~BOARD_NAND_ADDR_MASK;
-	this->IO_ADDR_W &= ~BOARD_NAND_ADDR_MASK;
+	this->IO_ADDR_R &amp;= ~BOARD_NAND_ADDR_MASK;
+	this->IO_ADDR_W &amp;= ~BOARD_NAND_ADDR_MASK;
 	switch (chip) {
 	case 0:
 		this->IO_ADDR_R |= BOARD_NAND_ADDR_CHIP0;
diff -Nru a/Documentation/DocBook/procfs-guide.tmpl b/Documentation/DocBook/procfs-guide.tmpl
--- a/Documentation/DocBook/procfs-guide.tmpl	Thu Mar  3 11:42:55 2005
+++ b/Documentation/DocBook/procfs-guide.tmpl	Thu Mar  3 11:42:55 2005
@@ -1,7 +1,7 @@
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
 	"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" [
-<!ENTITY procfsexample SYSTEM "procfs_example.sgml">
+<!ENTITY procfsexample SYSTEM "procfs_example.xml">
 ]>
 
 <book id="LKProcfsGuide">
diff -Nru a/Documentation/DocBook/sis900.tmpl b/Documentation/DocBook/sis900.tmpl
--- a/Documentation/DocBook/sis900.tmpl	Thu Mar  3 11:42:55 2005
+++ b/Documentation/DocBook/sis900.tmpl	Thu Mar  3 11:42:55 2005
@@ -20,7 +20,7 @@
 </author>
 </authorgroup>
 
-<edition>Document Revision: 0.3 for SiS900 driver v1.06 & v1.07</edition>
+<edition>Document Revision: 0.3 for SiS900 driver v1.06 &amp; v1.07</edition>
 <pubdate>November 16, 2000</pubdate>
 
 <copyright>
diff -Nru a/Documentation/DocBook/via-audio.tmpl b/Documentation/DocBook/via-audio.tmpl
--- a/Documentation/DocBook/via-audio.tmpl	Thu Mar  3 11:42:55 2005
+++ b/Documentation/DocBook/via-audio.tmpl	Thu Mar  3 11:42:55 2005
@@ -264,7 +264,7 @@
 
    <listitem>
     <para>
-    Fixes for the SPEED, STEREO, CHANNELS, FMT ioctls when in read &
+    Fixes for the SPEED, STEREO, CHANNELS, FMT ioctls when in read &amp;
     write mode (Rui Sousa)
     </para>
    </listitem>
diff -Nru a/Documentation/DocBook/videobook.tmpl b/Documentation/DocBook/videobook.tmpl
--- a/Documentation/DocBook/videobook.tmpl	Thu Mar  3 11:42:55 2005
+++ b/Documentation/DocBook/videobook.tmpl	Thu Mar  3 11:42:55 2005
@@ -523,7 +523,7 @@
                         if(copy_from_user(arg, &amp;freq, 
                                 sizeof(unsigned long))!=0)
                                 return -EFAULT;
-                        if(hardware_set_freq(freq)<0)
+                        if(hardware_set_freq(freq)&lt;0)
                                 return -EINVAL;
                         current_freq = freq;
                         return 0;
@@ -1552,9 +1552,9 @@
                         struct video_window v;
                         if(copy_from_user(&amp;v, arg, sizeof(v)))
                                 return -EFAULT;
-                        if(v.width > 640 || v.height > 480)
+                        if(v.width &gt; 640 || v.height &gt; 480)
                                 return -EINVAL;
-                        if(v.width < 16 || v.height < 16)
+                        if(v.width &lt; 16 || v.height &lt; 16)
                                 return -EINVAL;
                         hardware_set_key(v.chromakey);
                         hardware_set_window(v);
