Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291257AbSBLXOZ>; Tue, 12 Feb 2002 18:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291243AbSBLXOQ>; Tue, 12 Feb 2002 18:14:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2821 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291245AbSBLXN4>;
	Tue, 12 Feb 2002 18:13:56 -0500
Message-ID: <3C69A181.ECE2D3D1@zip.com.au>
Date: Tue, 12 Feb 2002 15:13:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] ext3 synchronous mount speedup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ditto.

--- linux-2.4.18-pre8/fs/ext3/inode.c	Tue Feb  5 00:33:05 2002
+++ linux-akpm/fs/ext3/inode.c	Wed Feb  6 23:40:48 2002
@@ -581,8 +581,6 @@ static int ext3_alloc_branch(handle_t *h
 			
 			parent = nr;
 		}
-		if (IS_SYNC(inode))
-			handle->h_sync = 1;
 	}
 	if (n == num)
 		return 0;

-
