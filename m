Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbQLGXLo>; Thu, 7 Dec 2000 18:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131195AbQLGXLf>; Thu, 7 Dec 2000 18:11:35 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:36809 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S130548AbQLGXLX>; Thu, 7 Dec 2000 18:11:23 -0500
From: Florian Schmitt <florian@galois.de>
Date: Thu, 7 Dec 2000 23:36:23 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.0test12-pre5+reiserfs+crypto
MIME-Version: 1.0
Message-Id: <00120723362300.00357@phoenix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the following oops while doing a "find -name" and playing mp3s on 
my SB live:

Dec  7 14:16:50 phoenix kernel: Unable to handle kernel paging request at 
virtual address 00010f08
Dec  7 14:16:50 phoenix kernel:  printing eip:
Dec  7 14:16:50 phoenix kernel: d084a3e5
Dec  7 14:16:50 phoenix kernel: *pde = 00000000
Dec  7 14:16:50 phoenix kernel: Oops: 0000
Dec  7 14:16:50 phoenix kernel: CPU:    0
Dec  7 14:16:50 phoenix kernel: EIP:    
0010:[ne2k-pci:__insmod_ne2k-pci_O/lib/modules/2.4.0-test12/kernel/drivers+-2386971/96]
Dec  7 14:16:50 phoenix kernel: EFLAGS: 00010207
Dec  7 14:16:50 phoenix kernel: eax: 00000004   ebx: 00010f00   ecx: 
00000a45   edx: d084a3e0
Dec  7 14:16:50 phoenix kernel: esi: c1176934   edi: 00000000   ebp: 
00000308   esp: c147ff8c
Dec  7 14:16:50 phoenix kernel: ds: 0018   es: 0018   ss: 0018
Dec  7 14:16:50 phoenix kernel: Process kswapd (pid: 4, 
stackpage=c147f000)
Dec  7 14:16:50 phoenix kernel: Stack: c1176918 c0129ef4 c1176918 
00010f00 00000004 00000000 00000000 00000001
Dec  7 14:16:50 phoenix kernel:        00000004 00000000 0000004e 
00000000 c012a854 00000004 00000000 00010f00
Dec  7 14:16:50 phoenix kernel:        c01e0377 c147e239 0008e000 
c012a92d 00000004 00000000 00010f00 c1449fb8
Dec  7 14:16:50 phoenix kernel: Call Trace: [rw_swap_page+148/160] 
[__get_free_pages+36/48] [stext_lock+7687/12848] [nr_free_pages+61/64] 
[Dec  7 14:16:50 phoenix kernel: Code: 8b 43 08 8b 40 10 8b 80 8c 00 00 
00 50 e8 c9 1b 01 00 53 e8 

It seems strange that the oops occured in ne2k-pci, since no network was 
connected at that time.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
