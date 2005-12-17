Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVLQUd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVLQUd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVLQUd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:33:56 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:31757 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964794AbVLQUdz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:33:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X/F2QUYwFV0bYWT1D/VXd7BNVVaTGsam+8+eHctlPFNSN2kX62Vc0BFvPQJuJjvpSanQCfgsYM1L5YL0GfrUG4d8z9T1L3i/LmekLHtiHcZxRHtZVRHnDIHgxmCd3jB7pS+jUqQheCr+zxhpF5AQOaShL/rgEPb7PLofikifr4w=
Message-ID: <a44ae5cd0512171233w634430b5lc075b9c3345ea445@mail.gmail.com>
Date: Sat, 17 Dec 2005 12:33:54 -0800
From: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-mm3 -- BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1
In-Reply-To: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd0512150035j1e1a032bpe8b271069ad5d008@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other BUG output.

[17179578.524000] BUG: using smp_processor_id() in preemptible
[00000001] code: swapper/1
[17179578.536000] caller is mod_page_state_offset+0x12/0x28
[17179578.536000]  [<c100377b>] dump_stack+0x16/0x1a
[17179578.548000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179578.560000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179578.572000]  [<c1054734>] kmem_getpages+0x67/0x8e
[17179578.584000]  [<c105591e>] cache_grow+0xa2/0x153
[17179578.596000]  [<c1055ea6>] cache_alloc_refill+0x214/0x258
[17179578.608000]  [<c10562b3>] kmem_cache_alloc+0x6a/0x85
[17179578.616000]  [<c109bad8>] ext3_alloc_inode+0x10/0x44
[17179578.628000]  [<c106e975>] alloc_inode+0x15/0x197
[17179578.640000]  [<c106f594>] get_new_inode_fast+0xf/0xff
[17179578.652000]  [<c106f9e2>] iget_locked+0x52/0x5d
[17179578.664000]  [<c10991de>] ext3_lookup+0x45/0x93
[17179578.676000]  [<c10653e9>] real_lookup+0x65/0xce
[17179578.688000]  [<c1065a97>] do_lookup+0x50/0x84
[17179578.700000]  [<c1065dab>] __link_path_walk+0x2e0/0x44e
[17179578.712000]  [<c1065f6b>] link_path_walk+0x52/0xcb
[17179578.724000]  [<c10662fc>] path_lookup+0x14f/0x189
[17179578.736000]  [<c106636e>] __path_lookup_intent_open+0x38/0x68
[17179578.748000]  [<c10663b4>] path_lookup_open+0x16/0x18
[17179578.760000]  [<c1066baa>] open_namei+0x6c/0x404
[17179578.772000]  [<c10583ad>] filp_open+0x23/0x3a
[17179578.784000]  [<c1058655>] do_sys_open+0x3c/0xae
[17179578.792000]  [<c10586d8>] sys_open+0x11/0x13
[17179578.804000]  [<c1000404>] init+0xed/0x185
[17179578.816000]  [<c1000eb5>] kernel_thread_helper+0x5/0xb


