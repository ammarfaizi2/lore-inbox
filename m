Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261832AbTC0JKz>; Thu, 27 Mar 2003 04:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbTC0JKz>; Thu, 27 Mar 2003 04:10:55 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:45952 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261832AbTC0JKx>; Thu, 27 Mar 2003 04:10:53 -0500
Date: Thu, 27 Mar 2003 01:22:07 -0800
To: linux-kernel@vger.kernel.org
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: NFS/ReiserFS problems 2.5.64-mbj1
Message-ID: <20030327092207.GA1248@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NFS problems with reiserfs:

Mar 26 19:09:47 gnuppy kernel: Code:  Bad EIP value.
Mar 26 19:16:42 gnuppy kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Mar 26 19:16:42 gnuppy kernel:  printing eip:
Mar 26 19:16:42 gnuppy kernel: 00000000
Mar 26 19:16:42 gnuppy kernel: Oops: 0000
Mar 26 19:16:42 gnuppy kernel: CPU:    0
Mar 26 19:16:42 gnuppy kernel: EIP:    0060:[<00000000>]    Tainted: PF 
Mar 26 19:16:42 gnuppy kernel: EFLAGS: 00010202
Mar 26 19:16:42 gnuppy kernel: EIP is at 0x0
Mar 26 19:16:42 gnuppy kernel: eax: d5885dac   ebx: 00000005   ecx: c03ac868   edx: d5885d9c
Mar 26 19:16:42 gnuppy kernel: esi: d57e2610   edi: d7857800   ebp: d5885dc8   esp: d5885d84
Mar 26 19:16:42 gnuppy kernel: ds: 007b   es: 007b   ss: 0068
Mar 26 19:16:42 gnuppy kernel: Process nfsd (pid: 357, threadinfo=d5884000 task=d5617380)
Mar 26 19:16:42 gnuppy kernel: Stack: c01db943 d7857800 d5885dac d5885d9c d8b4aae0 d77e96a0 00000002 00000001 
Mar 26 19:16:42 gnuppy kernel:        00000000 d5f4ac60 00000004 00000002 0000001c 666e6967 d77e96a0 d57e2600 
Mar 26 19:16:42 gnuppy kernel:        46000000 d5885e24 d8b4afc9 d7857800 d57e2610 00000005 00000005 d8b4aae0 
Mar 26 19:16:42 gnuppy kernel: Call Trace:
Mar 26 19:16:42 gnuppy kernel:  [reiserfs_decode_fh+179/224] reiserfs_decode_fh+0xb3/0xe0
Mar 26 19:16:42 gnuppy kernel:  [<d8b4aae0>] nfsd_acceptable+0x0/0x110 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b4afc9>] fh_verify+0x3d9/0x5c0 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b4aae0>] nfsd_acceptable+0x0/0x110 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b4c472>] nfsd_open+0x42/0x160 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b4e4a0>] nfsd_readdir+0x40/0xf0 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [try_to_wake_up+313/336] try_to_wake_up+0x139/0x150
Mar 26 19:16:42 gnuppy kernel:  [__wake_up_common+58/96] __wake_up_common+0x3a/0x60
Mar 26 19:16:42 gnuppy kernel:  [<d8b4531c>] ip_table+0x7c/0x400 [sunrpc]
Mar 26 19:16:42 gnuppy kernel:  [<d8b4531c>] ip_table+0x7c/0x400 [sunrpc]
Mar 26 19:16:42 gnuppy kernel:  [<d8b356e1>] svcauth_unix_accept+0x271/0x2a0 [sunrpc]
Mar 26 19:16:42 gnuppy kernel:  [<d8b449e0>] ip_map_cache+0x0/0x48 [sunrpc]
Mar 26 19:16:42 gnuppy kernel:  [<d8b4a75f>] nfsd_proc_readdir+0x7f/0x130 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b52b70>] nfssvc_encode_entry+0x0/0xc0 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b527cc>] nfssvc_decode_readdirargs+0x4c/0x120 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b5d3e0>] nfsd_procedures2+0x240/0x288 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b484e7>] nfsd_dispatch+0xe7/0x200 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b3143a>] svc_process+0x4fa/0x690 [sunrpc]
Mar 26 19:16:42 gnuppy kernel:  [<d8b5d3e0>] nfsd_procedures2+0x240/0x288 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b5d428>] nfsd_version2+0x0/0x18 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b5cf00>] nfsd_program+0x0/0x20 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b48305>] nfsd+0x125/0x220 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [<d8b481e0>] nfsd+0x0/0x220 [nfsd]
Mar 26 19:16:42 gnuppy kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18
Mar 26 19:16:42 gnuppy kernel: 

-----------------

bill

