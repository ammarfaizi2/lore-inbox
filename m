Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUHQPDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUHQPDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUHQPDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:03:47 -0400
Received: from pop.gmx.de ([213.165.64.20]:38376 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268265AbUHQPDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:03:45 -0400
X-Authenticated: #1725425
Date: Tue, 17 Aug 2004 17:19:41 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] update + fix defines in cdrom.h
Message-Id: <20040817171941.799bd18b.Ballarin.Marc@gmx.de>
In-Reply-To: <20040817162735.23acde4b.Ballarin.Marc@gmx.de>
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
	<20040817162735.23acde4b.Ballarin.Marc@gmx.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improved version of the previous patch.
Use lower case letters + fix a real bug: SEND_DVD_STRUCTURE was defined
as 0xad, which is actually READ_DVD_STRUCTURE.
The only user is ide-cd.h, which uses it for simple information printing.

Marc

--- linux-2.6.8/include/linux/cdrom.h.orig	2004-08-14 12:26:34.000000000 +0200
+++ linux-2.6.8/include/linux/cdrom.h	2004-08-17 17:13:08.508689488 +0200
@@ -469,5 +469,5 @@
 #define GPCMD_SCAN			    0xba
 #define GPCMD_SEEK			    0x2b
-#define GPCMD_SEND_DVD_STRUCTURE	    0xad
+#define GPCMD_SEND_DVD_STRUCTURE	    0xbf
 #define GPCMD_SEND_EVENT		    0xa2
 #define GPCMD_SEND_KEY			    0xa3
@@ -481,4 +481,8 @@
 #define GPCMD_WRITE_10			    0x2a
 #define GPCMD_WRITE_AND_VERIFY_10	    0x2e
+#define GPCMD_READ_BUFFER_CAPACITY	    0x5c
+#define GPCMD_SEND_CUE			    0x5d
+#define GPCMD_ERASE			    0x2c
+#define GPCMD_READ_DVD_STRUCTURE	    0xad
 /* This is listed as optional in ATAPI 2.6, but is (curiously) 
  * missing from Mt. Fuji, Table 57.  It _is_ mentioned in Mt. Fuji
