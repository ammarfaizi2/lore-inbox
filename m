Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUGBOKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUGBOKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUGBOKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:10:43 -0400
Received: from [194.243.27.136] ([194.243.27.136]:32010 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S264577AbUGBOKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:10:06 -0400
X-Qmail-Scanner-Mail-From: devel@integra-sc.it via venere.pandoraonline.it
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:1(213.140.22.76):. Processed in 0.062603 secs)
Date: Fri, 2 Jul 2004 16:14:21 +0200
From: Devel <devel@integra-sc.it>
To: linux-kernel@vger.kernel.org
Subject: Lot of oops with kernel 2.4.26+patch_kraxel-2.4.26
Message-Id: <20040702161421.43e4319e.devel@integra-sc.it>
Organization: Integra Solutions
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i have a lot of oops  in my linux box redhat 7.3 with kernel 2.4.26+patch_kraxel-2.4.26.
When i running my apps that take image from 16 video grabber the results are a lot of oops. I passed them from ksymoops:

ksymoops 2.4.4 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /boot/System.map-2.4.26-WE (specified)
                                                                                                                             
Jul  2 13:30:57 machine kernel: Unable to handle kernel paging request at virtual address 2323233b
Jul  2 13:30:57 machine kernel: c0130502
Jul  2 13:30:57 machine kernel: *pde = 00000000
Jul  2 13:30:57 machine kernel: Oops: 0000
Jul  2 13:30:57 machine kernel: CPU:    0
Jul  2 13:30:57 machine kernel: EIP:    0010:[<c0130502>]    Not tainted
Jul  2 13:30:57 machine kernel: EFLAGS: 00010202
Jul  2 13:30:57 machine kernel: eax: 23232323   ebx: 00000001   ecx: 23232323   edx: 00000000
Jul  2 13:30:57 machine kernel: esi: f3ce53a4   edi: f8a6b008   ebp: f3ce6200   esp: f3ccfc2c
Jul  2 13:30:57 machine kernel: ds: 0018   es: 0018   ss: 0018
Jul  2 13:30:57 machine kernel: Process videoapp (pid: 748, stackpage=f3ccf000)
Jul  2 13:30:57 machine kernel: Stack: f8a4c6eb f3ce53a4 f3ce5380 f8a5b9dd f3ce53a4 f7fc8400 f3ce53a4 f3ce5380
Jul  2 13:30:57 machine kernel:        00000000 00000000 f3ce5380 40047612 00000000 f8a55419 f8a6b008 f3ce5380
Jul  2 13:30:57 machine kernel:        f7fc8400 f3ce53a4 f5aee0c0 f17199c0 f3ce6210 f8a6b008 00000000 f17199c0
Jul  2 13:30:57 machine kernel: Call Trace:    [<f8a4c6eb>] [<f8a5b9dd>] [<f8a55419>] [<f8a6b008>] [<f8a6b008>]
Jul  2 13:30:57 machine kernel:   [<c015d540>] [<c0163e29>] [<c015d4e3>] [<c015d4f4>] [<c0163e29>] [<c0162dc5>]
Jul  2 13:30:57 machine kernel:   [<c01ad56d>] [<c0162dc5>] [<c01acc0a>] [<c01add30>] [<c0130224>] [<c015d1ed>]
Jul  2 13:30:57 machine kernel:   [<c012e9c5>] [<c01285dd>] [<c013341f>] [<c02b45aa>] [<c01334a7>] [<c021e715>]
Jul  2 13:30:57 machine kernel:   [<c0212482>] [<c021ecf9>] [<c021ee41>] [<c021ecc8>] [<f8a434e4>] [<f8a56c62>]
Jul  2 13:30:57 machine kernel:   [<f8a69b18>] [<c011bd91>] [<f8a55c5c>] [<f8a548a0>] [<c0142e46>] [<c01087d3>]
Jul  2 13:30:57 machine kernel: Code: 8b 41 18 a9 00 40 00 00 75 14 ff 49 14 0f 94 c0 84 c0 74 0a

