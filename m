Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756179AbWKRDXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179AbWKRDXQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 22:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbWKRDXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 22:23:16 -0500
Received: from raven.upol.cz ([158.194.120.4]:14074 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1756179AbWKRDXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 22:23:15 -0500
Date: Sat, 18 Nov 2006 03:30:15 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch] smbfs: is obsolete, please use CIFS
Message-ID: <20061118033015.GA14191@flower.upol.cz>
References: <867ixyvum6.fsf@gere.msconsult.dk> <slrnelofru.7lr.olecom@flower.upol.cz> <20061117145342.f566a62a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117145342.f566a62a.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Oleg Verych <olecom@flower.upol.cz>
--

    Note, some white spaces were killed.

--- linux-2.6-mm/fs/Kconfig~smbfs-is-obsolete+emacs-visiting	2006-11-15 08:58:53.097867250 +0000
+++ linux-2.6-mm/fs/Kconfig	2006-11-18 03:22:24.055118500 +0000
@@ -1200,5 +1200,5 @@
 	help
 	  If you say Y here, you can use the 'debug' mount option to enable
-	  debugging output from the driver. 
+	  debugging output from the driver.
 
 config BFS_FS
@@ -1326,5 +1326,5 @@
 	  the kernel or by users (see the attr(5) manual page, or visit
 	  <http://acl.bestbits.at/> for details).
-	  
+
 	  If unsure, say N.
 
@@ -1337,8 +1337,8 @@
 	  Posix Access Control Lists (ACLs) support permissions for users and
 	  groups beyond the owner/group/world scheme.
-	  
+
 	  To learn more about Access Control Lists, visit the Posix ACLs for
 	  Linux website <http://acl.bestbits.at/>.
-	  
+
 	  If you don't know what Access Control Lists are, say N
 
@@ -1352,5 +1352,5 @@
 	  enables an extended attribute handler for file security
 	  labels in the jffs2 filesystem.
-	  
+
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
@@ -1852,5 +1852,5 @@
 
 config SMB_FS
-	tristate "SMB file system support (to mount Windows shares etc.)"
+	tristate "SMB file system support (OBSOLETE, please use CIFS)"
 	depends on INET
 	select NLS
@@ -1875,6 +1875,6 @@
 	  Macs is on the WWW at <http://www.eats.com/linux_mac_win.html>.
 
-	  To compile the SMB support as a module, choose M here: the module will
-	  be called smbfs.  Most people say N, however.
+	  To compile the SMB support as a module, choose M here:
+	  the module will be called smbfs.  Most people say N, however.
 
 config SMB_NLS_DEFAULT
@@ -1908,28 +1908,28 @@
 
 config CIFS
-	tristate "CIFS support (advanced network filesystem for Samba, Window and other CIFS compliant servers)"
+	tristate "CIFS support (advanced network filesystem, SMBFS successor)"
 	depends on INET
 	select NLS
 	help
 	  This is the client VFS module for the Common Internet File System
-	  (CIFS) protocol which is the successor to the Server Message Block 
+	  (CIFS) protocol which is the successor to the Server Message Block
 	  (SMB) protocol, the native file sharing mechanism for most early
-	  PC operating systems.  The CIFS protocol is fully supported by 
-	  file servers such as Windows 2000 (including Windows 2003, NT 4  
+	  PC operating systems.  The CIFS protocol is fully supported by
+	  file servers such as Windows 2000 (including Windows 2003, NT 4
 	  and Windows XP) as well by Samba (which provides excellent CIFS
 	  server support for Linux and many other operating systems). Limited
-	  support for Windows ME and similar servers is provided as well. 
+	  support for Windows ME and similar servers is provided as well.
 	  You must use the smbfs client filesystem to access older SMB servers
 	  such as OS/2 and DOS.
 
 	  The intent of the cifs module is to provide an advanced
-	  network file system client for mounting to CIFS compliant servers, 
+	  network file system client for mounting to CIFS compliant servers,
 	  including support for dfs (hierarchical name space), secure per-user
 	  session establishment, safe distributed caching (oplock), optional
-	  packet signing, Unicode and other internationalization improvements, 
+	  packet signing, Unicode and other internationalization improvements,
 	  and optional Winbind (nsswitch) integration. You do not need to enable
 	  cifs if running only a (Samba) server. It is possible to enable both
 	  smbfs and cifs (e.g. if you are using CIFS for accessing Windows 2003
-	  and Samba 3 servers, and smbfs for accessing old servers). If you need 
+	  and Samba 3 servers, and smbfs for accessing old servers). If you need
 	  to mount to Samba or Windows from this machine, say Y.
 
@@ -1969,5 +1969,5 @@
 	  mounts may be less secure than mounts using NTLM or more recent
 	  security mechanisms if you are on a public network.  Unless you
-	  have a need to access old SMB servers (and are on a private 
+	  have a need to access old SMB servers (and are on a private
 	  network) you probably want to say N.  Even if this support
 	  is enabled in the kernel build, they will not be used
@@ -1975,8 +1975,8 @@
 	  can be set to required (or optional) either in
 	  /proc/fs/cifs (see fs/cifs/README for more detail) or via an
-	  option on the mount command. This support is disabled by 
+	  option on the mount command. This support is disabled by
 	  default in order to reduce the possibility of a downgrade
 	  attack.
- 
+
 	  If unsure, say N.
 
@@ -2019,5 +2019,5 @@
 	   option can be turned off unless you are debugging
 	   cifs problems.  If unsure, say N.
-	   
+
 config CIFS_EXPERIMENTAL
 	  bool "CIFS Experimental Features (EXPERIMENTAL)"
@@ -2101,5 +2101,5 @@
 	  clients. If you really need to run the old Coda userspace
 	  cache manager then say Y.
-	  
+
 	  For most cases you probably want to say N.
 
