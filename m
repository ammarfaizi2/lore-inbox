Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUCCWhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUCCWhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:37:20 -0500
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:11020 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S261222AbUCCWhI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:37:08 -0500
Subject: Re: 2.6.4-rc1-mm2
From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040302201536.52c4e467.akpm@osdl.org>
References: <20040302201536.52c4e467.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1078351164.17019.57.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Mar 2004 19:33:59 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Em Qua, 2004-03-03 às 01:15, Andrew Morton escreveu:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/

I got this:

Unable to handle kernel paging request at virtual address c1d61f70
printing eip:
c0211f8f
*pde = 00006063
*pte = 01d61000
Oops: 0000 [#1]
DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[__make_request+671/1184]    Not tainted VLI
EFLAGS: 00010093
EIP is at __make_request+0x29f/0x4a0
eax: c1d61f60   ebx: c1d61f60   ecx: 00000008   edx: 00000100
esi: c79dadf8   edi: 00000000   ebp: c137dc7c   esp: c137dc4c
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 7, threadinfo=c137c000 task=c1393a50)
Stack: 00000000 0000000c 0422361f 00000000 00000008 00000008 00000001 c1d61f60 
       c3e047a8 c79dadf8 00000008 c3e047a8 c137dcd0 c0212284 c012f702 00000200 
       c116bbd4 00000010 c137dcb8 c137dcf0 c012f702 03700008 00000000 c1393a50 
Call Trace:
 [generic_make_request+244/368] generic_make_request+0xf4/0x170
 [mempool_alloc+98/256] mempool_alloc+0x62/0x100
 [mempool_alloc+98/256] mempool_alloc+0x62/0x100
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [submit_bio+88/240] submit_bio+0x58/0xf0
 [kernel_map_pages+22/80] kernel_map_pages+0x16/0x50
 [bio_alloc+195/416] bio_alloc+0xc3/0x1a0
 [__block_write_full_page+380/880] __block_write_full_page+0x17c/0x370
 [blkdev_get_block+0/80] blkdev_get_block+0x0/0x50
 [block_write_full_page+179/192] block_write_full_page+0xb3/0xc0
 [blkdev_get_block+0/80] blkdev_get_block+0x0/0x50
 [shrink_list+949/1184] shrink_list+0x3b5/0x4a0
 [shrink_cache+334/848] shrink_cache+0x14e/0x350
 [shrink_slab+127/368] shrink_slab+0x7f/0x170
 [shrink_zone+149/160] shrink_zone+0x95/0xa0
 [balance_pgdat+430/512] balance_pgdat+0x1ae/0x200
 [kswapd+226/240] kswapd+0xe2/0xf0
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
 [kswapd+0/240] kswapd+0x0/0xf0
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

 Code: 01 00 00 39 86 48 01 00 00 74 25 8b 86 90 00 00 00 8b 96 8c 00 00 00 01 d0 3b 86 e8 00 00 00 74 15 0f b7 96 90 01 00 00 8b 45 ec <39> 50 10 74 06 fb e9 6c fe ff ff 8b 86 50 01 00 00 a8 04 75 f0 

 I was opening the w3m program, tried to reproduce without success.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

