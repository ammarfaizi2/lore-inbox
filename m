Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143619AbRAHMuF>; Mon, 8 Jan 2001 07:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143610AbRAHMtz>; Mon, 8 Jan 2001 07:49:55 -0500
Received: from mail.ask.ne.jp ([203.179.96.3]:24023 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S143592AbRAHMtm>;
	Mon, 8 Jan 2001 07:49:42 -0500
Date: Mon, 8 Jan 2001 21:48:39 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.0-ac3 oneliners
Message-Id: <20010108214839.7c50eb22.bruce@ask.ne.jp>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.6; Linux 2.2.17; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

These are just a few unused variables that popped up as warnings from
2.4.0-ac3 (I've also (briefly) checked ac4, and didn't notice any changes
in there). Here's hoping that I'm not breaking something...

--
Bruce Harada
bruce@ask.ne.jp



diff -Nur linux-2.4.0-ac3/drivers/net/tulip/media.c
linux-2.4.0-ac3-bh1/drivers/net/tulip/media.c
--- linux-2.4.0-ac3/drivers/net/tulip/media.c   Tue Jan  2 02:54:07 2001
+++ linux-2.4.0-ac3-bh1/drivers/net/tulip/media.c       Mon Jan  8 21:28:50 2001
@@ -265,7 +265,6 @@
                }
                case 5: case 6: {
                        u16 setup[5];
-                       u32 csr13val, csr14val, csr15dir, csr15val;
                        for (i = 0; i < 5; i++)
                                setup[i] = get_u16(&p[i*2 + 1]);
 
diff -Nur linux-2.4.0-ac3/mm/filemap.c linux-2.4.0-ac3-bh1/mm/filemap.c
--- linux-2.4.0-ac3/mm/filemap.c        Mon Jan  8 21:19:58 2001
+++ linux-2.4.0-ac3-bh1/mm/filemap.c    Mon Jan  8 21:22:14 2001
@@ -2499,7 +2499,7 @@
        mark_inode_dirty_sync(inode);
 
        while (count) {
-               unsigned long bytes, index, offset, partial = 0;
+               unsigned long bytes, index, offset;
                char *kaddr;
                int deactivate = 1;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
