Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUCJGMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 01:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCJGMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 01:12:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:43409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262269AbUCJGMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 01:12:18 -0500
Date: Tue, 9 Mar 2004 22:07:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Cciss-discuss@lists.sourceforge.net, axboe@suse.de, support@compaq.com
Subject: [PATCH] cciss: init section fix
Message-Id: <20040309220724.20ad588e.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


V: linux-264-rc2
D: cciss_scsi_detect() can be called after init (for TAPE support);

diffstat:=
 drivers/block/cciss_scsi.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naurp ./drivers/block/cciss_scsi.c~cciss_init ./drivers/block/cciss_scsi.c
--- ./drivers/block/cciss_scsi.c~cciss_init	2004-02-17 19:57:20.000000000 -0800
+++ ./drivers/block/cciss_scsi.c	2004-03-07 14:38:47.000000000 -0800
@@ -693,7 +693,7 @@ complete_scsi_command( CommandList_struc
 	scsi_cmd_free(ctlr, cp);
 }
 
-static int __init 
+static int
 cciss_scsi_detect(int ctlr)
 {
 	struct Scsi_Host *sh;


--
~Randy
