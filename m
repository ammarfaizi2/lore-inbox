Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUBKBw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUBKBwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:52:55 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:36752
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261464AbUBKBwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:52:51 -0500
Date: Tue, 10 Feb 2004 21:04:32 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: knfsd oops 2.4.24
Message-ID: <20040210210432.A2880@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was burning a cd over nfs (glad I have burnproof =) when knfsd crashed on
me.  2 kjourneld oopses followed (sorry, wasn't able to capture).

Disk is SCSI on an AHA2940UW controller.  I'm considering going to 2.6.x,
but I'm simply not convinced of 2.6's stability and I've noticed a few knfsd
problems there as well (minor problems).

I'm sure I'll beable to capture the other oopses.

The machine is an ms6163 pIII700 384mb ram (FYI, this used to be in another
machine running 2.6 and did not actually have these problems).

Any more information required will be given.

Keep me in CC

ksymoops 2.4.5 on i686 2.4.24.  Options used
     -v /vegeta/usr/src/linux/nail/2.4.24/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24/ (default)
     -m /boot/System.map-2.4.24 (default)

Unable to handle kernel paging request at virtual address fc3e2f3a
 printing eip:
c0115c6b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0115c6b>]    Not tainted
EFLAGS: 00010086
eax: cd9a5948   ebx: fc3e2f3a   ecx: 00000001   edx: 00000003
esi: cd9a5948   edi: 00000003   ebp: d5515d14   esp: d5515cf8
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 324, stackpage=d5515000)
Stack: cd9a5900 c013b835 00000001 00000286 cd9a5900 00000008 00000000 00001000 
       c01924af 00000000 cd9a5900 00000000 d7a9a400 00000030 cd9a5900 00000000 
       00000031 cd9a5900 c013c32c 00000000 cd9a5900 cd9a5900 00000000 00000010 
Call Trace:    [<c013b835>] [<c01924af>] [<c013c32c>] [<c0131213>] [<c012a54d>]
  [<d882b310>] [<c012abcf>] [<c012ae4d>] [<c012b440>] [<c012b59a>] [<c012b440>]
  [<d88a1964>] [<d88a1cf7>] [<d88362e0>] [<d88a7ee5>] [<d88a9a97>] [<d88ae418>]
  [<d889d5ee>] [<c01ec1b7>] [<d88ae418>] [<d88adc78>] [<d88adc98>] [<d889d3bd>]
  [<d88adc60>] [<d88adc60>] [<c010577e>] [<d889d200>]

Code: 8b 13 0f 18 02 39 c3 74 22 8d b6 00 00 00 00 8d bf 00 00 00 
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address fc3e2f3a
c0115c6b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0115c6b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: cd9a5948   ebx: fc3e2f3a   ecx: 00000001   edx: 00000003
esi: cd9a5948   edi: 00000003   ebp: d5515d14   esp: d5515cf8
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 324, stackpage=d5515000)
Stack: cd9a5900 c013b835 00000001 00000286 cd9a5900 00000008 00000000 00001000 
       c01924af 00000000 cd9a5900 00000000 d7a9a400 00000030 cd9a5900 00000000 
       00000031 cd9a5900 c013c32c 00000000 cd9a5900 cd9a5900 00000000 00000010 
Call Trace:    [<c013b835>] [<c01924af>] [<c013c32c>] [<c0131213>] [<c012a54d>]
  [<d882b310>] [<c012abcf>] [<c012ae4d>] [<c012b440>] [<c012b59a>] [<c012b440>]
  [<d88a1964>] [<d88a1cf7>] [<d88362e0>] [<d88a7ee5>] [<d88a9a97>] [<d88ae418>]
  [<d889d5ee>] [<c01ec1b7>] [<d88ae418>] [<d88adc78>] [<d88adc98>] [<d889d3bd>]
  [<d88adc60>] [<d88adc60>] [<c010577e>] [<d889d200>]
Code: 8b 13 0f 18 02 39 c3 74 22 8d b6 00 00 00 00 8d bf 00 00 00 


>>EIP; c0115c6b <__wake_up+1b/90>   <=====

>>eax; cd9a5948 <_end+d72851c/18582bd4>
>>ebx; fc3e2f3a <END_OF_CODE+23b0633b/????>
>>esi; cd9a5948 <_end+d72851c/18582bd4>
>>ebp; d5515d14 <_end+152988e8/18582bd4>
>>esp; d5515cf8 <_end+152988cc/18582bd4>

Trace; c013b835 <get_unused_buffer_head+45/80>
Trace; c01924af <submit_bh+df/f0>
Trace; c013c32c <block_read_full_page+15c/280>
Trace; c0131213 <lru_cache_add+63/80>
Trace; c012a54d <page_cache_read+ad/d0>
Trace; d882b310 <[ext3]ext3_get_block+0/90>
Trace; c012abcf <generic_file_readahead+ef/1a0>
Trace; c012ae4d <do_generic_file_read+19d/460>
Trace; c012b440 <file_read_actor+0/a0>
Trace; c012b59a <generic_file_read+ba/1b0>
Trace; c012b440 <file_read_actor+0/a0>
Trace; d88a1964 <[nfsd]nfsd_open+144/200>
Trace; d88a1cf7 <[nfsd]nfsd_read+147/200>
Trace; d88362e0 <[ext3]ext3_file_operations+0/60>
Trace; d88a7ee5 <[nfsd]nfsd3_proc_read+f5/1d0>
Trace; d88a9a97 <[nfsd]nfs3svc_decode_readargs+27/d0>
Trace; d88ae418 <[nfsd]nfsd_procedures3+d8/320>
Trace; d889d5ee <[nfsd]nfsd_dispatch+ce/200>
Trace; c01ec1b7 <svc_process+377/580>
Trace; d88ae418 <[nfsd]nfsd_procedures3+d8/320>
Trace; d88adc78 <[nfsd]nfsd_version3+0/10>
Trace; d88adc98 <[nfsd]nfsd_program+0/28>
Trace; d889d3bd <[nfsd]nfsd+1bd/320>
Trace; d88adc60 <[nfsd]nfsd_list+0/0>
Trace; d88adc60 <[nfsd]nfsd_list+0/0>
Trace; c010577e <arch_kernel_thread+2e/40>
Trace; d889d200 <[nfsd]nfsd+0/320>

Code;  c0115c6b <__wake_up+1b/90>
00000000 <_EIP>:
Code;  c0115c6b <__wake_up+1b/90>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c0115c6d <__wake_up+1d/90>
   2:   0f 18 02                  prefetchnta (%edx)
Code;  c0115c70 <__wake_up+20/90>
   5:   39 c3                     cmp    %eax,%ebx
Code;  c0115c72 <__wake_up+22/90>
   7:   74 22                     je     2b <_EIP+0x2b>
Code;  c0115c74 <__wake_up+24/90>
   9:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c0115c7a <__wake_up+2a/90>
   f:   8d bf 00 00 00 00         lea    0x0(%edi),%edi