>>EIP; c0130502 <__free_pages+2/30>   <=====
Trace; f8a4c6eb <[video-buf]__kstrtab_videobuf_mmap_setup+b/40>
Trace; f8a5b9dd <[bttv]bttv_dma_free+3d/70>
Trace; f8a55419 <[bttv]bttv_do_ioctl+b79/1380>
Trace; f8a6b008 <[bttv]bttvs+1f68/53c0>
Trace; f8a6b008 <[bttv]bttvs+1f68/53c0>
Trace; c015d540 <ext3_reserve_inode_write+30/b0>
Trace; c0163e29 <__journal_file_buffer+d9/1e0>
Trace; c015d4e3 <ext3_mark_iloc_dirty+23/50>
Trace; c015d4f4 <ext3_mark_iloc_dirty+34/50>
Trace; c0163e29 <__journal_file_buffer+d9/1e0>
Trace; c0162dc5 <do_get_write_access+485/4b0>
Trace; c01ad56d <semctl_main+3bd/3f0>
Trace; c0162dc5 <do_get_write_access+485/4b0>
Trace; c01acc0a <sem_revalidate+7a/90>
Trace; c01add30 <sys_semtimedop+370/5a0>
Trace; c0130224 <__alloc_pages+74/2c0>
Trace; c015d1ed <ext3_do_update_inode+2ed/380>
Trace; c012e9c5 <lru_cache_add+65/70>
Trace; c01285dd <add_to_page_cache_unique+9d/b0>
Trace; c013341f <shmem_getpage+44f/530>
Trace; c02b45aa <fast_clear_page+a/60>
Trace; c01334a7 <shmem_getpage+4d7/530>
Trace; c021e715 <ide_build_dmatable+65/1b0>
Trace; c0212482 <ide_execute_command+62/80>
Trace; c021ecf9 <__ide_dma_begin+29/30>
Trace; c021ee41 <__ide_dma_count+11/20>
Trace; c021ecc8 <__ide_dma_write+d8/e0>
Trace; f8a434e4 <[videodev]video_usercopy+a4/110>
Trace; f8a56c62 <[bttv]bttv_irq_switch_video+122/130>
Trace; f8a69b18 <[bttv]bttvs+a78/53c0>
Trace; c011bd91 <do_getitimer+a1/b0>
Trace; f8a55c5c <[bttv]bttv_ioctl+3c/50>
Trace; f8a548a0 <[bttv]bttv_do_ioctl+0/1380>
Trace; c0142e46 <sys_ioctl+216/230>
Trace; c01087d3 <system_call+33/38>
Code;  c0130502 <__free_pages+2/30>
00000000 <_EIP>:
Code;  c0130502 <__free_pages+2/30>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c0130505 <__free_pages+5/30>
   3:   a9 00 40 00 00            test   $0x4000,%eax
Code;  c013050a <__free_pages+a/30>
   8:   75 14                     jne    1e <_EIP+0x1e> c0130520 <__free_pages+20/30>
Code;  c013050c <__free_pages+c/30>
   a:   ff 49 14                  decl   0x14(%ecx)
Code;  c013050f <__free_pages+f/30>
   d:   0f 94 c0                  sete   %al
Code;  c0130512 <__free_pages+12/30>
  10:   84 c0                     test   %al,%al
Code;  c0130514 <__free_pages+14/30>
  12:   74 0a                     je     1e <_EIP+0x1e> c0130520 <__free_pages+20/30>
                                                                                                                             
