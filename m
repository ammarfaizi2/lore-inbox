Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293699AbSCATyc>; Fri, 1 Mar 2002 14:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293682AbSCATyX>; Fri, 1 Mar 2002 14:54:23 -0500
Received: from real.realitydiluted.com ([208.242.241.164]:58048 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id <S293695AbSCATxR>; Fri, 1 Mar 2002 14:53:17 -0500
Message-ID: <3C7FEA0A.250D71DB@cotw.com>
Date: Fri, 01 Mar 2002 14:52:26 -0600
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fs/Config.in :Simple patch to require CONFIG_PROC_FS before 
 CONFIG_JFFS_PROC_FS is available.
Content-Type: multipart/mixed;
 boundary="------------774E4D92FAC92D3F4A59479A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------774E4D92FAC92D3F4A59479A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


--- fs/Config.in.old	Fri Mar  1 11:33:18 2002
+++ fs/Config.in	Fri Mar  1 11:33:25 2002
@@ -37,7 +37,7 @@
 dep_tristate 'Journalling Flash File System (JFFS) support'
CONFIG_JFFS_FS $CONFIG_MTD
 if [ "$CONFIG_JFFS_FS" = "y" -o "$CONFIG_JFFS_FS" = "m" ] ; then
    int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)'
CONFIG_JFFS_FS_VERBOSE 0
-   bool 'JFFS stats available in /proc filesystem' CONFIG_JFFS_PROC_FS
+   dep_mbool 'JFFS stats available in /proc filesystem'
CONFIG_JFFS_PROC_FS $CONFIG_PROC_FS
 fi
 dep_tristate 'Journalling Flash File System v2 (JFFS2) support'
CONFIG_JFFS2_FS $CONFIG_MTD
 if [ "$CONFIG_JFFS2_FS" = "y" -o "$CONFIG_JFFS2_FS" = "m" ] ; then


-- 
Scott A. McConnell
--------------774E4D92FAC92D3F4A59479A
Content-Type: text/plain; charset=us-ascii;
 name="Config.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Config.in.patch"

--- fs/Config.in.old	Fri Mar  1 11:33:18 2002
+++ fs/Config.in	Fri Mar  1 11:33:25 2002
@@ -37,7 +37,7 @@
 dep_tristate 'Journalling Flash File System (JFFS) support' CONFIG_JFFS_FS $CONFIG_MTD
 if [ "$CONFIG_JFFS_FS" = "y" -o "$CONFIG_JFFS_FS" = "m" ] ; then
    int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
-   bool 'JFFS stats available in /proc filesystem' CONFIG_JFFS_PROC_FS
+   dep_mbool 'JFFS stats available in /proc filesystem' CONFIG_JFFS_PROC_FS $CONFIG_PROC_FS
 fi
 dep_tristate 'Journalling Flash File System v2 (JFFS2) support' CONFIG_JFFS2_FS $CONFIG_MTD
 if [ "$CONFIG_JFFS2_FS" = "y" -o "$CONFIG_JFFS2_FS" = "m" ] ; then

--------------774E4D92FAC92D3F4A59479A--

