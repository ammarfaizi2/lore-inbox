Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130219AbRANIiP>; Sun, 14 Jan 2001 03:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130747AbRANIiF>; Sun, 14 Jan 2001 03:38:05 -0500
Received: from smtp-rt-8.wanadoo.fr ([193.252.19.51]:16257 "EHLO
	lantana.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130219AbRANIhz>; Sun, 14 Jan 2001 03:37:55 -0500
Message-ID: <3A616513.C235B8E5@wanadoo.fr>
Date: Sun, 14 Jan 2001 09:36:35 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.0-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-ac9 Pentium-III not stable
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For testing, I try to bootstrap gcc. The problem
looks to be in stdin piping operation. 
------------------------------------------------------------
Jan 14 09:25:09 milou kernel: kernel BUG at page_alloc.c:73! 
Jan 14 09:25:09 milou kernel: invalid operand: 0000 
Jan 14 09:25:09 milou kernel: CPU:    0 
Jan 14 09:25:09 milou kernel: EIP:    0010:[__free_pages_ok+34/776] 
Jan 14 09:25:09 milou kernel: EFLAGS: 00010282 
Jan 14 09:25:09 milou kernel: eax: 0000001f   ebx: c142935c   ecx:
c8fdc000   edx: 00000000 
Jan 14 09:25:09 milou kernel: esi: 0000002b   edi: c29da404   ebp:
00000000   esp: c8fddefc 
Jan 14 09:25:09 milou kernel: ds: 0018   es: 0018   ss: 0018 
Jan 14 09:25:09 milou kernel: Process sh (pid: 8518, stackpage=c8fdd000) 
Jan 14 09:25:09 milou kernel: Stack: c01b86d2 c01b8880 00000049 c142935c
0000002b c29da404 c3c45084 c1044010  
Jan 14 09:25:09 milou kernel:        c01e0020 00000206 ffffffff 0000084e
c012a572 c012aa0a c142935c 0000002b  
Jan 14 09:25:09 milou kernel:        c011fa09 c142935c c9d7a9a0 c1552bc0
40017000 00035000 00417000 40417000  
Jan 14 09:25:09 milou kernel: Call Trace: [__free_pages+26/28]
[free_page_and_swap_cache+166/172] [zap_page_range+421/564]
[exit_mmap+186/276] [mmput+38/60] [do_exit+149/544] [sys_exit+14/16]  
Jan 14 09:25:09 milou kernel:        [system_call+51/56]  
Jan 14 09:25:09 milou kernel:  
Jan 14 09:25:09 milou kernel: Code: 0f 0b 83 c4 0c 83 7b 08 00 74 16 6a
4b 68 80 88 1b c0 68 d2  
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