Jul  2 13:30:57 machine kernel:  <1>Unable to handle kernel paging request at virtual address 2323233b
Jul  2 13:30:57 machine kernel: c0130502
Jul  2 13:30:57 machine kernel: *pde = 00000000
Jul  2 13:30:57 machine kernel: Oops: 0000
Jul  2 13:30:57 machine kernel: CPU:    0
Jul  2 13:30:57 machine kernel: EIP:    0010:[<c0130502>]    Not tainted
Jul  2 13:30:57 machine kernel: EFLAGS: 00010202
Jul  2 13:30:57 machine kernel: eax: 23232323   ebx: 00000001   ecx: 23232323   edx: 00000000
Jul  2 13:30:57 machine kernel: esi: f3ce53a4   edi: f8a6b008   ebp: f47a29c0   esp: f3ccfa70
Jul  2 13:30:57 machine kernel: ds: 0018   es: 0018   ss: 0018
Jul  2 13:30:57 machine kernel: Process videoapp (pid: 748, stackpage=f3ccf000)
Jul  2 13:30:57 machine kernel: Stack: f8a4c6eb f3ce53a4 f3ce5380 f8a5b9dd f3ce53a4 f7fc8400 f3ce53a4 f3ce5380
Jul  2 13:30:57 machine kernel:        00000000 00000000 f17199c0 00000020 0000001f f8a4d94c f8a6b008 f3ce5380
Jul  2 13:30:57 machine kernel:        f47a29c0 01040000 f43d36c0 4032a000 c012790f f47a29c0 f51268c0 fffffffe
Jul  2 13:30:57 machine kernel: Call Trace:    [<f8a4c6eb>] [<f8a5b9dd>] [<f8a4d94c>] [<f8a6b008>] [<c012790f>]
Jul  2 13:30:57 machine kernel:   [<c011c92b>] [<c0130502>] [<c011737a>] [<c011b6ca>] [<c0108da8>] [<c0130502>]
Jul  2 13:30:57 machine kernel:   [<c01153e8>] [<c013047c>] [<c010da6a>] [<f8a4a0e8>] [<f8a5ae2f>] [<c0115070>]
Jul  2 13:30:57 machine kernel:   [<c01088c4>] [<f8a6b008>] [<c0130502>] [<f8a4c6eb>] [<f8a5b9dd>] [<f8a55419>]
Jul  2 13:30:57 machine kernel:   [<f8a6b008>] [<f8a6b008>] [<c015d540>] [<c0163e29>] [<c015d4e3>] [<c015d4f4>]
Jul  2 13:30:57 machine kernel:   [<c0163e29>] [<c0162dc5>] [<c01ad56d>] [<c0162dc5>] [<c01acc0a>] [<c01add30>]
Jul  2 13:30:57 machine kernel:   [<c0130224>] [<c015d1ed>] [<c012e9c5>] [<c01285dd>] [<c013341f>] [<c02b45aa>]
Jul  2 13:30:57 machine kernel:   [<c01334a7>] [<c021e715>] [<c0212482>] [<c021ecf9>] [<c021ee41>] [<c021ecc8>]
Jul  2 13:30:57 machine kernel:   [<f8a434e4>] [<f8a56c62>] [<f8a69b18>] [<c011bd91>] [<f8a55c5c>] [<f8a548a0>]
Jul  2 13:30:57 machine kernel:   [<c0142e46>] [<c01087d3>]
Jul  2 13:30:57 machine kernel: Code: 8b 41 18 a9 00 40 00 00 75 14 ff 49 14 0f 94 c0 84 c0 74 0a

