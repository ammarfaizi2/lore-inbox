Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVCDRRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVCDRRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVCDRNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:13:43 -0500
Received: from monster.roma2.infn.it ([141.108.255.100]:6540 "EHLO
	monster.roma2.infn.it") by vger.kernel.org with ESMTP
	id S262979AbVCDRLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:11:15 -0500
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ltspcfg: fixed suse-debian default DM check
Date: Fri, 4 Mar 2005 18:11:07 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_raJKCXU8QaYfs2X"
Message-Id: <200503041811.07832.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_raJKCXU8QaYfs2X
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the attached patch fixes  wrong "default DM" check in debian and suse
plz apply
-- 
<?php echo '       Emiliano `AlberT` Gabrielli       ',"\n",
           '  E-Mail: AlberT_AT_SuperAlberT_it  ',"\n",
           '  Web:    http://SuperAlberT.it  ',"\n",
'  IRC:    #php,#AES azzurra.com ',"\n",'ICQ: 158591185'; ?>

--Boundary-00=_raJKCXU8QaYfs2X
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ltspcfg_suse-deb-dmfile-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ltspcfg_suse-deb-dmfile-fix.patch"

--- /usr/sbin/ltspcfg.orig	2005-03-04 17:00:45.521484448 +0100
+++ /usr/sbin/ltspcfg	2005-03-04 18:22:33.776316296 +0100
@@ -2253,8 +2253,8 @@
     #
     # If it doesn't look like a SuSE system, then exit this routine
     #
-    if ( ! -f "/etc/sysconfig/displaymanager"
-    ||   ! -f "/etc/rc.d/xdm" ){
+    if ( ! -f "/etc/sysconfig/displaymanager" and
+         ! -f "/etc/rc.d/xdm" ){
       return "";
     }
 
@@ -2327,8 +2327,8 @@
     #
     # If it doesn't look like a Debian system, then exit this routine
     #
-    if ( ! -f "/etc/X11/default-display-manager"
-    ||   ! -f "/etc/init.d/xdm" ){
+    if ( ! -f "/etc/X11/default-display-manager" and
+         ! -f "/etc/init.d/xdm" ){
       return "";
     }
 

--Boundary-00=_raJKCXU8QaYfs2X--
