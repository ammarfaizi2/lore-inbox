Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129873AbQKXRGO>; Fri, 24 Nov 2000 12:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129716AbQKXRGE>; Fri, 24 Nov 2000 12:06:04 -0500
Received: from porsta.cs.Helsinki.FI ([128.214.48.124]:22552 "EHLO
        porsta.cs.Helsinki.FI") by vger.kernel.org with ESMTP
        id <S129325AbQKXRFx>; Fri, 24 Nov 2000 12:05:53 -0500
Date: Fri, 24 Nov 2000 18:35:39 +0200 (EET)
From: Samuli Kaski <samkaski@cs.Helsinki.FI>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test10 FAT oops
Message-ID: <Pine.LNX.4.21.0011241831560.15790-100000@melkki.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had at least 2 similar (maybe even identic) oopses with 2.3/2.4
kernels in the past. Either there is still something wrong with FAT or
it's my hardware. Nevertheless, here it is.

	Samuli

Nov 24 18:30:37 vortex kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010 
Nov 24 18:30:37 vortex kernel:  printing eip: 
Nov 24 18:30:37 vortex kernel: c01599b0 
Nov 24 18:30:37 vortex kernel: *pde = 00000000 
Nov 24 18:30:37 vortex kernel: Oops: 0002 
Nov 24 18:30:37 vortex kernel: CPU:    1 
Nov 24 18:30:37 vortex kernel: EIP:    0010:[fat_cache_add+148/176] 
Nov 24 18:30:37 vortex kernel: EFLAGS: 00010246 
Nov 24 18:30:37 vortex kernel: eax: 00000000   ebx: 00021fdb   ecx: 00000000   edx: c02ac878 
Nov 24 18:30:37 vortex kernel: esi: 00021da4   edi: c3eba080   ebp: 00000235   esp: c1a67e04 
Nov 24 18:30:37 vortex kernel: ds: 0018   es: 0018   ss: 0018 
Nov 24 18:30:37 vortex kernel: Process ncftp (pid: 10416, stackpage=c1a67000) 
Nov 24 18:30:37 vortex kernel: Stack: 00000235 c3eba080 c7af2a00 00021fdb 034b0235 c015dcf6 c3eba080 00000235  
Nov 24 18:30:37 vortex kernel:        00021fdb 00000000 000011a8 c3eba080 c0d36300 0017bb36 00000008 00021fda  
Nov 24 18:30:37 vortex kernel:        ffffffff c015b6e5 c3eba080 c015b654 00000200 00000235 c1a67ea8 00000008  
Nov 24 18:30:37 vortex kernel: Call Trace: [fat_add_cluster+438/484] [fat_get_block+145/232] [fat_get_block+0/232] [__block_prepare_write+245/576] [cont_prepare_write+371/524] [fat_get_block+0/232] [fat_prepare_write+38/44]  
Nov 24 18:30:37 vortex kernel:        [fat_get_block+0/232] [generic_file_write+749/1060] [default_fat_file_write+34/88] [fat_file_write+45/52] [sys_write+142/196] [system_call+51/56] [startup_32+43/204]  
Nov 24 18:30:37 vortex kernel: Code: c7 41 10 00 00 00 00 a1 e0 c7 2a c0 89 42 10 89 15 e0 c7 2a  
Nov 24 18:30:37 vortex kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010 
Nov 24 18:30:37 vortex kernel:  printing eip: 
Nov 24 18:30:37 vortex kernel: c01599b0 
Nov 24 18:30:37 vortex kernel: *pde = 00000000 
Nov 24 18:30:37 vortex kernel: Oops: 0002 
Nov 24 18:30:37 vortex kernel: CPU:    0 
Nov 24 18:30:37 vortex kernel: EIP:    0010:[fat_cache_add+148/176] 
Nov 24 18:30:37 vortex kernel: EFLAGS: 00010246 
Nov 24 18:30:37 vortex kernel: eax: 00000000   ebx: 000d1b98   ecx: 00000000   edx: c02ac878 
Nov 24 18:30:37 vortex kernel: esi: 000d1900   edi: c4d66b40   ebp: 00000297   esp: c4963dd8 
Nov 24 18:30:37 vortex kernel: ds: 0018   es: 0018   ss: 0018 
Nov 24 18:30:37 vortex kernel: Process mxaudio (pid: 10379, stackpage=c4963000) 
Nov 24 18:30:37 vortex kernel: Stack: 00000297 c4d66b40 00000297 c0369ba0 034b0297 c0159ab0 c4d66b40 00000297  
Nov 24 18:30:37 vortex kernel:        000d1b98 c7af2a9c 00000001 00000297 000d1b98 c0159b4b c4d66b40 00000297  
Nov 24 18:30:37 vortex kernel:        c4d66b40 000014b9 c4d66b40 00000008 c015948b c4d66b40 000014b9 c015b66e  
Nov 24 18:30:37 vortex kernel: Call Trace: [fat_get_cluster+140/164] [default_fat_bmap+131/164] [fat_bmap+27/32] [fat_get_block+26/232] [fat_get_block+0/232] [block_read_full_page+308/616] [__alloc_pages_limit+124/176]  
Nov 24 18:30:37 vortex kernel:        [add_to_page_cache_unique+291/308] [fat_readpage+15/20] [fat_get_block+0/232] [generic_file_readahead+598/832] [do_generic_file_read+568/1344] [generic_file_read+99/128] [file_read_actor+0/84] [fat_file_read+45/52]  
Nov 24 18:30:37 vortex kernel:        [sys_read+146/200] [system_call+51/56]  
Nov 24 18:30:37 vortex kernel: Code: c7 41 10 00 00 00 00 a1 e0 c7 2a c0 89 42 10 89 15 e0 c7 2a

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
