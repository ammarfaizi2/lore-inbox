Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTAVOVC>; Wed, 22 Jan 2003 09:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbTAVOVC>; Wed, 22 Jan 2003 09:21:02 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:60074 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S261292AbTAVOVB>; Wed, 22 Jan 2003 09:21:01 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 22 Jan 2003 15:38:58 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.59 oops for sale
Message-ID: <20030122143858.GB6352@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Triggered by trying to boot a (i386) user mode linux system on a x86-64
host, perfectly reproducable.  Log attached below, more info available
on request.

  Gerd

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at buffer:1255
invalid operand: 0000
CPU 0 
Pid: 1259, comm: linux-2.4.19-47 Not tainted
RIP: 0010:[<ffffffff80160c1e>] <ffffffff80160c1e>{__find_get_block+30}
RSP: 0000:0000010017947868  EFLAGS: 00010002
RAX: 0000000000000001 RBX: 000001001fcfe980 RCX: 0000010017947948
RDX: 0000000000001000 RSI: 000000000027f806 RDI: 000001001fcfe980
RBP: 000000000027f806 R08: 0000010017947940 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000010017947940 R14: 000001001f5e6e00 R15: 0000010017947948
FS:  0000000000000000(0000) GS:ffffffff803afd00(0000) knlGS:000000006f6e6962
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00000000a09ff000 CR3: 0000000000101000 CR4: 00000000000006a0
Process linux-2.4.19-47 (pid: 1259, stackpage=10017b7f500)
Stack: 0000000000000000 0000000000000002 000001001fcfe980 ffffffff80160cf0 
       0000010017947948 0000000000000002 00000100179479a8 ffffffff80160d29 
       0000000000000000 ffffffff8018e2d4 
Call Trace:<ffffffff80160cf0>{__getblk+32} <ffffffff80160d29>{__bread+9} 
       <ffffffff8018e2d4>{ext3_get_branch+100} <ffffffff8018ea01>{ext3_get_block_handle+209} 
       <ffffffff8017a9b3>{do_mpage_readpage+211} <ffffffff8018ec10>{ext3_get_block+0} 
       <ffffffff801b22c3>{radix_tree_node_alloc+19} <ffffffff801b2499>{radix_tree_insert+121} 
       <ffffffff8017ac7f>{mpage_readpages+159} <ffffffff8018ec10>{ext3_get_block+0} 
       <ffffffff8014af14>{read_pages+68} <ffffffff80149337>{buffered_rmqueue+231} 
       <ffffffff801493df>{__alloc_pages+143} <ffffffff8014b126>{do_page_cache_readahead+294} 
       <ffffffff8014b286>{page_cache_readahead+278} <ffffffff8014701f>{filemap_nopage+223} 
       <ffffffff80151f71>{do_no_page+113} <ffffffff801522b0>{handle_mm_fault+208} 
       <ffffffff8011a8f3>{do_page_fault+387} <ffffffff8011048a>{do_signal+170} 
       <ffffffff8013c721>{sys_rt_sigprocmask+193} <ffffffff80110ffd>{error_exit+0} 
       

Code: 0f 0b f3 18 2b 80 ff ff ff ff e7 04 66 66 90 66 66 90 49 c7 
 


----- End forwarded message -----

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in "Melanie"