>>EIP; c0130502 <__free_pages+2/30>   <=====
Trace; f8a4c6eb <[video-buf]__kstrtab_videobuf_mmap_setup+b/40>
Trace; f8a5b9dd <[bttv]bttv_dma_free+3d/70>
Trace; f8a4d94c <[video-buf]videobuf_vm_close+9c/c0>
Trace; f8a6b008 <[bttv]bttvs+1f68/53c0>
Trace; c012790f <exit_mmap+5f/110>
Trace; c011c92b <do_softirq+4b/90>
Trace; c0130502 <__free_pages+2/30>
Trace; c011737a <mmput+4a/70>
Trace; c011b6ca <do_exit+8a/210>
Trace; c0108da8 <die+58/60>
Trace; c0130502 <__free_pages+2/30>
Trace; c01153e8 <do_page_fault+378/4ab>
Trace; c013047c <__get_free_pages+c/40>
Trace; c010da6a <pci_alloc_consistent+3a/70>
Trace; f8a4a0e8 <[btcx-risc]__module_parm_desc_debug+28/90>
Trace; f8a5ae2f <[bttv]bttv_risc_planar+3f/2c0>
Trace; c0115070 <do_page_fault+0/4ab>
Trace; c01088c4 <error_code+34/3c>
Trace; f8a6b008 <[bttv]bttvs+1f68/53c0>
Trace; c0130502 <__free_pages+2/30>
Trace; f8a4c6eb <[video-buf]__kstrtab_videobuf_mmap_setup+b/40>
Trace; f8a5b9dd <[bttv]bttv_dma_free+3d/70>
Trace; f8a55419 <[bttv]bttv_do_ioctl+b79/1380>
Trace; f8a6b008 <[bttv]bttvs+1f68/53c0>
Trace; f8a6b008 <[bttv]bttvs+1f68/53c0>
Trace; c015d540 <ext3_reserve_inode_write+30/b0>
Trace; c0163e29 <__journal_file_buffer+d9/1e0>
Trace; c015d4e3 <ext3_mark_iloc_dirty+23/50>
Trace; c015d4f4 <ext3_mark_iloc_dirty+34/50>
Trace; c0163e29 <__journal_file_buffer+d9/1e0>
Trace; c0162dc5 <do_get_write_access+485/4b0>
Trace; c01ad56d <semctl_main+3bd/3f0>
Trace; c0162dc5 <do_get_write_access+485/4b0>
Trace; c01acc0a <sem_revalidate+7a/90>
Trace; c01add30 <sys_semtimedop+370/5a0>
Trace; c0130224 <__alloc_pages+74/2c0>
Trace; c015d1ed <ext3_do_update_inode+2ed/380>
Trace; c012e9c5 <lru_cache_add+65/70>
Trace; c01285dd <add_to_page_cache_unique+9d/b0>
Trace; c013341f <shmem_getpage+44f/530>
Trace; c02b45aa <fast_clear_page+a/60>
Trace; c01334a7 <shmem_getpage+4d7/530>
Trace; c021e715 <ide_build_dmatable+65/1b0>
Trace; c0212482 <ide_execute_command+62/80>
Trace; c021ecf9 <__ide_dma_begin+29/30>
Trace; c021ee41 <__ide_dma_count+11/20>
Trace; c021ecc8 <__ide_dma_write+d8/e0>
Trace; f8a434e4 <[videodev]video_usercopy+a4/110>
Trace; f8a56c62 <[bttv]bttv_irq_switch_video+122/130>
Trace; f8a69b18 <[bttv]bttvs+a78/53c0>
Trace; c011bd91 <do_getitimer+a1/b0>
Trace; f8a55c5c <[bttv]bttv_ioctl+3c/50>
Trace; f8a548a0 <[bttv]bttv_do_ioctl+0/1380>
Trace; c0142e46 <sys_ioctl+216/230>
Trace; c01087d3 <system_call+33/38>
Code;  c0130502 <__free_pages+2/30>
00000000 <_EIP>:
Code;  c0130502 <__free_pages+2/30>   <=====
   0:   8b 41 18                  mov    0x18(%ecx),%eax   <=====
Code;  c0130505 <__free_pages+5/30>
   3:   a9 00 40 00 00            test   $0x4000,%eax
Code;  c013050a <__free_pages+a/30>
   8:   75 14                     jne    1e <_EIP+0x1e> c0130520 <__free_pages+20/30>
Code;  c013050c <__free_pages+c/30>
   a:   ff 49 14                  decl   0x14(%ecx)
Code;  c013050f <__free_pages+f/30>
   d:   0f 94 c0                  sete   %al
Code;  c0130512 <__free_pages+12/30>
  10:   84 c0                     test   %al,%al
Code;  c0130514 <__free_pages+14/30>
  12:   74 0a                     je     1e <_EIP+0x1e> c0130520 <__free_pages+20/30>
                                                                                                                             


