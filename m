Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTA1OTp>; Tue, 28 Jan 2003 09:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbTA1OTp>; Tue, 28 Jan 2003 09:19:45 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:9476 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265567AbTA1OTk>; Tue, 28 Jan 2003 09:19:40 -0500
Date: Tue, 28 Jan 2003 15:28:41 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: SMP instability in 2.4.21-pre3-ac4, oops provided
Message-ID: <20030128142841.GA10209@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030128073030.GA1032@middle.of.nowhere> <20030128132517.GA6509@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128132517.GA6509@middle.of.nowhere>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jurriaan <thunder7@xs4all.nl>
Date: Tue, Jan 28, 2003 at 02:25:17PM +0100
> From: Jurriaan <thunder7@xs4all.nl>
> Date: Tue, Jan 28, 2003 at 08:30:30AM +0100
> > I'm seeing instability in my new system, a dual Intel P3/1400 tualatin
> > system.
> 
Thinking it may have to do with my gcc-version, I tried 2.95 (and had no
luck):

ksymoops 2.4.8 on i686 2.4.21-pre3-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac4/ (default)
     -m /boot/System.map-2.4.21-pre3-ac4_2.95 (specified)

Unable to handle kernel paging request at virtual address ad94a054
c0136630
*pde = 00000000
Oops: 000
CPU:    0
EIP:    0010:[<c0136630>]      Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c01369b8>] [<c0144811>] [<c014495d>] [<c0144be7>] [<c01451e1>]
 [<c0139ce0>] [<c012fac9>] [<c0179c79>] [<c0176ed4>] [<c012fbe4>] [<c0130435>]
 [<c01306cc>] [<c0130cab>] [<c0130ba8>] [<c014174d>] [<c010734f>]
Code: 87 03 3d 71 f0 2c 5a 74 08 0f 0b f4 04 0c 96 26 c0 8b 7d 08


>>EIP; c0136630 <kmem_cache_alloc_batch+178/22c>   <=====

Trace; c01369b8 <kmem_cache_alloc+84/29c>
Trace; c0144811 <get_unused_buffer_head+c5/19c>
Trace; c014495d <create_buffers+1d/140>
Trace; c0144be7 <create_empty_buffers+17/60>
Trace; c01451e1 <block_read_full_page+51/204>
Trace; c0139ce0 <__alloc_pages+44/164>
Trace; c012fac9 <add_to_page_cache_unique+d5/e4>
Trace; c0179c79 <reiserfs_readpage+11/18>
Trace; c0176ed4 <reiserfs_get_block+0/1018>
Trace; c012fbe4 <page_cache_read+10c/124>
Trace; c0130435 <generic_file_readahead+109/140>
Trace; c01306cc <do_generic_file_read+228/504>
Trace; c0130cab <generic_file_read+7b/10c>
Trace; c0130ba8 <file_read_actor+0/88>
Trace; c014174d <sys_read+91/17c>
Trace; c010734f <system_call+33/38>

Code;  c0136630 <kmem_cache_alloc_batch+178/22c>
00000000 <_EIP>:
Code;  c0136630 <kmem_cache_alloc_batch+178/22c>   <=====
   0:   87 03                     xchg   %eax,(%ebx)   <=====
Code;  c0136632 <kmem_cache_alloc_batch+17a/22c>
   2:   3d 71 f0 2c 5a            cmp    $0x5a2cf071,%eax
Code;  c0136637 <kmem_cache_alloc_batch+17f/22c>
   7:   74 08                     je     11 <_EIP+0x11>
Code;  c0136639 <kmem_cache_alloc_batch+181/22c>
   9:   0f 0b                     ud2a   
Code;  c013663b <kmem_cache_alloc_batch+183/22c>
   b:   f4                        hlt    
Code;  c013663c <kmem_cache_alloc_batch+184/22c>
   c:   04 0c                     add    $0xc,%al
Code;  c013663e <kmem_cache_alloc_batch+186/22c>
   e:   96                        xchg   %eax,%esi
Code;  c013663f <kmem_cache_alloc_batch+187/22c>
   f:   26 c0 8b 7d 08 00 00      rorb   $0x0,%es:0x87d(%ebx)
Code;  c0136646 <kmem_cache_alloc_batch+18e/22c>
  16:   00 



-- 
And the gosts of hope walk silent halls
At the death of the promised land
All is gone, all is gone
But these changing winds can turn cold and hostile
	New Model Army
GNU/Linux 2.4.21-pre3-ac4 SMP/ReiserFS 2x2824 bogomips load av: 0.54 1.10 0.82
