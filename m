Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264099AbTEaBSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 21:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbTEaBSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 21:18:47 -0400
Received: from bleh.org ([130.94.186.96]:28947 "HELO bleh.org")
	by vger.kernel.org with SMTP id S264099AbTEaBSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 21:18:44 -0400
Message-ID: <3ED80613.3030309@bleh.org>
Date: Fri, 30 May 2003 21:32:03 -0400
From: Nadeem Riaz <nadeem@bleh.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel v2.4.18 , Rh7.3, Any thoughts?

May 29 17:30:42 master kernel: Unable to handle kernel paging request at 
virtual address 6e72010f
May 29 17:30:42 master kernel:  printing eip:
May 29 17:30:42 master kernel: c0138289
May 29 17:30:42 master kernel: *pde = 00000000
May 29 17:30:42 master kernel: Oops: 0000
May 29 17:30:42 master kernel: nfs ns83820 nfsd lockd sunrpc autofs 
bcm5700 iptable_mangle iptable_nat ip_con
May 29 17:30:42 master kernel: CPU:    1
May 29 17:30:42 master kernel: EIP:    0010:[<c0138289>]    Not tainted
May 29 17:30:42 master kernel: EFLAGS: 00010a03
May 29 17:30:42 master kernel:
May 29 17:30:42 master kernel: EIP is at rmqueue [kernel] 0x1f9 
(2.4.18-5custom)
May 29 17:30:42 master kernel: eax: c033bb88   ebx: c1d701a0   ecx: 
00038000   edx: 001eb710
May 29 17:30:42 master kernel: esi: 6e72002f   edi: 00007f80   ebp: 
c1000030   esp: f4befe10
May 29 17:30:42 master kernel: ds: 0018   es: 0018   ss: 0018
May 29 17:30:42 master kernel: Process tput (pid: 3744, stackpage=f4bef000)
May 29 17:30:42 master kernel: Stack: 00038000 000056e2 00000282 
00000000 c033bb88 c033bb88 c033bc90 00000000
May 29 17:30:42 master kernel:        00000100 c01384d2 00000001 
c033bc8c 000001d2 00104025 c1003910 f4e1b050
May 29 17:30:42 master kernel:        f5b41f00 c012b348 f703f2f4 
f64e14c0 f5b5ee00 00000000 00000001 f5b41f00
May 29 17:30:42 master kernel: Call Trace: [<c01384d2>] __alloc_pages 
[kernel] 0x72
May 29 17:30:42 master kernel: [<c012b348>] do_anonymous_page [kernel] 0x58
May 29 17:30:42 master kernel: [<c012b457>] do_no_page [kernel] 0x37
May 29 17:30:42 master kernel: [<c012b704>] handle_mm_fault [kernel] 0xd4
May 29 17:30:42 master kernel: [<c012be74>] __vma_link [kernel] 0x64
May 29 17:30:42 master kernel: [<c0115ffd>] do_page_fault [kernel] 0x12d
May 29 17:30:42 master kernel: [<c010dd07>] sys_mmap2 [kernel] 0x67
May 29 17:30:42 master kernel: [<c0115ed0>] do_page_fault [kernel] 0x0
May 29 17:30:42 master kernel: [<c0108d4c>] error_code [kernel] 0x34
May 29 17:30:42 master kernel:
May 29 17:30:42 master kernel:
May 29 17:30:42 master kernel: Code: 8b be e0 00 00 00 89 c8 c1 fa 03 01 
f8 39 c2 73 11 39 ca 72
May 29 17:30:43 master kernel:  ------------[ cut here ]------------
May 29 17:30:43 master kernel: kernel BUG at page_alloc.c:238!
May 29 17:30:43 master kernel: invalid operand: 0000
May 29 17:30:43 master kernel: nfs ns83820 nfsd lockd sunrpc autofs 
bcm5700 iptable_mangle iptable_nat ip_con
May 29 17:30:43 master kernel: CPU:    1
May 29 17:30:43 master kernel: EIP:    0010:[<c01382ba>]    Not tainted
May 29 17:30:43 master kernel: EFLAGS: 00010286
May 29 17:30:43 master kernel:
May 29 17:30:43 master kernel: EIP is at rmqueue [kernel] 0x22a 
(2.4.18-5custom)
May 29 17:30:43 master kernel: eax: 00000020   ebx: c1d68de8   ecx: 
c033a4e0   edx: 000055c8
May 29 17:30:43 master kernel: esi: dfdfdfdf   edi: 00000000   ebp: 
c1000030   esp: f4be7e08
May 29 17:30:43 master kernel: ds: 0018   es: 0018   ss: 0018
May 29 17:30:43 master kernel: Process slide (pid: 3751, stackpage=f4be7000)
May 29 17:30:43 master kernel: Stack: c027926e 000000ee 00038000 
000054d1 00000282 00000000 c033bb88 c033bb88
May 29 17:30:43 master kernel:        c033bc90 00000000 00000100 
c01384d2 00000001 c033bc8c 000001d2 00104025
May 29 17:30:43 master kernel:        c1003910 f74b4ff0 f75b1140 
c012b348 f703f2f4 f6f92d40 c033bc90 c1df8818
May 29 17:30:43 master kernel: Call Trace: [<c01384d2>] __alloc_pages 
[kernel] 0x72
May 29 17:30:43 master kernel: [<c012b348>] do_anonymous_page [kernel] 0x58
May 29 17:30:43 master kernel: [<c012b457>] do_no_page [kernel] 0x37
May 29 17:30:43 master kernel: [<c012b704>] handle_mm_fault [kernel] 0xd4
May 29 17:30:43 master kernel: [<c014b618>] link_path_walk [kernel] 0x938
May 29 17:30:43 master kernel: [<c0157151>] update_atime [kernel] 0x51
May 29 17:30:43 master kernel: [<c0115ffd>] do_page_fault [kernel] 0x12d
May 29 17:30:43 master kernel: [<c014c215>] open_namei [kernel] 0x315
May 29 17:30:43 master kernel: [<c013f9f6>] dentry_open [kernel] 0xe6
May 29 17:30:43 master kernel: [<c013f8fd>] filp_open [kernel] 0x4d
May 29 17:30:43 master kernel: [<c014a78e>] getname [kernel] 0x5e
May 29 17:30:43 master kernel: [<c0115ed0>] do_page_fault [kernel] 0x0
May 29 17:30:43 master kernel: [<c0108d4c>] error_code [kernel] 0x34
May 29 17:30:43 master kernel:
May 29 17:30:43 master kernel:
May 29 17:30:43 master kernel: Code: 0f 0b 58 5a 8b 43 18 83 e0 40 74 1a 
68 ef 00 00 00 68 6e 92



