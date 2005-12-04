Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVLEAB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVLEAB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 19:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVLEAB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 19:01:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932279AbVLEAB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 19:01:28 -0500
Date: Sun, 4 Dec 2005 15:57:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com, wfg@mail.ustc.edu.cn
Subject: Re: [PATCH 02/16] radixtree: sync with mainline
Message-Id: <20051204155750.3972c3df.akpm@osdl.org>
In-Reply-To: <20051203071625.331743000@localhost.localdomain>
References: <20051203071444.260068000@localhost.localdomain>
	<20051203071625.331743000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> [PATCH] radix-tree: Remove unnecessary indirections and clean up code
> 
>  is only partially merged into -mm tree. This patch completes it.

md: autorun ...               
md: ... autorun DONE.
Unable to handle kernel paging request at virtual address 8000003c
 printing eip:                                                    
c013e16f      
*pde = 00000000
Oops: 0000 [#1]
SMP            
Modules linked in:
CPU:    1         
EIP:    0060:[<c013e16f>]    Not tainted VLI
EFLAGS: 00010086   (2.6.15-rc5-mm1)         
EIP is at find_get_page+0x2e/0x4e   
eax: 8000003c   ebx: cff867e8   ecx: 8000003c   edx: 8000003c
esi: cff867e8   edi: 00000000   ebp: cffafd44   esp: cffafd38
ds: 007b   es: 007b   ss: 0068                               
Process swapper (pid: 1, threadinfo=cffae000 task=cffa1a90)
Stack: <0>cff867ec 00000000 00042454 cffafdcc c013e5e7 cff867e8 00000000 cfcc62 
       <0>00000000 00000001 cffafdcc c02406b3 00001000 00000000 00042454 000000 
       <0>ffffffff 00000001 00000001 00000000 00000042 cff8673c 00000000 000000 
Call Trace:                                                                    
 [<c0103b3b>] show_stack+0x8c/0xa2
 [<c0103cd0>] show_registers+0x15d/0x1c5
 [<c0103ed2>] die+0x10e/0x196           
 [<c048073a>] do_page_fault+0x34c/0x6b5
 [<c01037ef>] error_code+0x4f/0x54     
 [<c013e5e7>] do_generic_mapping_read+0x13a/0x4ad
 [<c013ec14>] __generic_file_aio_read+0x1c8/0x20c
 [<c013ed63>] generic_file_read+0xa2/0xbb        
 [<c015ec94>] vfs_read+0xd4/0x19e        
 [<c015f02e>] sys_read+0x4b/0x75 
 [<c060f118>] identify_ramdisk_image+0x78/0x1ca
 [<c060f2e3>] rd_load_image+0x79/0x317         
 [<c06119a9>] initrd_load+0x43/0x7d   
 [<c060ef4b>] prepare_namespace+0x3d/0x131
 [<c01003f1>] init+0xe6/0x1d9             
 [<c01010dd>] kernel_thread_helper+0x5/0xb
Code: 83 ec 0c 89 5d fc 8b 5d 08 8d 43 10 e8 05 1d 34 00 8b 45 0c 89 44 24 04 8 
 <0>Kernel panic - not syncing: Attempted to kill init!                        
