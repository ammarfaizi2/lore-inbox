Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUBWWeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUBWWeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:34:31 -0500
Received: from [204.127.202.64] ([204.127.202.64]:13819 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262053AbUBWWe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:34:29 -0500
Subject: [patch] Linux 2.6.4 requires procps 3.2
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1077567398.8121.211.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Feb 2004 15:16:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the /dev/pts filesystem uses 20-bit minor
numbers, a new procps is required. Version 3.2 will
work even if you don't upgrade glibc. Failure to
upgrade procps will leave you with a messed-up TTY
column when more than 255 or 256 PTYs are used.

http://procps.sf.net/

diff -Naurd old/Documentation/Changes new/Documentation/Changes
--- old/Documentation/Changes	2004-02-21 03:27:13.000000000 -0500
+++ new/Documentation/Changes	2004-02-23 12:33:22.000000000 -0500
@@ -62,7 +62,7 @@
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 o  nfs-utils              1.0.5                   # showmount --version
-o  procps                 3.1.13                  # ps --version
+o  procps                 3.2.0                   # ps --version
 o  oprofile               0.5.3                   # oprofiled --version
 
 Kernel compilation



