Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRIRUol>; Tue, 18 Sep 2001 16:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273911AbRIRUnm>; Tue, 18 Sep 2001 16:43:42 -0400
Received: from [194.213.32.137] ([194.213.32.137]:28420 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273910AbRIRUn1>;
	Tue, 18 Sep 2001 16:43:27 -0400
Message-ID: <20010918215356.A11789@bug.ucw.cz>
Date: Tue, 18 Sep 2001 21:53:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Inline docs for bread()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It took me quite a while to decide how to call bread correctly -- so I
added docs for it. Please apply,
								Pavel

--- clean/fs/buffer.c	Thu Aug 30 10:42:31 2001
+++ linux/fs/buffer.c	Tue Sep 18 21:52:47 2001
@@ -1226,9 +1228,13 @@
 	spin_unlock(&lru_list_lock);
 }
 
-/*
- * bread() reads a specified block and returns the buffer that contains
- * it. It returns NULL if the block was unreadable.
+/**
+ *	bread() - reads a specified block and returns the bh
+ *	@block: number of block
+ *	@size: size (in bytes) to read
+ * 
+ *	Reads a specified block, and returns buffer head that
+ *	contains it. It returns NULL if the block was unreadable.
  */
 struct buffer_head * bread(kdev_t dev, int block, int size)
 {

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
