Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbQLRLEM>; Mon, 18 Dec 2000 06:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130839AbQLRLED>; Mon, 18 Dec 2000 06:04:03 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:19722 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S130247AbQLRLDx>;
	Mon, 18 Dec 2000 06:03:53 -0500
Date: Mon, 18 Dec 2000 02:33:25 -0800 (PST)
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] export submit_bh
Message-ID: <Pine.LNX.4.10.10012180228210.30931-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

Following patch against test13pre3 will export submit_bh, which reiserfs
needs to work as a module.  Seems like others would need it too...

-chris

--- linux-test13-3/kernel/ksyms.c.1	Tue Dec 19 05:08:37 2000
+++ linux-test13-3/kernel/ksyms.c	Tue Dec 19 05:05:07 2000
@@ -188,6 +189,7 @@
 EXPORT_SYMBOL(__brelse);
 EXPORT_SYMBOL(__bforget);
 EXPORT_SYMBOL(ll_rw_block);
+EXPORT_SYMBOL(submit_bh);
 EXPORT_SYMBOL(__wait_on_buffer);
 EXPORT_SYMBOL(___wait_on_page);
 EXPORT_SYMBOL(block_write_full_page);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
