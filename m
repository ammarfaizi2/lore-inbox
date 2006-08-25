Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWHYW2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWHYW2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 18:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWHYW2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 18:28:01 -0400
Received: from web36706.mail.mud.yahoo.com ([209.191.85.40]:30107 "HELO
	web36706.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750945AbWHYW2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 18:28:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RKY1AN9C1HOE8Kkc3DT/CuSIeoTU/NT4WG9Qjj5oxycQwbfdD28sqYi0z44ayHLtfQcrbq5MZPU54+FMnB4rAeyAbDLAaznwKRswZf+hoHY7ox+265acvrWy+OTV5PpyFZHME1I5V0U5sfByOJiK4DK+8+SpDJ7blJwaEbhdhS8=  ;
Message-ID: <20060825222759.61157.qmail@web36706.mail.mud.yahoo.com>
Date: Fri, 25 Aug 2006 15:27:59 -0700 (PDT)
From: Robinson Tiemuqinke <hahaha_30k@yahoo.com>
Subject: Linux black screen problem with kernel 2.6.16.23 -- out of (low) memory?
To: fedora-list@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I compiled valnilla kernel 2.6.16.23 on 64bit Fedora
Core 4 months ago. 

 the kernels runs well for a lot of machines for
months but weeks ago 4 machines dead with a black
screen, we could ping them but failed to ssh into
them.

 After power-cycled the 4 machines, I have found the
following in the /var/log/messages. -- it looks that
there were still enough free memory, though.

 Please help explain the output, and possibly what's
the correct way to fix/workaround it. Thanks a lot.

Aug  6 00:10:56 node2001 kernel: oom-killer:
gfp_mask=0xd0, order=1
Aug  6 00:10:56 node2001 kernel:
Aug  6 00:10:56 node2001 kernel: Call Trace:
<ffffffff80166807>{out_of_memory+55}
<ffffffff8016905c>{__alloc_pages+604}
Aug  6 00:10:56 node2001 kernel:       
<ffffffff8016872e>{__get_free_pages+14}
<ffffffff80136f65>{copy_process+261}
Aug  6 00:10:56 node2001 kernel:       
<ffffffff80119abf>{flush_tlb_mm+223}
<ffffffff80171104>{free_pgtables+148}
Aug  6 00:10:56 node2001 kernel:       
<ffffffff80138475>{do_fork+261}
<ffffffff8010ad1e>{system_call+126}
Aug  6 00:10:56 node2001 kernel:       
<ffffffff8010b02b>{ptregscall_common+103}
Aug  6 00:10:56 node2001 kernel: Mem-info:
Aug  6 00:10:56 node2001 kernel: Node 0 DMA per-cpu:
Aug  6 00:10:56 node2001 kernel: cpu 0 hot: high 0,
batch 1 used:0
Aug  6 00:10:56 node2001 kernel: cpu 0 cold: high 0,
batch 1 used:0
Aug  6 00:10:56 node2001 kernel: Node 0 DMA32 per-cpu:
Aug  6 00:10:56 node2001 kernel: cpu 0 hot: high 186,
batch 31 used:83
Aug  6 00:10:57 node2001 kernel: cpu 0 cold: high 62,
batch 15 used:61
Aug  6 00:10:58 node2001 kernel: Node 0 Normal
per-cpu: empty
Aug  6 00:10:58 node2001 kernel: Node 0 HighMem
per-cpu: empty
Aug  6 00:10:59 node2001 kernel: Free pages:    
3266788kB (0kB HighMem)
Aug  6 00:10:59 node2001 kernel: Active:1227
inactive:8695 dirty:0 writeback:7947 unstable:0
free:816697 slab:4935 mapped:1238 pagetables:604
Aug  6 00:10:59 node2001 kernel: Node 0 DMA
free:10576kB min:20kB low:24kB high:28kB active:0kB
inactive:0kB present:10216kB pages_scanned:26164
all_unreclaimable? yes
Aug  6 00:10:59 node2001 kernel: lowmem_reserve[]: 0
3266 3266 3266


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
