Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbUCUKuv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 05:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUCUKuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 05:50:51 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:59356 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263634AbUCUKuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 05:50:50 -0500
Message-ID: <405D73D7.70905@t-online.de>
Date: Sun, 21 Mar 2004 11:52:07 +0100
From: Al.Simon@t-online.de (Alexander Simon)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040115
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Changing kernel uncompressing address
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: rCCN-TZAwe5cB9oXcwQU-btivQgDzB3WeJgxdhk2ZJfOMFn6MAUV87
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have an old Toshiba Satellie Pro Laptop with broken RAM.
I thought it could be no problem getting it to work with the BadRAM patch.
But first RAM Errors occur at 2M and last until 32M
Unfornately, the RAM Chips are on board, so no chance of replacing them.
When I try to load a kernel image from diskette, it unpacks the kernel 
image without errors. But when it tries to start that kernel it stops or 
reboots.
If I keep the kernel very very small, it starts, but I would have to 
exclude TCP/IP code, causing the system unusable.

After studying arch/i386/boot/compressed/head.S and misc.c of 2.4.24 for 
a long time, i found out that the kernel is uncompressed to 0x100000.
Stupidly, I'm not familiar with assembler code. So I just changed the 
0x100000 to 0xF00000 (should be 16M?!? memtest86 reported the range 
15M-18M OK, however...) in line 77 in head.S and line 309 in misc.c.
Of couse it did NOT work :[.
I would need to high loaded kernel anyway, again because of TCP/IP.

Thanks for any ideas
