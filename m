Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUGVQ7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUGVQ7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUGVQ7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:59:53 -0400
Received: from franklin.wrl.org ([209.96.177.100]:4487 "EHLO franklin.wrl.org")
	by vger.kernel.org with ESMTP id S266813AbUGVQ7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:59:44 -0400
Date: Thu, 22 Jul 2004 12:59:42 -0400 (EDT)
From: Brett Charbeneau <brett@wrl.org>
To: linux-kernel@vger.kernel.org
Subject: Stumped about where to post an Oops!
Message-ID: <Pine.LNX.4.44.0407221254470.13628-100000@franklin.wrl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

	I'd appreciate any guidance anyone can offer me - and thanks in 
advance!
	I'm getting the oops below, which as been run through ksymoops and 
I haven't a clue where to post this and get some help.
	If you could let me know the best place to post this I'd be 
grateful - thank you!

-- 

Brett Charbeneau, Network Administrator         Tel: 757-259-7750
Williamsburg Regional Library                   FAX: 757-259-7798
7770 Croaker Road                               brett@wrl.org
Williamsburg, VA 23188-7064                     http://www.wrl.org


ksymoops 2.4.9 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /boot/System.map (specified)

Jul 21 23:20:22 franklin kernel: 1151MB HIGHMEM available.
Jul 21 23:20:22 franklin kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Jul 22 07:10:13 franklin kernel: Unable to handle kernel paging request at virtual address 00040004
Jul 22 07:10:13 franklin kernel: c0133306
Jul 22 07:10:13 franklin kernel: *pde = 00000000
Jul 22 07:10:13 franklin kernel: Oops: 0000
Jul 22 07:10:13 franklin kernel: CPU:    0
Jul 22 07:10:13 franklin kernel: EIP:    0010:[get_hash_table+118/160]    Not tainted
Jul 22 07:10:13 franklin kernel: EIP:    0010:[<c0133306>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 22 07:10:13 franklin kernel: EFLAGS: 00010206
Jul 22 07:10:13 franklin kernel: eax: c2880000   ebx: 00000005   ecx: c288fba8   edx: 00040000
Jul 22 07:10:13 franklin kernel: esi: 000947fd   edi: 00000821   ebp: e51c7e38   esp: e51c7e28
Jul 22 07:10:13 franklin kernel: ds: 0018   es: 0018   ss: 0018
Jul 22 07:10:13 franklin kernel: Process tar (pid: 6027, stackpage=e51c7000)
Jul 22 07:10:13 franklin kernel: Stack: 00003eea 00000000 00001000 00001000 e51c7e60 c013400d 00000821 000947fd 
Jul 22 07:10:13 franklin kernel:        00001000 00001000 00001000 e51c7eac c0134324 00000000 e51c7eac c0134340 
Jul 22 07:10:13 franklin kernel:        ea63c5e4 ea63c5e4 cc1d1000 e51c7e88 00001000 00000f16 00000000 ea63c5e4 
Jul 22 07:10:13 franklin kernel: Call Trace:    [unmap_underlying_metadata+29/112] [__block_prepare_write+212/704] [__block_prepare_write+240/704] [block_prepare_write+36/112] [ext2_get_block+0/1056]
Jul 22 07:10:13 franklin kernel: Call Trace:    [<c013400d>] [<c0134324>] [<c0134340>] [<c0134bf4>] [<c0167fb0>]
Jul 22 07:10:13 franklin kernel:   [<c01229e4>] [<c012566d>] [<c0167fb0>] [<c0125b46>] [<c0131d88>] [<c0106d93>]
Jul 22 07:10:13 franklin kernel: Code: 39 72 04 89 d1 75 f3 0f b7 42 08 3b 45 10 75 ea 66 39 7a 0c 


>>EIP; c0133306 <get_hash_table+76/a0>   <=====

>>eax; c2880000 <_end+2563ac4/384f6ac4>
>>ecx; c288fba8 <_end+257366c/384f6ac4>
>>ebp; e51c7e38 <_end+24eab8fc/384f6ac4>
>>esp; e51c7e28 <_end+24eab8ec/384f6ac4>

Trace; c013400d <unmap_underlying_metadata+1d/70>
Trace; c0134324 <__block_prepare_write+d4/2c0>
Trace; c0134340 <__block_prepare_write+f0/2c0>
Trace; c0134bf4 <block_prepare_write+24/70>
Trace; c0167fb0 <ext2_get_block+0/420>
Trace; c01229e4 <add_to_page_cache_unique+94/a0>
Trace; c012566d <do_generic_file_write+23d/440>
Trace; c0167fb0 <ext2_get_block+0/420>
Trace; c0125b46 <generic_file_write+f6/120>
Trace; c0131d88 <sys_write+98/f0>
Trace; c0106d93 <system_call+33/38>

Code;  c0133306 <get_hash_table+76/a0>
00000000 <_EIP>:
Code;  c0133306 <get_hash_table+76/a0>   <=====
   0:   39 72 04                  cmp    %esi,0x4(%edx)   <=====
Code;  c0133309 <get_hash_table+79/a0>
   3:   89 d1                     mov    %edx,%ecx
Code;  c013330b <get_hash_table+7b/a0>
   5:   75 f3                     jne    fffffffa <_EIP+0xfffffffa> c0133300 <get_hash_table+70/a0>
Code;  c013330d <get_hash_table+7d/a0>
   7:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  c0133311 <get_hash_table+81/a0>
   b:   3b 45 10                  cmp    0x10(%ebp),%eax
Code;  c0133314 <get_hash_table+84/a0>
   e:   75 ea                     jne    fffffffa <_EIP+0xfffffffa> c0133300 <get_hash_table+70/a0>
Code;  c0133316 <get_hash_table+86/a0>
  10:   66 39 7a 0c               cmp    %di,0xc(%edx)

Jul 22 07:23:01 franklin kernel: Unable to handle kernel paging request at virtual address 00040004
Jul 22 07:23:01 franklin kernel: c0133306
Jul 22 07:23:01 franklin kernel: *pde = 00000000
Jul 22 07:23:01 franklin kernel: Oops: 0000
Jul 22 07:23:01 franklin kernel: CPU:    0
Jul 22 07:23:01 franklin kernel: EIP:    0010:[get_hash_table+118/160]    Not tainted
Jul 22 07:23:01 franklin kernel: EIP:    0010:[<c0133306>]    Not tainted
Jul 22 07:23:01 franklin kernel: EFLAGS: 00010206
Jul 22 07:23:01 franklin kernel: eax: c2880000   ebx: 00000005   ecx: c288fba8   edx: 00040000
Jul 22 07:23:01 franklin kernel: esi: 00054c66   edi: 00000812   ebp: df013ba0   esp: df013b90
Jul 22 07:23:01 franklin kernel: ds: 0018   es: 0018   ss: 0018
Jul 22 07:23:01 franklin kernel: Process rm (pid: 6170, stackpage=df013000)
Jul 22 07:23:01 franklin kernel: Stack: 00003eea 00054c66 e5d16e08 d3eebf6c df013c00 c0158774 00000812 00054c66 
Jul 22 07:23:01 franklin kernel:        00001000 df013bf0 c015f533 d3eebf6c cff1b4cc 00000000 00000000 00000000 
Jul 22 07:23:01 franklin kernel:        f6faa4bc df013be4 c0164df4 c281bb50 000000f0 f7779c50 f7779c50 df013c14 
Jul 22 07:23:01 franklin kernel: Call Trace:    [ext3_clear_blocks+244/304] [do_get_write_access+1219/1264] [journal_alloc_journal_head+20/112] [journal_get_write_access+63/96] [ext3_free_data+240/336]
Jul 22 07:23:01 franklin kernel: Call Trace:    [<c0158774>] [<c015f533>] [<c0164df4>] [<c015f59f>] [<c01588a0>]
Jul 22 07:23:01 franklin kernel:   [<c012b283>] [<c0158b03>] [<c010fd76>] [<c0132b4f>] [<c0133bd0>] [<c01589d4>]
Jul 22 07:23:01 franklin kernel:   [<c010fd76>] [<c0132b4f>] [<c0133bd0>] [<c01589d4>] [<c01588a0>] [<c015fb30>]
Jul 22 07:23:01 franklin kernel:   [<c0158e12>] [<c0164cb7>] [<c015eaec>] [<c015ec04>] [<c0156a87>] [<c0156be4>]
Jul 22 07:23:01 franklin kernel:   [<c015fee1>] [<c0156b40>] [<c0145820>] [<c01439ee>] [<c013cca1>] [<c013bda0>]
Jul 22 07:23:01 franklin kernel:   [<c013cd66>] [<c0106d93>]
Jul 22 07:23:01 franklin kernel: Code: 39 72 04 89 d1 75 f3 0f b7 42 08 3b 45 10 75 ea 66 39 7a 0c 


>>EIP; c0133306 <get_hash_table+76/a0>   <=====

>>eax; c2880000 <_end+2563ac4/384f6ac4>
>>ecx; c288fba8 <_end+257366c/384f6ac4>
>>ebp; df013ba0 <_end+1ecf7664/384f6ac4>
>>esp; df013b90 <_end+1ecf7654/384f6ac4>

Trace; c0158774 <ext3_clear_blocks+f4/130>
Trace; c015f533 <do_get_write_access+4c3/4f0>
Trace; c0164df4 <journal_alloc_journal_head+14/70>
Trace; c015f59f <journal_get_write_access+3f/60>
Trace; c01588a0 <ext3_free_data+f0/150>
Trace; c012b283 <__alloc_pages+73/2b0>
Trace; c0158b03 <ext3_free_branches+203/210>
Trace; c010fd76 <schedule+306/330>
Trace; c0132b4f <__wait_on_buffer+7f/90>
Trace; c0133bd0 <bread+50/80>
Trace; c01589d4 <ext3_free_branches+d4/210>
Trace; c010fd76 <schedule+306/330>
Trace; c0132b4f <__wait_on_buffer+7f/90>
Trace; c0133bd0 <bread+50/80>
Trace; c01589d4 <ext3_free_branches+d4/210>
Trace; c01588a0 <ext3_free_data+f0/150>
Trace; c015fb30 <journal_dirty_metadata+150/170>
Trace; c0158e12 <ext3_truncate+302/3f0>
Trace; c0164cb7 <__jbd_kmalloc+17/70>
Trace; c015eaec <start_this_handle+11c/160>
Trace; c015ec04 <journal_start+84/b0>
Trace; c0156a87 <start_transaction+57/90>
Trace; c0156be4 <ext3_delete_inode+a4/120>
Trace; c015fee1 <journal_stop+1b1/1c0>
Trace; c0156b40 <ext3_delete_inode+0/120>
Trace; c0145820 <iput+c0/210>
Trace; c01439ee <d_delete+4e/80>
Trace; c013cca1 <vfs_unlink+121/160>
Trace; c013bda0 <lookup_hash+70/a0>
Trace; c013cd66 <sys_unlink+86/f0>
Trace; c0106d93 <system_call+33/38>

Code;  c0133306 <get_hash_table+76/a0>
00000000 <_EIP>:
Code;  c0133306 <get_hash_table+76/a0>   <=====
   0:   39 72 04                  cmp    %esi,0x4(%edx)   <=====
Code;  c0133309 <get_hash_table+79/a0>
   3:   89 d1                     mov    %edx,%ecx
Code;  c013330b <get_hash_table+7b/a0>
   5:   75 f3                     jne    fffffffa <_EIP+0xfffffffa> c0133300 <get_hash_table+70/a0>
Code;  c013330d <get_hash_table+7d/a0>
   7:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  c0133311 <get_hash_table+81/a0>
   b:   3b 45 10                  cmp    0x10(%ebp),%eax
Code;  c0133314 <get_hash_table+84/a0>
   e:   75 ea                     jne    fffffffa <_EIP+0xfffffffa> c0133300 <get_hash_table+70/a0>
Code;  c0133316 <get_hash_table+86/a0>
  10:   66 39 7a 0c               cmp    %di,0xc(%edx)

Jul 22 10:10:01 franklin kernel:  <1>Unable to handle kernel paging request at virtual address 00040004
Jul 22 10:10:01 franklin kernel: c0133306
Jul 22 10:10:01 franklin kernel: *pde = 00000000
Jul 22 10:10:01 franklin kernel: Oops: 0000
Jul 22 10:10:01 franklin kernel: CPU:    0
Jul 22 10:10:01 franklin kernel: EIP:    0010:[get_hash_table+118/160]    Not tainted
Jul 22 10:10:01 franklin kernel: EIP:    0010:[<c0133306>]    Not tainted
Jul 22 10:10:01 franklin kernel: EFLAGS: 00010206
Jul 22 10:10:01 franklin kernel: eax: c2880000   ebx: 00000005   ecx: c288fba8   edx: 00040000
Jul 22 10:10:01 franklin kernel: esi: 000957fd   edi: 00000821   ebp: f0ae9e38   esp: f0ae9e28
Jul 22 10:10:01 franklin kernel: ds: 0018   es: 0018   ss: 0018
Jul 22 10:10:01 franklin kernel: Process tar (pid: 10862, stackpage=f0ae9000)
Jul 22 10:10:01 franklin kernel: Stack: 00003eea 00000000 00001000 00001000 f0ae9e60 c013400d 00000821 000957fd 
Jul 22 10:10:01 franklin kernel:        00001000 00001000 00001000 f0ae9eac c0134324 00000000 f0ae9eac c0134340 
Jul 22 10:10:01 franklin kernel:        f63d6e24 f63d6e24 ff9af000 f0ae9e88 00001000 00000f22 00000000 f63d6e24 
Jul 22 10:10:01 franklin kernel: Call Trace:    [unmap_underlying_metadata+29/112] [__block_prepare_write+212/704] [__block_prepare_write+240/704] [block_prepare_write+36/112] [ext2_get_block+0/1056]
Jul 22 10:10:01 franklin kernel: Call Trace:    [<c013400d>] [<c0134324>] [<c0134340>] [<c0134bf4>] [<c0167fb0>]
Jul 22 10:10:01 franklin kernel:   [<c01229e4>] [<c012566d>] [<c0167fb0>] [<c0125b46>] [<c0131d88>] [<c010839c>]
Jul 22 10:10:01 franklin kernel:   [<c0106d93>]
Jul 22 10:10:01 franklin kernel: Code: 39 72 04 89 d1 75 f3 0f b7 42 08 3b 45 10 75 ea 66 39 7a 0c 


>>EIP; c0133306 <get_hash_table+76/a0>   <=====

>>eax; c2880000 <_end+2563ac4/384f6ac4>
>>ecx; c288fba8 <_end+257366c/384f6ac4>
>>ebp; f0ae9e38 <_end+307cd8fc/384f6ac4>
>>esp; f0ae9e28 <_end+307cd8ec/384f6ac4>

Trace; c013400d <unmap_underlying_metadata+1d/70>
Trace; c0134324 <__block_prepare_write+d4/2c0>
Trace; c0134340 <__block_prepare_write+f0/2c0>
Trace; c0134bf4 <block_prepare_write+24/70>
Trace; c0167fb0 <ext2_get_block+0/420>
Trace; c01229e4 <add_to_page_cache_unique+94/a0>
Trace; c012566d <do_generic_file_write+23d/440>
Trace; c0167fb0 <ext2_get_block+0/420>
Trace; c0125b46 <generic_file_write+f6/120>
Trace; c0131d88 <sys_write+98/f0>
Trace; c010839c <do_IRQ+cc/e0>
Trace; c0106d93 <system_call+33/38>

Code;  c0133306 <get_hash_table+76/a0>
00000000 <_EIP>:
Code;  c0133306 <get_hash_table+76/a0>   <=====
   0:   39 72 04                  cmp    %esi,0x4(%edx)   <=====
Code;  c0133309 <get_hash_table+79/a0>
   3:   89 d1                     mov    %edx,%ecx
Code;  c013330b <get_hash_table+7b/a0>
   5:   75 f3                     jne    fffffffa <_EIP+0xfffffffa> c0133300 <get_hash_table+70/a0>
Code;  c013330d <get_hash_table+7d/a0>
   7:   0f b7 42 08               movzwl 0x8(%edx),%eax
Code;  c0133311 <get_hash_table+81/a0>
   b:   3b 45 10                  cmp    0x10(%ebp),%eax
Code;  c0133314 <get_hash_table+84/a0>
   e:   75 ea                     jne    fffffffa <_EIP+0xfffffffa> c0133300 <get_hash_table+70/a0>
Code;  c0133316 <get_hash_table+86/a0>
  10:   66 39 7a 0c               cmp    %di,0xc(%edx)



