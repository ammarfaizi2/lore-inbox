Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271002AbTHFS4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271003AbTHFS4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:56:21 -0400
Received: from eurogra4543-gw.clients.easynet.fr ([212.180.52.85]:23169 "HELO
	hubert.heliogroup.fr") by vger.kernel.org with SMTP id S271002AbTHFS4I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:56:08 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Cc: Herbert =?ISO-8859-1?Q?=20P=F6tzl?= <herbert@13thfloor.at>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.22rc1 bug report
Date: Wed, 06 Aug 2003 18:51:35 GMT
Message-ID: <03B7B2011@hubert.heliogroup.fr>
X-Mailer: Pliant 85
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>
> Can you please run ksymoops to convert the oops output in human readable 
> format ?

Unable to handle kernel NULL pointer dereference at virtual address 0000002c
c01800d6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01800d6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000006   ebx: 00000246   ecx: 00000024   edx: 00000006
esi: 0000001c   edi: 0000001c   ebp: c72fbb50   esp: c72fbb0c
ds: 0018   es: 0018   ss: 0018
Process cardctl (pid: 40, stackpage=c72fb000)
Stack: 00000024 c733a000 d0a88866 0000001c 00000024 ffffffff 00000000 00000006 
       c0121908 00000006 c01f21e0 000001ff 00000001 00000000 c733a08c 00000000 
       00000286 c72fbb90 d0a88a51 c733a000 00000006 000001d2 cfe9a3a0 00000002 
Call Trace:    [<d0a88866>] [<c0121908>] [<d0a88a51>] [<d0a84b22>] [<c0121908>]
  [<c0121908>] [<c012a0a6>] [<c0120eed>] [<d0a84f3e>] [<c0121908>] [<d0a84d5b>]
  [<c01213c2>] [<c012190e>] [<d0a83b5f>] [<d0a9bc33>] [<c01c9c26>] [<c0121908>]
  [<c0147644>] [<c01239b3>] [<c012a2b0>] [<c012a0a6>] [<c0120db6>] [<c0120e03>]
  [<c0120f9e>] [<c013085e>] [<c0130707>] [<c013077a>] [<c013122f>] [<c0124494>]
  [<c01244c1>] [<c0131850>] [<c014f2c9>] [<c014fe61>] [<c015265d>] [<c013917f>]
  [<c013b197>] [<c0106be3>]
Code: 8b 46 10 8b 50 30 8b 44 24 14 50 51 56 8b 42 14 ff d0 83 c4 


>>EIP; c01800d6 <pci_write_config_dword+12/34>   <=====

>>ebp; c72fbb50 <_end+70bc784/10841c34>
>>esp; c72fbb0c <_end+70bc740/10841c34>

Trace; d0a88866 <[pcmcia_core]cb_setup_cis_mem+d6/210>
Trace; c0121908 <do_mmap_pgoff+408/4cc>
Trace; d0a88a51 <[pcmcia_core]read_cb_mem+b1/1b8>
Trace; d0a84b22 <[pcmcia_core]read_cis_cache+10e/18c>
Trace; c0121908 <do_mmap_pgoff+408/4cc>
Trace; c0121908 <do_mmap_pgoff+408/4cc>
Trace; c012a0a6 <_alloc_pages+16/18>
Trace; c0120eed <do_no_page+11d/17c>
Trace; d0a84f3e <[pcmcia_core]get_next_tuple+7e/240>
Trace; c0121908 <do_mmap_pgoff+408/4cc>
Trace; d0a84d5b <[pcmcia_core]get_first_tuple+10f/118>
Trace; c01213c2 <__vma_link+62/b0>
Trace; c012190e <do_mmap_pgoff+40e/4cc>
Trace; d0a83b5f <[pcmcia_core]CardServices+1c3/884>
Trace; d0a9bc33 <[ds]ds_ioctl+4f3/7d8>
Trace; c01c9c26 <clear_user+2e/40>
Trace; c0121908 <do_mmap_pgoff+408/4cc>
Trace; c0147644 <load_elf_binary+0/ae8>
Trace; c01239b3 <do_generic_file_read+3f7/404>
Trace; c012a2b0 <__alloc_pages+40/160>
Trace; c012a0a6 <_alloc_pages+16/18>
Trace; c0120db6 <do_anonymous_page+ba/d4>
Trace; c0120e03 <do_no_page+33/17c>
Trace; c0120f9e <handle_mm_fault+52/b0>
Trace; c013085e <__refile_buffer+56/5c>
Trace; c0130707 <balance_dirty_state+f/50>
Trace; c013077a <balance_dirty+6/24>
Trace; c013122f <__block_commit_write+af/cc>
Trace; c0124494 <filemap_nopage+bc/1f8>
Trace; c01244c1 <filemap_nopage+e9/1f8>
Trace; c0131850 <generic_commit_write+34/60>
Trace; c014f2c9 <ext2_commit_chunk+39/70>
Trace; c014fe61 <ext2_delete_entry+12d/13c>
Trace; c015265d <ext2_unlink+51/5c>
Trace; c013917f <sys_unlink+cf/110>
Trace; c013b197 <sys_ioctl+21b/234>
Trace; c0106be3 <system_call+33/38>

Code;  c01800d6 <pci_write_config_dword+12/34>
00000000 <_EIP>:
Code;  c01800d6 <pci_write_config_dword+12/34>   <=====
   0:   8b 46 10                  mov    0x10(%esi),%eax   <=====
Code;  c01800d9 <pci_write_config_dword+15/34>
   3:   8b 50 30                  mov    0x30(%eax),%edx
Code;  c01800dc <pci_write_config_dword+18/34>
   6:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  c01800e0 <pci_write_config_dword+1c/34>
   a:   50                        push   %eax
Code;  c01800e1 <pci_write_config_dword+1d/34>
   b:   51                        push   %ecx
Code;  c01800e2 <pci_write_config_dword+1e/34>
   c:   56                        push   %esi
Code;  c01800e3 <pci_write_config_dword+1f/34>
   d:   8b 42 14                  mov    0x14(%edx),%eax
Code;  c01800e6 <pci_write_config_dword+22/34>
  10:   ff d0                     call   *%eax
Code;  c01800e8 <pci_write_config_dword+24/34>
  12:   83 c4 00                  add    $0x0,%esp

 <6>cs: cb_alloc(bus 2): vendor 0x10b7, device 0x5257
cs: cb_config(bus 2)
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3f8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0380-0x03f7: clean.
cs: IO port probe 0x0400-0x04cf: clean.
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: cb_enable(bus 2)

1 warning issued.  Results may not be reliable.

