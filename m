Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTFEOxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbTFEOxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:53:20 -0400
Received: from mail.ithnet.com ([217.64.64.8]:7954 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264728AbTFEOxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:53:19 -0400
Date: Thu, 5 Jun 2003 17:05:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030605170551.3d61b0d4.skraw@ithnet.com>
In-Reply-To: <20030524111608.GA4599@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030524111608.GA4599@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

It took some days to produce output for my freezing problem. This one is rc7+aic20030603:

Jun  5 16:53:55 admin kernel: Unable to handle kernel paging request at virtual address 8e30a7c5
Jun  5 16:53:55 admin kernel:  printing eip:
Jun  5 16:53:55 admin kernel: c013755e
Jun  5 16:53:55 admin kernel: *pde = 00000000
Jun  5 16:53:55 admin kernel: Oops: 0000
Jun  5 16:53:55 admin kernel: CPU:    0 
Jun  5 16:53:55 admin kernel: EIP:    0010:[kmem_cache_alloc_batch+78/272]    Not tainted
Jun  5 16:53:55 admin kernel: EIP:    0010:[<c013755e>]    Not tainted
Jun  5 16:53:55 admin kernel: EFLAGS: 00010006
Jun  5 16:53:55 admin kernel: eax: e62d70eb   ebx: e62d70eb   ecx: f57ae401   edx: 00000020
Jun  5 16:53:55 admin kernel: esi: 00000043   edi: 0000003a   ebp: c342b060   esp: e5e63a28
Jun  5 16:53:55 admin kernel: ds: 0018   es: 0018   ss: 0018
Jun  5 16:53:55 admin kernel: Process tar (pid: 7112, stackpage=e5e63000)
Jun  5 16:53:55 admin kernel: Stack: c342b068 c342b070 c342b060 00000246 00000020 e7420000 c01382eb c342b060
Jun  5 16:53:55 admin kernel:        c3461000 00000020 00000000 c342bdb8 00000000 e7420000 c013749c c342b060
Jun  5 16:53:55 admin kernel:        00000020 d3d05ec0 00000003 00000020 c342bdb8 00000246 00000020 e5e63b14
Jun  5 16:53:55 admin kernel: Call Trace:    [__kmem_cache_alloc+107/304] [kmem_cache_grow+508/624] [__kmem_cache_alloc+125/304] [get_mem_for_virtual_node+87/224] [fix_nodes+198/1008]
Jun  5 16:53:55 admin kernel: Call Trace:    [<c01382eb>] [<c013749c>] [<c01382fd>] [<c01846a7>] [<c0184bc6>]
Jun  5 16:53:55 admin kernel:   [reiserfs_paste_into_item+147/304] [reiserfs_get_block+1989/4800] [bh_action+106/112] [tasklet_hi_action+83/160] [smp_apic_timer_interrupt+264/304] [.text.lock.buffer+191/610]
Jun  5 16:53:55 admin kernel:   [<c0191ae3>] [<c017cca5>] [<c012252a>] [<c01223b3>] [<c0115d88>] [<c01474bd>]
Jun  5 16:53:55 admin kernel:   [getblk+109/128] [is_tree_node+100/112] [search_by_key+1824/3792] [__block_prepare_write+479/880] [block_prepare_write+51/144] [reiserfs_get_block+0/4800]
Jun  5 16:53:55 admin kernel:   [<c014447d>] [<c018e8f4>] [<c018f020>] [<c014503f>] [<c0145a23>] [<c017c4e0>]
Jun  5 16:53:55 admin kernel:   [generic_file_write+970/2128] [reiserfs_get_block+0/4800] [sys_write+155/384] [system_call+51/56]
Jun  5 16:53:55 admin kernel:   [<c013397a>] [<c017c4e0>] [<c0141d8b>] [<c010782f>]
Jun  5 16:53:55 admin kernel: 
Jun  5 16:53:55 admin kernel: Code: 8b 44 81 18 0f af da 8b 51 0c 89 41 14 01 d3 40 0f 84 89 00


Does this help?

Regards,
Stephan
