Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTABXlj>; Thu, 2 Jan 2003 18:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267317AbTABXlj>; Thu, 2 Jan 2003 18:41:39 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:33542 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S267315AbTABXli>;
	Thu, 2 Jan 2003 18:41:38 -0500
Date: Thu, 2 Jan 2003 15:45:41 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modutils update
Message-ID: <20030102234541.GA19053@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Update of Documentation/Changes and scripts/ver_linux to use
depmod instead of rmmod as per Rusty's suggestions.

	Would have sent this out sooner, but 'net access died...

-- DN
Daniel

diff -ur ../linux-2.5/Documentation/Changes linux-2.5/Documentation/Changes
--- ../linux-2.5/Documentation/Changes	Thu Jan  2 15:43:50 2003
+++ linux-2.5/Documentation/Changes	Thu Jan  2 15:46:37 2003
@@ -52,7 +52,7 @@
 o  Gnu make               3.78                    # make --version
 o  binutils               2.9.5.0.25              # ld -v
 o  util-linux             2.10o                   # fdformat --version
-o  module-init-tools      0.9                     # rmmod -V
+o  module-init-tools      0.9                     # depmod -V
 o  e2fsprogs              1.29                    # tune2fs
 o  jfsutils               1.0.14                  # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
diff -ur ../linux-2.5/scripts/ver_linux linux-2.5/scripts/ver_linux
--- ../linux-2.5/scripts/ver_linux	Thu Jan  2 15:44:23 2003
+++ linux-2.5/scripts/ver_linux	Thu Jan  2 15:46:42 2003
@@ -28,7 +28,7 @@
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
 
-rmmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
+depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'
