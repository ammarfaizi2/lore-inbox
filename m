Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWEaIoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWEaIoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWEaIoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:44:34 -0400
Received: from fand.conysis.com ([212.34.136.14]:745 "EHLO fand.conysis.com")
	by vger.kernel.org with ESMTP id S964870AbWEaIoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:44:34 -0400
Message-ID: <447D5772.10909@ejerciciosresueltos.com>
Date: Wed, 31 May 2006 09:44:34 +0100
From: Noel <tecnico@ejerciciosresueltos.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel reports kernel bug when trying to start kaddressbook
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May 31 09:19:01 padoc kernel: [17232590.616000] ------------[ cut here 
]------------
May 31 09:19:01 padoc kernel: [17232590.616000] kernel BUG at mm/swap.c:52!
May 31 09:19:01 padoc kernel: [17232590.616000] invalid opcode: 0000 [#4]
May 31 09:19:01 padoc kernel: [17232590.616000] Modules linked in: 
usbcore autofs4 via_rhine 8139too crc32
May 31 09:19:01 padoc kernel: [17232590.616000] CPU:    0
May 31 09:19:01 padoc kernel: [17232590.616000] EIP:    
0060:[<c013d925>]    Tainted: G   M  VLI
May 31 09:19:01 padoc kernel: [17232590.616000] EFLAGS: 00210246   
(2.6.16.4+20060419.padoc.envite #1)
May 31 09:19:01 padoc kernel: [17232590.616000] EIP is at put_page+0x25/0x40
May 31 09:19:01 padoc kernel: [17232590.616000] eax: 00000002   ebx: 
cea51664   ecx: 00016325   edx: c12c64a0
May 31 09:19:01 padoc kernel: [17232590.616000] esi: 08199000   edi: 
c12c64a0   ebp: ca329e20   esp: ca329d88
May 31 09:19:01 padoc kernel: [17232590.616000] ds: 007b   es: 007b   
ss: 0068
May 31 09:19:01 padoc kernel: [17232590.616000] Process kaddressbook 
(pid: 10310, threadinfo=ca328000 task=cbc5d090)
May 31 09:19:01 padoc kernel: [17232590.616000] Stack: <0>c01424a8 
c12c64a0 08199000 16325045 16325045 fffffec1 00000000 cea48e40
May 31 09:19:01 padoc kernel: [17232590.616000]        082b0000 cea49080 
082b0000 ca329e20 c0142623 c03c5bac c4097a14 cea49080
May 31 09:19:01 padoc kernel: [17232590.616000]        08053000 082b0000 
ca329e20 00000000 082affff cea49080 cea49080 c4097a14
May 31 09:19:01 padoc kernel: [17232590.616000] Call Trace:
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c01424a8>] 
zap_pte_range+0x178/0x230
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c0142623>] 
unmap_page_range+0xc3/0x130
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c014277b>] 
unmap_vmas+0xeb/0x1a0
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c01470eb>] 
exit_mmap+0x6b/0xf0
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c011789c>] 
mmput+0x2c/0x80
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c015dafe>] 
exec_mmap+0xae/0x140
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c015e1ab>] 
flush_old_exec+0x4b/0x230
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c015da40>] 
kernel_read+0x50/0x60
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c017ca6f>] 
load_elf_binary+0x32f/0xd50
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c013ad0e>] 
__alloc_pages+0x5e/0x310
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c01c6a8c>] 
copy_from_user+0x4c/0xc0
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c015d58d>] 
copy_strings+0x1dd/0x230
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c015e5ed>] 
search_binary_handler+0x5d/0x1b0
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c015e8c0>] 
do_execve+0x180/0x200
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c0101932>] 
sys_execve+0x42/0x80
May 31 09:19:01 padoc kernel: [17232590.616000]  [<c0102bbb>] 
sysenter_past_esp+0x54/0x75
May 31 09:19:01 padoc kernel: [17232590.616000] Code: bc 27 00 00 00 00 
8b 54 24 04 8b 02 f6 c4 40 75 24 8b 42 04 40 74 14 83 42 04 ff 0f 98 c0 
84 c0 75 02 90 c3 89 d0 e9 ab 02 00 00 <0f> 0b 34 00 f9 eb 2f c0 eb e2 
eb 8f eb 0d 90 90 90 90 90 90 90
May 31 09:19:01 padoc kernel: [17232590.616000]  <6>note: 
kaddressbook[10310] exited with preempt_count 1

