Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUGBVec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUGBVec (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbUGBVec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:34:32 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:13442 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264960AbUGBVeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:34:24 -0400
Message-ID: <40E5D514.5080106@blue-labs.org>
Date: Fri, 02 Jul 2004 17:35:16 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Bad: scheduling while atomic, 2.6.7
Content-Type: multipart/mixed;
 boundary="------------050508030904020706010700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050508030904020706010700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

AMD64, nothing special about the kernel.

Unable to handle kernel paging request at 000001083d74a4c8 RIP:
<ffffffff801ba763>{find_inode+35}
PML4 8063 PGD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: ipt_REJECT iptable_filter iptable_mangle 
ipt_MASQUERADE iptable_nat ip_conntrack ip_tables
Pid: 8598, comm: rsync Not tainted 2.6.7
RIP: 0010:[<ffffffff801ba763>] <ffffffff801ba763>{find_inode+35}
RSP: 0018:0000010017ca5b78  EFLAGS: 00010202
RAX: 000001083d74a4c8 RBX: 000001083d74a4c8 RCX: 0000010017ca5c00
RDX: ffffffff801f5f20 RSI: 000001003fe669a8 RDI: 000001003f82b578
RBP: 000001003f82b578 R08: 0000010017ca5c00 R09: 0000010012cb97b8
R10: 0000000000000001 R11: 0000000000000246 R12: 000001003f82b578
R13: 000001003fe669a8 R14: 0000010017ca5c00 R15: ffffffff801f5f20
FS:  0000002a95aa2090(0000) GS:ffffffff807fc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000001083d74a4c8 CR3: 0000000000101000 CR4: 00000000000006e0
Process rsync (pid: 8598, threadinfo 0000010017ca4000, task 
000001001fd6ab10)
Stack: 0000010012cb84c8 0000010017ca5c38 000001003f82b578 000001003fe669a8
       0000010017ca5c00 ffffffff801f5f20 ffffffff801f5df0 ffffffff801bbb12
       0000000000000006 0000010017ca5c38
Call Trace:<ffffffff801f5f20>{reiserfs_find_actor+0} 
<ffffffff801f5df0>{reiserfs_init_locked_inode+0}
       <ffffffff801bbb12>{iget5_locked+290} 
<ffffffff801f5fa2>{reiserfs_iget+82}
       <ffffffff801efb1a>{reiserfs_lookup+442} 
<ffffffff801a75a3>{real_lookup+131}
       <ffffffff801a7a99>{do_lookup+105} 
<ffffffff801a8a19>{link_path_walk+3881}
       <ffffffff8016e320>{poison_obj+48} <ffffffff801a90be>{path_lookup+494}
       <ffffffff801a928e>{__user_walk+62} <ffffffff801a1720>{vfs_lstat+32}
       <ffffffff801a1b5f>{sys_newlstat+31} 
<ffffffff8011221a>{system_call+126}


Code: 48 8b 03 0f 18 08 4c 39 a3 80 01 00 00 75 23 4c 89 f6 48 89
RIP <ffffffff801ba763>{find_inode+35} RSP <0000010017ca5b78>
CR2: 000001083d74a4c8
 <6>note: rsync[8598] exited with preempt_count 2
bad: scheduling while atomic!

Call Trace:<ffffffff8053795e>{schedule+94} 
<ffffffff80179d5a>{zap_pmd_range+186}
       <ffffffff8017a03c>{unmap_vmas+572} <ffffffff80180b05>{exit_mmap+293}
       <ffffffff80139600>{mmput+272} <ffffffff80140fdf>{do_exit+815}
       <ffffffff8011391d>{oops_end+205} 
<ffffffff80127ab5>{do_page_fault+1109}
       <ffffffff80194610>{bh_wake_function+0} 
<ffffffff80194610>{bh_wake_function+0}
       <ffffffff801f5f20>{reiserfs_find_actor+0} 
<ffffffff80112b3d>{error_exit+0}
       <ffffffff801f5f20>{reiserfs_find_actor+0} 
<ffffffff801f5f20>{reiserfs_find_actor+0}
       <ffffffff801ba763>{find_inode+35} 
<ffffffff801ef692>{linear_search_in_dir_item+402}
       <ffffffff801f5f20>{reiserfs_find_actor+0} 
<ffffffff801f5df0>{reiserfs_init_locked_inode+0}
       <ffffffff801bbb12>{iget5_locked+290} 
<ffffffff801f5fa2>{reiserfs_iget+82}
       <ffffffff801efb1a>{reiserfs_lookup+442} 
<ffffffff801a75a3>{real_lookup+131}
       <ffffffff801a7a99>{do_lookup+105} 
<ffffffff801a8a19>{link_path_walk+3881}
       <ffffffff8016e320>{poison_obj+48} <ffffffff801a90be>{path_lookup+494}
       <ffffffff801a928e>{__user_walk+62} <ffffffff801a1720>{vfs_lstat+32}
       <ffffffff801a1b5f>{sys_newlstat+31} 
<ffffffff8011221a>{system_call+126}

lib/dec_and_lock.c:32: spin_lock(fs/inode.c:ffffffff8069c820) already 
locked by fs/inode.c/775
Unable to handle kernel paging request at 0000000a00000000 RIP:
<ffffffff801ba763>{find_inode+35}
PML4 4f20067 PGD 0
Oops: 0000 [2] PREEMPT
CPU 0
Modules linked in: ipt_REJECT iptable_filter iptable_mangle 
ipt_MASQUERADE iptable_nat ip_conntrack ip_tables
Pid: 29539, comm: gmake Not tainted 2.6.7
RIP: 0010:[<ffffffff801ba763>] <ffffffff801ba763>{find_inode+35}
RSP: 0018:0000010028399b78  EFLAGS: 00010206
RAX: 0000000a00000000 RBX: 0000000a00000000 RCX: 0000010028399c00
RDX: ffffffff801f5f20 RSI: 000001003fe7ea40 RDI: 000001003f82b578
RBP: 000001003f82b578 R08: 0000010028399c00 R09: 0000010009798150
R10: 0000000000000001 R11: 0000000000000246 R12: 000001003f82b578
R13: 000001003fe7ea40 R14: 0000010028399c00 R15: ffffffff801f5f20
FS:  0000002a95aa4090(0000) GS:ffffffff807fc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000a00000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process gmake (pid: 29539, threadinfo 0000010028398000, task 
00000100219560b0)
Stack: 000001002113b0e0 0000010028399c38 000001003f82b578 000001003fe7ea40
       0000010028399c00 ffffffff801f5f20 ffffffff801f5df0 ffffffff801bbb12
       0000000000000004 0000010028399c38
Call Trace:<ffffffff801f5f20>{reiserfs_find_actor+0} 
<ffffffff801f5df0>{reiserfs_init_locked_inode+0}
       <ffffffff801bbb12>{iget5_locked+290} 
<ffffffff801f5fa2>{reiserfs_iget+82}
       <ffffffff801efb1a>{reiserfs_lookup+442} 
<ffffffff801a75a3>{real_lookup+131}
       <ffffffff801a7a99>{do_lookup+105} 
<ffffffff801a8a19>{link_path_walk+3881}
       <ffffffff8016e320>{poison_obj+48} <ffffffff801a90be>{path_lookup+494}
       <ffffffff801a928e>{__user_walk+62} <ffffffff801a16c3>{vfs_stat+35}
       <ffffffff801a1b0f>{sys_newstat+31} 
<ffffffff8011221a>{system_call+126}


Code: 48 8b 03 0f 18 08 4c 39 a3 80 01 00 00 75 23 4c 89 f6 48 89
RIP <ffffffff801ba763>{find_inode+35} RSP <0000010028399b78>
CR2: 0000000a00000000
 <6>note: gmake[29539] exited with preempt_count 2
bad: scheduling while atomic!

Call Trace:<ffffffff8053795e>{schedule+94} 
<ffffffff80179d5a>{zap_pmd_range+186}
       <ffffffff8017a03c>{unmap_vmas+572} <ffffffff80180b05>{exit_mmap+293}
       <ffffffff80139600>{mmput+272} <ffffffff80140fdf>{do_exit+815}
       <ffffffff8011391d>{oops_end+205} 
<ffffffff80127ab5>{do_page_fault+1109}
       <ffffffff80173bc7>{mark_page_accessed+39} 
<ffffffff8019748c>{__find_get_block+252}
       <ffffffff801f5f20>{reiserfs_find_actor+0} 
<ffffffff80112b3d>{error_exit+0}
       <ffffffff801f5f20>{reiserfs_find_actor+0} 
<ffffffff801f5f20>{reiserfs_find_actor+0}
       <ffffffff801ba763>{find_inode+35} 
<ffffffff801ef692>{linear_search_in_dir_item+402}
       <ffffffff801f5f20>{reiserfs_find_actor+0} 
<ffffffff801f5df0>{reiserfs_init_locked_inode+0}
       <ffffffff801bbb12>{iget5_locked+290} 
<ffffffff801f5fa2>{reiserfs_iget+82}
       <ffffffff801efb1a>{reiserfs_lookup+442} 
<ffffffff801a75a3>{real_lookup+131}
       <ffffffff801a7a99>{do_lookup+105} 
<ffffffff801a8a19>{link_path_walk+3881}
       <ffffffff8016e320>{poison_obj+48} <ffffffff801a90be>{path_lookup+494}
       <ffffffff801a928e>{__user_walk+62} <ffffffff801a16c3>{vfs_stat+35}
       <ffffffff801a1b0f>{sys_newstat+31} 
<ffffffff8011221a>{system_call+126}

fs/fs-writeback.c:96: spin_lock(fs/inode.c:ffffffff8069c820) already 
locked by fs/inode.c/775


--------------050508030904020706010700
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------050508030904020706010700--