[17179616.624000] BUG: using smp_processor_id() in preemptible
[00000001] code: mount/2140
[17179616.640000] caller is mod_page_state_offset+0x12/0x28
[17179616.640000]  [<c100377b>] dump_stack+0x16/0x1a
[17179616.656000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179616.668000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179616.684000]  [<c1054734>] kmem_getpages+0x67/0x8e
[17179616.700000]  [<c105591e>] cache_grow+0xa2/0x153
[17179616.712000]  [<c1055ea6>] cache_alloc_refill+0x214/0x258
[17179616.728000]  [<c10562b3>] kmem_cache_alloc+0x6a/0x85
[17179616.744000]  [<f91bc3be>] ntfs_alloc_big_inode+0x10/0x3d [ntfs]
[17179616.756000]  [<c106e975>] alloc_inode+0x15/0x197
[17179616.772000]  [<c106f3d3>] new_inode+0x17/0x92
[17179616.788000]  [<f91c34f2>] ntfs_fill_super+0x262/0x6b1 [ntfs]
[17179616.804000]  [<c105f529>] get_sb_bdev+0xd3/0x112
[17179616.816000]  [<f91c3977>] ntfs_get_sb+0x19/0x1b [ntfs]
[17179616.832000]  [<c105f741>] do_kern_mount+0x85/0x140
[17179616.848000]  [<c107261d>] do_new_mount+0x41/0x70
[17179616.860000]  [<c1072bcf>] do_mount+0x178/0x198
[17179616.876000]  [<c1072ead>] sys_mount+0x72/0xaa
[17179616.888000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17179631.608000] BUG: using smp_processor_id() in preemptible
[00000001] code: echo/2536
[17179631.608000] caller is mod_page_state_offset+0x12/0x28
[17179631.608000]  [<c100377b>] dump_stack+0x16/0x1a
[17179631.620000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179631.636000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179631.648000]  [<c104a188>] __handle_mm_fault+0x1f/0x18e
[17179631.664000]  [<c1013e74>] do_page_fault+0x17e/0x4ae
[17179631.680000]  [<c100344f>] error_code+0x4f/0x54
[17179631.692000]  [<c107da63>] padzero+0x1e/0x2f
[17179631.708000]  [<c107ea8f>] load_elf_binary+0x750/0xae7
[17179631.720000]  [<c106325e>] search_binary_handler+0xcb/0x2a8
[17179631.736000]  [<c10635a7>] do_execve+0x16c/0x231
[17179631.748000]  [<c1001725>] sys_execve+0x2b/0x70
[17179631.764000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17179636.608000] BUG: using smp_processor_id() in preemptible
[00000001] code: hald/3167
[17179636.636000] caller is mod_page_state_offset+0x12/0x28
[17179636.636000]  [<c100377b>] dump_stack+0x16/0x1a
[17179636.652000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179636.668000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179636.680000]  [<c1054734>] kmem_getpages+0x67/0x8e
[17179636.696000]  [<c105591e>] cache_grow+0xa2/0x153
[17179636.712000]  [<c1055ea6>] cache_alloc_refill+0x214/0x258
[17179636.724000]  [<c10562b3>] kmem_cache_alloc+0x6a/0x85
[17179636.740000]  [<c106d905>] d_alloc+0x19/0x18e
[17179636.756000]  [<c10653ce>] real_lookup+0x4a/0xce
[17179636.768000]  [<c1065a97>] do_lookup+0x50/0x84
[17179636.784000]  [<c1065dab>] __link_path_walk+0x2e0/0x44e
[17179636.800000]  [<c1065f6b>] link_path_walk+0x52/0xcb
[17179636.812000]  [<c10662fc>] path_lookup+0x14f/0x189
[17179636.828000]  [<c1066548>] __user_walk+0x2b/0x3e
[17179636.844000]  [<c1061ab2>] sys_readlink+0x22/0x93
[17179636.856000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17179641.612000] BUG: using smp_processor_id() in preemptible
[00000001] code: Xorg/3270
[17179641.612000] caller is mod_page_state_offset+0x12/0x28
[17179641.612000]  [<c100377b>] dump_stack+0x16/0x1a
[17179641.612000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179641.612000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179641.612000]  [<c1054734>] kmem_getpages+0x67/0x8e
[17179641.612000]  [<c105591e>] cache_grow+0xa2/0x153
[17179641.612000]  [<c1055ea6>] cache_alloc_refill+0x214/0x258
[17179641.612000]  [<c10562b3>] kmem_cache_alloc+0x6a/0x85
[17179641.612000]  [<c109bad8>] ext3_alloc_inode+0x10/0x44
[17179641.612000]  [<c106e975>] alloc_inode+0x15/0x197
[17179641.612000]  [<c106f594>] get_new_inode_fast+0xf/0xff
[17179641.612000]  [<c106f9e2>] iget_locked+0x52/0x5d
[17179641.612000]  [<c10991de>] ext3_lookup+0x45/0x93
[17179641.612000]  [<c10653e9>] real_lookup+0x65/0xce
[17179641.612000]  [<c1065a97>] do_lookup+0x50/0x84
[17179641.612000]  [<c1065c9b>] __link_path_walk+0x1d0/0x44e
[17179641.612000]  [<c1065f6b>] link_path_walk+0x52/0xcb
[17179641.612000]  [<c10662fc>] path_lookup+0x14f/0x189
[17179641.612000]  [<c1066548>] __user_walk+0x2b/0x3e
[17179641.612000]  [<c10616e2>] vfs_stat+0x1a/0x42
[17179641.612000]  [<c1061c1f>] sys_stat64+0x13/0x29
[17179641.612000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17179651.612000] BUG: using smp_processor_id() in preemptible
[00000001] code: gdmgreeter/3925
[17179651.612000] caller is mod_page_state_offset+0x12/0x28
[17179651.612000]  [<c100377b>] dump_stack+0x16/0x1a
[17179651.612000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179651.612000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179651.612000]  [<c104a188>] __handle_mm_fault+0x1f/0x18e
[17179651.612000]  [<c1013e74>] do_page_fault+0x17e/0x4ae
[17179651.612000]  [<c100344f>] error_code+0x4f/0x54
[17179651.612000]  [<c107da63>] padzero+0x1e/0x2f
[17179651.612000]  [<c107e082>] load_elf_interp+0x1e4/0x2a5
[17179651.612000]  [<c107eaeb>] load_elf_binary+0x7ac/0xae7
[17179651.612000]  [<c106325e>] search_binary_handler+0xcb/0x2a8
[17179651.612000]  [<c10635a7>] do_execve+0x16c/0x231
[17179651.612000]  [<c1001725>] sys_execve+0x2b/0x70
[17179651.612000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17179676.632000] BUG: using smp_processor_id() in preemptible
[00000001] code: bonobo-activati/4794
[17179676.632000] caller is mod_page_state_offset+0x12/0x28
[17179676.632000]  [<c100377b>] dump_stack+0x16/0x1a
[17179676.632000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179676.632000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179676.632000]  [<c104a188>] __handle_mm_fault+0x1f/0x18e
[17179676.632000]  [<c1013e74>] do_page_fault+0x17e/0x4ae
[17179676.632000]  [<c100344f>] error_code+0x4f/0x54
[17179676.632000]  [<c103e584>] do_generic_mapping_read+0x151/0x3c8
[17179676.632000]  [<c103ea5f>] __generic_file_aio_read+0x18b/0x1e1
[17179676.632000]  [<c103eaf7>] generic_file_aio_read+0x42/0x49
[17179676.632000]  [<c1058df1>] do_sync_read+0x98/0xc9
[17179676.632000]  [<c1058ec7>] vfs_read+0xa5/0x145
[17179676.632000]  [<c10591af>] sys_read+0x3a/0x61
[17179676.632000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17179746.608000] BUG: using smp_processor_id() in preemptible
[00000001] code: bzip2/5271
[17179746.608000] caller is mod_page_state_offset+0x12/0x28
[17179746.608000]  [<c100377b>] dump_stack+0x16/0x1a
[17179746.608000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179746.608000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179746.608000]  [<c104a188>] __handle_mm_fault+0x1f/0x18e
[17179746.608000]  [<c1013e74>] do_page_fault+0x17e/0x4ae
[17179746.608000]  [<c100344f>] error_code+0x4f/0x54
[17179746.608000]  [<c106209f>] copy_strings+0x50/0x1c0
[17179746.608000]  [<c1063595>] do_execve+0x15a/0x231
[17179746.608000]  [<c1001725>] sys_execve+0x2b/0x70
[17179746.608000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17179761.932000] BUG: using smp_processor_id() in preemptible
[00000001] code: apt-get/5333
[17179761.932000] caller is mod_page_state_offset+0x12/0x28
[17179761.932000]  [<c100377b>] dump_stack+0x16/0x1a
[17179761.932000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179761.932000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179761.932000]  [<c104a188>] __handle_mm_fault+0x1f/0x18e
[17179761.932000]  [<c1013e74>] do_page_fault+0x17e/0x4ae
[17179761.932000]  [<c100344f>] error_code+0x4f/0x54
[17179761.932000]  [<c112a77b>] tty_read+0x62/0xaa
[17179761.932000]  [<c1058ec7>] vfs_read+0xa5/0x145
[17179761.932000]  [<c10591af>] sys_read+0x3a/0x61
[17179761.932000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17179806.628000] BUG: using smp_processor_id() in preemptible
[00000001] code: dpkg/5376
[17179806.628000] caller is mod_page_state_offset+0x12/0x28
[17179806.628000]  [<c100377b>] dump_stack+0x16/0x1a
[17179806.628000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17179806.628000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17179806.628000]  [<c1054734>] kmem_getpages+0x67/0x8e
[17179806.628000]  [<c105591e>] cache_grow+0xa2/0x153
[17179806.628000]  [<c1055ea6>] cache_alloc_refill+0x214/0x258
[17179806.628000]  [<c10562b3>] kmem_cache_alloc+0x6a/0x85
[17179806.628000]  [<c105d2bd>] alloc_buffer_head+0x13/0x63
[17179806.628000]  [<c105af22>] alloc_page_buffers+0x16/0x8d
[17179806.628000]  [<c105b7c2>] create_empty_buffers+0x17/0x8d
[17179806.628000]  [<c105bbbc>] __block_prepare_write+0x71/0x35e
[17179806.628000]  [<c105c50b>] block_prepare_write+0x1b/0x2c
[17179806.628000]  [<c1095b5d>] ext3_prepare_write+0x7b/0x11e
[17179806.628000]  [<c103fa83>] generic_file_buffered_write+0x1dd/0x4c5
[17179806.628000]  [<c10400d4>] __generic_file_aio_write_nolock+0x369/0x3a6
[17179806.628000]  [<c1040313>] generic_file_aio_write+0x67/0xbe
[17179806.628000]  [<c1093c56>] ext3_file_write+0x24/0x94
[17179806.628000]  [<c1058fff>] do_sync_write+0x98/0xc9
[17179806.628000]  [<c10590d5>] vfs_write+0xa5/0x145
[17179806.628000]  [<c1059210>] sys_write+0x3a/0x61
[17179806.628000]  [<c10028cf>] sysenter_past_esp+0x54/0x75


[17183555.412000] BUG: using smp_processor_id() in preemptible
[00000001] code: kjournald/819
[17183555.412000] caller is mod_page_state_offset+0x12/0x28
[17183555.412000]  [<c100377b>] dump_stack+0x16/0x1a
[17183555.412000]  [<c10efaaf>] debug_smp_processor_id+0x77/0x90
[17183555.412000]  [<c1042324>] mod_page_state_offset+0x12/0x28
[17183555.412000]  [<c10e1947>] submit_bio+0x4a/0xaf
[17183555.412000]  [<c105cebf>] submit_bh+0xc5/0xe7
[17183555.412000]  [<c105cf6a>] ll_rw_block+0x89/0xb2
[17183555.412000]  [<c10a56e8>] journal_commit_transaction+0x418/0xf2c
[17183555.412000]  [<c10a80ba>] kjournald+0xb5/0x1e6
[17183555.412000]  [<c1000eb5>] kernel_thread_helper+0x5/0xb
