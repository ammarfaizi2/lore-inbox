Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbUCHEOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 23:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbUCHEOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 23:14:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:63164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262383AbUCHEOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 23:14:14 -0500
Date: Sun, 7 Mar 2004 19:32:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: pavel@suse.cz
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] swsusp section usage
Message-Id: <20040307193244.2f005af1.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

This patch fixes init section usage in swsusp.c:
"read_suspend_image()" can be __init.

Patch is to 2.6.4-rc2.  Please apply.

--
~Randy



diffstat:=
 kernel/power/swsusp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naurp ./kernel/power/swsusp.c~swsusp_init ./kernel/power/swsusp.c
--- ./kernel/power/swsusp.c~swsusp_init	2004-03-06 20:57:10.000000000 -0800
+++ ./kernel/power/swsusp.c	2004-03-07 14:10:16.000000000 -0800
@@ -986,7 +986,7 @@ static int __init __read_suspend_image(s
 	return 0;
 }
 
-static int read_suspend_image(const char * specialfile, int noresume)
+static int __init read_suspend_image(const char * specialfile, int noresume)
 {
 	union diskpage *cur;
 	unsigned long scratch_page = 0;
