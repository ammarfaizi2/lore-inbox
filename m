Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319210AbSIDQPH>; Wed, 4 Sep 2002 12:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319211AbSIDQPH>; Wed, 4 Sep 2002 12:15:07 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:57566 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S319210AbSIDQPH>; Wed, 4 Sep 2002 12:15:07 -0400
Subject: [PATCH] 2.4.20-pre5-ac2 update ver_linux yet again (jfsutils
	version reporting)
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 04 Sep 2002 10:16:26 -0600
Message-Id: <1031156186.2799.19.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds jfsutils to the list of support software checked by the
ver_linux script.  As with older versions of e2fsprogs, this requires
comma snippage. This check is done in the same order as the list in
Documentation/Changes and was tested with jfsutils 1.0.21.

Steven


--- linux-2.4.20-pre5-ac2/scripts/ver_linux.ac2	Wed Sep  4 09:48:19 2002
+++ linux-2.4.20-pre5-ac2/scripts/ver_linux	Wed Sep  4 10:09:52 2002
@@ -33,6 +33,9 @@
 tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
 'NR==1 {print "e2fsprogs             ", $2}'
 
+fsck.jfs -V 2>&1 | grep version | sed 's/,//' |  awk \
+'NR==1 {print "jfsutils              ", $3}'
+
 reiserfsck -V 2>&1 | grep reiserfsprogs | awk \
 'NR==1{print "reiserfsprogs         ", $NF}'
 


