Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263303AbSJCMy4>; Thu, 3 Oct 2002 08:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbSJCMy4>; Thu, 3 Oct 2002 08:54:56 -0400
Received: from tbaytel3.tbaytel.net ([206.47.150.179]:15765 "EHLO tbaytel.net")
	by vger.kernel.org with ESMTP id <S263303AbSJCMyz> convert rfc822-to-8bit;
	Thu, 3 Oct 2002 08:54:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
Organization: Garrett Kajmowicz
To: linux-kernel@vger.kernel.org
Subject: [PATCH, TRIVIAL] 2.4.20-pre8, Intermezzo configuration
Date: Thu, 3 Oct 2002 08:56:05 -0400
User-Agent: KMail/1.4.1
Cc: braam@clusterfs.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210030856.05809.gkajmowi@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to push the config line for the Intermezzo filesystem into a 
seperate file.  Please see:
http://garrett.dyndns.biz
for why I would like this done.

Thank you.

-	Garrett Kajmowicz
gkajmowi@tbaytel.net

diff -Nru linux-2.4.19old/fs/Config.in linux-2.4.19new/fs/Config.in
--- linux-2.4.19old/fs/Config.in        2002-10-01 08:22:21.000000000 -0400
+++ linux-2.4.19new/fs/Config.in        2002-10-03 08:50:32.000000000 -0400
@@ -99,7 +99,7 @@
    comment 'Network File Systems'

    dep_tristate 'Coda file system support (advanced network fs)' 
CONFIG_CODA_FS $CONFIG_INET
-   dep_tristate 'InterMezzo file system support (replicating fs) 
(EXPERIMENTAL)' CONFIG_INTERMEZZO_FS $CONFIG_INET $CONFIG_EXPERIMENTAL
+   source fs/intermezzo/Config.in
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS 
$CONFIG_IP_PNP
diff -Nru linux-2.4.19old/fs/intermezzo/Config.in 
linux-2.4.19new/fs/intermezzo/Config.in
--- linux-2.4.19old/fs/intermezzo/Config.in     1969-12-31 19:00:00.000000000 
-0500
+++ linux-2.4.19new/fs/intermezzo/Config.in     2002-10-03 08:52:13.000000000 
-0400
@@ -0,0 +1 @@
+dep_tristate 'InterMezzo file system support (replicating fs) (EXPERIMENTAL)' 
CONFIG_INTERMEZZO_FS $CONFIG_INET $CONFIG_EXPERIMENTAL
