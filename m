Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270402AbTGNMBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270565AbTGNMBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:01:35 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35204
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270402AbTGNMBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:01:30 -0400
Date: Mon, 14 Jul 2003 13:15:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141215.h6ECFUXQ030836@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: add qdio options
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/arch/s390/config.in linux.22-pre5-ac1/arch/s390/config.in
--- linux.22-pre5/arch/s390/config.in	2003-07-14 12:27:33.000000000 +0100
+++ linux.22-pre5-ac1/arch/s390/config.in	2003-07-07 16:05:42.000000000 +0100
@@ -39,6 +39,10 @@
 bool 'Fast IRQ handling' CONFIG_FAST_IRQ
 bool 'Process warning machine checks' CONFIG_MACHCHK_WARNING
 bool 'Use chscs for Common I/O' CONFIG_CHSC
+tristate 'QDIO support' CONFIG_QDIO
+if [ "$CONFIG_QDIO" != "n" ]; then
+  bool '   Performance statistics in /proc' CONFIG_QDIO_PERF_STATS
+fi
 bool 'Builtin IPL record support' CONFIG_IPL
 if [ "$CONFIG_IPL" = "y" ]; then
   choice 'IPL method generated into head.S' \
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/arch/s390x/config.in linux.22-pre5-ac1/arch/s390x/config.in
--- linux.22-pre5/arch/s390x/config.in	2003-07-14 12:27:33.000000000 +0100
+++ linux.22-pre5-ac1/arch/s390x/config.in	2003-07-07 16:05:42.000000000 +0100
@@ -42,6 +42,10 @@
 bool 'Fast IRQ handling' CONFIG_FAST_IRQ
 bool 'Process warning machine checks' CONFIG_MACHCHK_WARNING
 bool 'Use chscs for Common I/O' CONFIG_CHSC
+tristate 'QDIO support' CONFIG_QDIO
+if [ "$CONFIG_QDIO" != "n" ]; then
+  bool '   Performance statistics in /proc' CONFIG_QDIO_PERF_STATS
+fi
 bool 'Builtin IPL record support' CONFIG_IPL
 if [ "$CONFIG_IPL" = "y" ]; then
   choice 'IPL method generated into head.S' \
