Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTIWUux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 16:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTIWUux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 16:50:53 -0400
Received: from waste.org ([209.173.204.2]:42195 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262745AbTIWUuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 16:50:52 -0400
Date: Tue, 23 Sep 2003 15:50:45 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: kgdboe docs clarification
Message-ID: <20030923205045.GM32488@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make kgdboe docs somewhat clearer

 l-mpm/Documentation/i386/kgdb/kgdbeth.txt |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

diff -puN Documentation/i386/kgdb/kgdbeth.txt~kgdboe-docs Documentation/i386/kgdb/kgdbeth.txt
--- l/Documentation/i386/kgdb/kgdbeth.txt~kgdboe-docs	2003-09-23 15:01:49.000000000 -0500
+++ l-mpm/Documentation/i386/kgdb/kgdbeth.txt	2003-09-23 15:01:49.000000000 -0500
@@ -47,8 +47,17 @@ You need to use the following command-li
 
   examples:
 
-    kgdboe=7000@192.168.0.1/wlan0,7001@192.168.0.2/00:05:3C:04:47:5D
+    kgdboe=7000@192.168.0.1/eth1,7001@192.168.0.2/00:05:3C:04:47:5D
+        this machine is 192.168.0.1 on eth1
+        remote machine is 192.168.0.2 with MAC address 00:05:3C:04:47:5D
+        listen for gdb packets on port 7000
+        send unsolicited gdb packets to port 7001
+
     kgdboe=@192.168.0.1/,@192.168.0.2/
+        this machine is 192.168.0.1 on default interface eth0
+        remote machine is 192.168.0.2, use default broadcast MAC address
+        listen for gdb packets on default port 6443
+        send unsolicited gdb packets to port 6442
 
 Only packets originating from the configured HOST IP address will be
 accepted by the debugger.

_


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
