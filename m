Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbQKUWkz>; Tue, 21 Nov 2000 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbQKUWkp>; Tue, 21 Nov 2000 17:40:45 -0500
Received: from 213-120-136-183.btconnect.com ([213.120.136.183]:2564 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129996AbQKUWkh>;
	Tue, 21 Nov 2000 17:40:37 -0500
Date: Tue, 21 Nov 2000 22:12:27 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch-2.4.0-test11] show_mem() to dump free pages
Message-ID: <Pine.LNX.4.21.0011212210270.780-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

In arch/i386/mm/init.c:show_mem() we calculate the number of free pages
but don't printk it out. Therefore, we must either a) remove the variable
and the calculation or b) make use of it. I think b) is obviously better.

The patch below was tested under 2.4.0-test11.

Regards,
Tigran

--- arch/i386/mm/init.c.0	Tue Nov 21 22:00:52 2000
+++ arch/i386/mm/init.c	Tue Nov 21 22:00:36 2000
@@ -221,6 +221,7 @@
 	}
 	printk("%d pages of RAM\n", total);
 	printk("%d pages of HIGHMEM\n",highmem);
+	printk("%d free pages\n",free);
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
