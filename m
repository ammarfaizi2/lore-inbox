Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbTGBNVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 09:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbTGBNVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 09:21:48 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:35611 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S264982AbTGBNVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 09:21:45 -0400
Date: Wed, 2 Jul 2003 15:36:06 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.4.22-pre2
Message-ID: <Pine.LNX.4.53.0307021529310.19377@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Here is oops on 2.4.22-pre2 :(
machine 2X Intel(R) Xeon(TM) CPU 2.66GHz, 4GB RAM, aic7902, 10GB parition 
on /home

ksymoops 2.4.5 on i686 2.4.21-rc6.  Options used
     -V (default)
     -k /var/log/ksyms.1 (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre2/ (specified)
     -m /lib/modules/2.4.22-pre2/System.map (specified)

Warning (compare_ksyms_lsmod): module ipv6 is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module nfs is in lsmod but not in ksyms, probably no symbols exported
Jul  2 11:08:01 oceanic kernel: kernel BUG at transaction.c:249!
Jul  2 11:08:01 oceanic kernel: invalid operand: 0000
Jul  2 11:08:01 oceanic kernel: CPU:    0
Jul  2 11:08:01 oceanic kernel: EIP:    0010:[<f8a403ff>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul  2 11:08:01 oceanic kernel: EFLAGS: 00010286
Jul  2 11:08:01 oceanic kernel: eax: 0000007a   ebx: e20f8f00   ecx: 00000002   edx: d8249f7c
Jul  2 11:08:01 oceanic kernel: esi: c72ba000   edi: f2678600   ebp: 00000000   esp: c72bbb38
Jul  2 11:08:01 oceanic kernel: ds: 0018   es: 0018   ss: 0018
Jul  2 11:08:01 oceanic kernel: Process smbd (pid: 31036, stackpage=c72bb000)
Jul  2 11:08:01 oceanic kernel: Stack: f8a49140 f8a4899b f8a48970 000000f9 f8a491c0 e20f8f00 e4169300 e4169300 
Jul  2 11:08:01 oceanic kernel:        f8a56990 f2678600 00000002 c72ba000 00000001 e4169300 f2678a00 c0156f25 
Jul  2 11:08:01 oceanic kernel:        e4169300 00000020 00000000 00000000 c01305f0 e4169300 00000001 00000000 
Jul  2 11:08:05 oceanic kernel: Call Trace:    [<f8a49140>] [<f8a4899b>] [<f8a48970>] [<f8a491c0>] [<f8a56990>]
Jul  2 11:08:05 oceanic kernel:   [<c0156f25>] [<c01305f0>] [<c013070b>] [<c01af17e>] [<c0130dbf>] [<f8a51059>]
Jul  2 11:08:05 oceanic kernel:   [<c015d939>] [<c015de2c>] [<c0117536>] [<c015eec1>] [<c01575fe>] [<c01576dc>]
Jul  2 11:08:05 oceanic kernel:   [<c01554a0>] [<c0157972>] [<c0157a24>] [<c0135f13>] [<c0135f76>] [<c0136f32>]
Jul  2 11:08:05 oceanic kernel:   [<c01371c4>] [<c012df96>] [<f8a54ad5>] [<f8a4037b>] [<f8a40445>] [<f8a52adc>]
Jul  2 11:08:05 oceanic kernel:   [<f8a55698>] [<c022f99c>] [<c012a2f3>] [<c0158ba6>] [<f8a5654c>] [<c026a7f2>]
Jul  2 11:08:05 oceanic kernel:   [<c0158efe>] [<c013cff0>] [<c0147a33>] [<c013e6ad>] [<c013d0b7>] [<c010770f>]
Jul  2 11:08:05 oceanic kernel: Code: 0f 0b f9 00 70 89 a4 f8 ff 43 08 89 d8 8b 5c 24 14 8b 74 24 


>>EIP; f8a403ff <[jbd]journal_start+5f/c0>   <=====

>>ebx; e20f8f00 <_end+21d67bfc/386aed5c>
>>edx; d8249f7c <_end+17eb8c78/386aed5c>
>>esi; c72ba000 <_end+6f28cfc/386aed5c>
>>edi; f2678600 <_end+322e72fc/386aed5c>
>>esp; c72bbb38 <_end+6f2a834/386aed5c>

Trace; f8a49140 <[jbd]__kstrtab_journal_force_commit+258/4d20>
Trace; f8a4899b <[jbd]__ksymtab_journal_blocks_per_page+3/8>
Trace; f8a48970 <[jbd]__ksymtab_journal_ack_err+0/8>
Trace; f8a491c0 <[jbd]__kstrtab_journal_force_commit+2d8/4d20>
Trace; f8a56990 <[ext3]ext3_dirty_inode+120/140>
Trace; c0156f25 <__mark_inode_dirty+b5/c0>
Trace; c01305f0 <precheck_file_write+230/2f0>
Trace; c013070b <do_generic_file_write+5b/410>
Trace; c01af17e <__make_request+29e/640>
Trace; c0130dbf <generic_file_write+13f/160>
Trace; f8a51059 <[ext3]ext3_file_write+39/d0>
Trace; c015d939 <write_dquot+a9/100>
Trace; c015de2c <dqput+4c/f0>
Trace; c0117536 <mmput+26/f0>
Trace; c015eec1 <dquot_drop+51/60>
Trace; c01575fe <clear_inode+8e/130>
Trace; c01576dc <dispose_list+3c/80>
Trace; c01554a0 <dput+30/190>
Trace; c0157972 <prune_icache+82/110>
Trace; c0157a24 <shrink_icache_memory+24/40>
Trace; c0135f13 <shrink_caches+83/b0>
Trace; c0135f76 <try_to_free_pages_zone+36/50>
Trace; c0136f32 <balance_classzone+62/1f0>
Trace; c01371c4 <__alloc_pages+104/1a0>
Trace; c012df96 <find_or_create_page+86/110>
Trace; f8a54ad5 <[ext3]ext3_block_truncate_page+85/490>
Trace; f8a4037b <[jbd]new_handle+4b/70>
Trace; f8a40445 <[jbd]journal_start+a5/c0>
Trace; f8a52adc <[ext3]start_transaction+8c/90>
Trace; f8a55698 <[ext3]ext3_truncate+d8/480>
Trace; c022f99c <skb_copy_datagram_iovec+4c/280>
Trace; c012a2f3 <vmtruncate+d3/1b0>
Trace; c0158ba6 <inode_setattr+106/120>
Trace; f8a5654c <[ext3]ext3_setattr+25c/320>
Trace; c026a7f2 <inet_recvmsg+52/70>
Trace; c0158efe <notify_change+2ce/2e0>
Trace; c013cff0 <do_truncate+80/c0>
Trace; c0147a33 <cp_new_stat64+f3/120>
Trace; c013e6ad <do_sys_ftruncate+10d/16c>
Trace; c013d0b7 <sys_ftruncate64+27/30>
Trace; c010770f <system_call+33/38>

Code;  f8a403ff <[jbd]journal_start+5f/c0>
00000000 <_EIP>:
Code;  f8a403ff <[jbd]journal_start+5f/c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f8a40401 <[jbd]journal_start+61/c0>
   2:   f9                        stc    
Code;  f8a40402 <[jbd]journal_start+62/c0>
   3:   00 70 89                  add    %dh,0xffffff89(%eax)
Code;  f8a40405 <[jbd]journal_start+65/c0>
   6:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  f8a40406 <[jbd]journal_start+66/c0>
   7:   f8                        clc    
Code;  f8a40407 <[jbd]journal_start+67/c0>
   8:   ff 43 08                  incl   0x8(%ebx)
Code;  f8a4040a <[jbd]journal_start+6a/c0>
   b:   89 d8                     mov    %ebx,%eax
Code;  f8a4040c <[jbd]journal_start+6c/c0>
   d:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  f8a40410 <[jbd]journal_start+70/c0>
  11:   8b 74 24 00               mov    0x0(%esp,1),%esi


2 warnings issued.  Results may not be reliable.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
