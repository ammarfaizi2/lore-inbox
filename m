Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266258AbUHQORv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUHQORv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHQOPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:15:03 -0400
Received: from pop.gmx.de ([213.165.64.20]:16611 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268280AbUHQOL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:11:56 -0400
X-Authenticated: #1725425
Date: Tue, 17 Aug 2004 16:27:35 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: [PATCH] update defines in cdrom.h
Message-Id: <20040817162735.23acde4b.Ballarin.Marc@gmx.de>
In-Reply-To: <1092661385.20528.25.camel@localhost.localdomain>
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds four commands defined in mmc4 spec to cdrom.h. I used the
official names and simply added the GPCMD prefix. This is a prerequisite
for improving filtering.

Some commands that are used in software but not mentioned in specs are
still missing.

Marc


--- linux-2.6.8/include/linux/cdrom.h.orig	2004-08-14 12:26:34.000000000 +0200
+++ linux-2.6.8/include/linux/cdrom.h	2004-08-17 16:14:41.580823560 +0200
@@ -481,4 +481,8 @@
 #define GPCMD_WRITE_10			    0x2a
 #define GPCMD_WRITE_AND_VERIFY_10	    0x2e
+#define GPCMD_READ_BUFFER_CAPACITY	    0x5C
+#define GPCMD_SEND_CUE			    0x5D
+#define GPCMD_ERASE			    0x2C
+#define GPCMD_SEND_DVD_STRUCTURE	    0xBF
 /* This is listed as optional in ATAPI 2.6, but is (curiously) 
  * missing from Mt. Fuji, Table 57.  It _is_ mentioned in Mt. Fuji
