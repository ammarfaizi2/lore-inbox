Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131165AbQLFUWP>; Wed, 6 Dec 2000 15:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131162AbQLFUWF>; Wed, 6 Dec 2000 15:22:05 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:1028 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131153AbQLFUV4>; Wed, 6 Dec 2000 15:21:56 -0500
Date: Wed, 6 Dec 2000 19:51:25 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: <linux-kernel@vger.kernel.org>
Subject: fatfs BUG() in test12-pre5
Message-ID: <Pine.LNX.4.30.0012061949330.1043-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This code in fs/fat/file.c::fat_get_block() is getting triggered when I
run wine:

        if (iblock<<9 != MSDOS_I(inode)->mmu_private) {
                BUG();
                return -EIO;
        }

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
