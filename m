Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264888AbUEQEmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbUEQEmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 00:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUEQEmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 00:42:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:1157 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264888AbUEQEmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 00:42:15 -0400
Date: Sun, 16 May 2004 21:39:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] correct ps2esdi module parm name
Message-Id: <20040516213940.0e381f88.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


// Linux 2.6.6
// module parameter name is incorrect (looks like a thinko);
// module cannot be loaded as is;

There is no global "track" variable, and just above the patched area is:

static int cyl[MAX_HD] = {-1,-1};
static int head[MAX_HD] = {-1, -1};
static int sect[MAX_HD] = {-1, -1};


diffstat:=
 drivers/block/ps2esdi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naurp ./drivers/block/ps2esdi.c~orig ./drivers/block/ps2esdi.c
--- ./drivers/block/ps2esdi.c~orig	2004-05-09 19:31:56.000000000 -0700
+++ ./drivers/block/ps2esdi.c	2004-05-16 21:19:49.000000000 -0700
@@ -180,7 +180,7 @@ static int sect[MAX_HD] = {-1, -1};
 MODULE_PARM(tp720esdi, "i");
 MODULE_PARM(cyl, "i");
 MODULE_PARM(head, "i");
-MODULE_PARM(track, "i");
+MODULE_PARM(sect, "i");
 MODULE_LICENSE("GPL");
 
 int init_module(void) {


--
~Randy
