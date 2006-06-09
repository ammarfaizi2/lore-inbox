Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWFIDuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWFIDuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWFIDuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:50:24 -0400
Received: from xenotime.net ([66.160.160.81]:61639 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965123AbWFIDuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:50:23 -0400
Date: Thu, 8 Jun 2006 20:42:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: heiko@lotte.sax.de, axboe@suse.de, akpm <akpm@osdl.org>
Subject: [PATCH] cdrom/mcdx: section fixes
Message-Id: <20060608204239.e0abf5cb.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Priority: not critical.
Make __mcdx_init() __init and static.  Saves a little memory.

Fix section mismatch warning and make the function static while there:
WARNING: drivers/cdrom/mcdx.o - Section mismatch: reference to .init.text: from .text between 'init_module' (at offset 0x8be) and 'mcdx_transfer'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/cdrom/mcdx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-rc6.orig/drivers/cdrom/mcdx.c
+++ linux-2617-rc6/drivers/cdrom/mcdx.c
@@ -1006,7 +1006,7 @@ static int mcdx_talk(struct s_drive_stuf
 
 /* MODULE STUFF ***********************************************************/
 
-int __mcdx_init(void)
+static int __init __mcdx_init(void)
 {
 	int i;
 	int drives = 0;


---
