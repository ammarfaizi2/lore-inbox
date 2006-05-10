Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWEJOy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWEJOy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWEJOy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:54:28 -0400
Received: from web51014.mail.yahoo.com ([206.190.39.79]:39278 "HELO
	web51014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964829AbWEJOy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:54:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XoK0Sp+12cj8qnME/NeU10duRqv5B8eUK/pu0hmuWVpoH8B7S9ZkVhmmgJKYiYNmKP2QlxB+XYwEa1WDrZXSkbi/DKBQLaeUkC1drtrYpF8mLse5Sg4bhoPGcaYMFV2ocrEozKBGgEu2RslOZJLTmOLZ/WdWwN7NcmPkja2i1Z0=  ;
Message-ID: <20060510145426.88957.qmail@web51014.mail.yahoo.com>
Date: Wed, 10 May 2006 07:54:26 -0700 (PDT)
From: Matthew L Foster <mfoster167@yahoo.com>
Subject: BUG 2.6.17-rc3-git8
To: linux-kernel@vger.kernel.org
Cc: mfoster167@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this in the log this morning. Dunno if it's relevant but I don't have swap enabled in my
config.

BUG: unable to handle kernel paging request at virtual address 04000004
 printing eip:
c015568b
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in:
CPU:    0
EIP:    0060:[<c015568b>]    Not tainted VLI
EFLAGS: 00010206   (2.6.17-rc3-git8 #10) 
EIP is at prune_dcache+0xbf/0x138
eax: 04000000   ebx: d895122c   ecx: d8951250   edx: c14553cc
esi: d8951238   edi: 00000050   ebp: dff3aed8   esp: dff3aecc
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 127, threadinfo=dff3a000 task=dff360d0)
Stack: <0>00006720 dffeeb00 00000081 dff3aee0 c015571e dff3af18 c0132e82 00000080 
       000000d0 00000000 000000d0 0019c800 00000000 0019c800 00000080 00000000 
       00000000 c02f9720 c02f9720 dff3af98 c0133cd7 00000000 000000d0 0001d60d 
Call Trace:
 <c01032f8> show_stack_log_lvl+0x8c/0x96   <c0103457> show_registers+0x120/0x18c
 <c0103620> die+0x15d/0x229   <c010f571> do_page_fault+0x444/0x527
 <c0102dab> error_code+0x4f/0x54   <c015571e> shrink_dcache_memory+0x1a/0x32
 <c0132e82> shrink_slab+0xd8/0x13f   <c0133cd7> balance_pgdat+0x1f9/0x2fc
 <c0133f10> kswapd+0xdd/0xdf   <c0101005> kernel_thread_helper+0x5/0xb
Code: c0 ff 4a 14 8b 42 08 a8 08 74 72 e8 82 10 15 00 eb 6b a8 10 75 1f 83 c8 10 8d 71 e8 89 43 04
8b 41 e8 8b 56 04 85 c0 89 02 74 03 <89> 50 04 c7 46 04 00 02 20 00 8d 4b 2c 8b 53 2c 8b 41 04 89
42 
EIP: [<c015568b>] prune_dcache+0xbf/0x138 SS:ESP 0068:dff3aecc
 <6>note: kswapd0[127] exited with preempt_count 2




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
