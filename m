Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbTBQVX5>; Mon, 17 Feb 2003 16:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTBQVX5>; Mon, 17 Feb 2003 16:23:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35280 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267535AbTBQVX4>;
	Mon, 17 Feb 2003 16:23:56 -0500
Date: Mon, 17 Feb 2003 13:30:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mingo@redhat.com, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix Documentation/cli-sti-removal.txt thinko
Message-Id: <20030217133028.4fd505f2.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please apply to 2.5.61.

The 3 lines being deleted are repeated from above (in same file).
I pulled the 2 lines being added from an earlier version of the patch.

--
~Randy


patch_name:	cli-fixdoc.patch
patch_version:	2003-02-17.13:15:29
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	correct cli-sti-removal.txt cut-n-paste'os
product:	Linux
product_versions: linux-2561
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 cli-sti-removal.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff -Naur ./Documentation/cli-sti-removal.txt%CLI ./Documentation/cli-sti-removal.txt
--- ./Documentation/cli-sti-removal.txt%CLI	Fri Feb 14 15:51:21 2003
+++ ./Documentation/cli-sti-removal.txt	Mon Feb 17 13:15:09 2003
@@ -121,9 +121,8 @@
 
 another related change is that synchronize_irq() now takes a parameter:
 synchronize_irq(irq). This change too has the purpose of making SMP
-to make the transition easier, we've still kept the cli(), sti(),
-save_flags() and restore_flags() macros defined on UP systems - but
-their usage will be phased out until the 2.6 kernel is released.
+synchronization more lightweight - this way you can wait for your own
+interrupt handler to finish, no need to wait for other IRQ sources.
 
 
 why were these changes done? The main reason was the architectural burden
