Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269574AbTGJRtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 13:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269575AbTGJRtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 13:49:21 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:50925 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S269574AbTGJRtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 13:49:09 -0400
Subject: [PATCH] 2.5.74-bk update Documentation/Changes, scripts/ver_linux
	for quota-tools.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1057860171.8754.166.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 10 Jul 2003 12:02:51 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent discussion regarding versions of quota support in 2.4 and 2.5
brought to my attention that quota-tools is not mentioned in 
Documentation/Changes or checked in scripts/ver_linux.

Here is a patch for 2.5. A similar patch for 2.4 is on the way.

Steven

diff -ur 2.5-bk-current/Documentation/Changes 2.5-linux/Documentation/Changes
--- 2.5-bk-current/Documentation/Changes	Thu Jul 10 09:53:20 2003
+++ 2.5-linux/Documentation/Changes	Thu Jul 10 11:23:51 2003
@@ -58,6 +58,7 @@
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
 o  xfsprogs               2.1.0                   # xfs_db -V
 o  pcmcia-cs              3.1.21                  # cardmgr -V
+o  quota-tools            3.09                    # quota -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 o  procps                 2.0.9                   # ps --version
@@ -194,6 +195,14 @@
 kernel source.  Pay attention when you recompile your kernel ;-).
 Also, be sure to upgrade to the latest pcmcia-cs release.
 
+Quota-tools
+-----------
+
+Support for 32 bit uid's and gid's is required if you want to use
+the newer version 2 quota format.  Quota-tools version 3.07 and
+newer has this support.  Use the recommended version or newer
+from the table above.
+
 Intel IA32 microcode
 --------------------
 
@@ -328,6 +337,10 @@
 ---------
 o  <ftp://pcmcia-cs.sourceforge.net/pub/pcmcia-cs/pcmcia-cs-3.1.21.tar.gz>
 
+Quota-tools
+----------
+o  <http://sourceforge.net/projects/linuxquota/>
+
 Jade
 ----
 o  <ftp://ftp.jclark.com/pub/jade/jade-1.2.1.tar.gz>
diff -ur 2.5-bk-current/scripts/ver_linux 2.5-linux/scripts/ver_linux
--- 2.5-bk-current/scripts/ver_linux	Thu Jul 10 09:53:01 2003
+++ 2.5-linux/scripts/ver_linux	Thu Jul 10 10:20:44 2003
@@ -45,6 +45,9 @@
 cardmgr -V 2>&1| grep version | awk \
 'NR==1{print "pcmcia-cs             ", $3}'
 
+quota -V 2>&1 | grep version | awk \
+'NR==1{print "quota-tools           ", $NF}'
+
 pppd --version 2>&1| grep version | awk \
 'NR==1{print "PPP                   ", $3}'
 



