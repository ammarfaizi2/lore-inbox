Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267783AbTBVDEA>; Fri, 21 Feb 2003 22:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267784AbTBVDEA>; Fri, 21 Feb 2003 22:04:00 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:16970 "EHLO
	dyn9-47-17-83.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id <S267783AbTBVDD6>; Fri, 21 Feb 2003 22:03:58 -0500
Message-ID: <3E56E58D.6B047A23@us.ibm.com>
Date: Fri, 21 Feb 2003 18:50:53 -0800
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.62 Oops during nfs mount 
Content-Type: multipart/mixed;
 boundary="------------4E701B19BF0901ECCAA1BA1B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4E701B19BF0901ECCAA1BA1B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------4E701B19BF0901ECCAA1BA1B
Content-Type: text/plain; charset=us-ascii;
 name="Oops.2562.nfsmount"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Oops.2562.nfsmount"

I get the following on 2.5.62 when I mount over NFS:

Feb 21 19:45:00 elm3b78 kernel: Oops: 0002
Feb 21 19:45:00 elm3b78 kernel: CPU:    6
Feb 21 19:45:00 elm3b78 kernel: EIP:    0060:[<c035c4c3>]    Not tainted
Feb 21 19:45:00 elm3b78 kernel: EFLAGS: 00010246
Feb 21 19:45:00 elm3b78 kernel: EIP is at rpc_depopulate+0x33/0x110
Feb 21 19:45:00 elm3b78 kernel: eax: 00000000   ebx: 0000006c   ecx: 0000006c   edx: f69f42c0
Feb 21 19:45:00 elm3b78 kernel: esi: f6bc9bf0   edi: f6bc9bf0   ebp: f6bc9c04   esp: f6bc9be0
Feb 21 19:45:00 elm3b78 kernel: ds: 007b   es: 007b   ss: 0068
Feb 21 19:45:00 elm3b78 kernel: Process mount (pid: 1193, threadinfo=f6bc8000 task=f668b920)
Feb 21 19:45:00 elm3b78 kernel: Stack: c036a428 00000077 c0157e30 00000000 f6bc9bf0 f6bc9bf0 f701ae60 f701ae60 
Feb 21 19:45:00 elm3b78 kernel:        f66c4dc0 f6bc9c3c c035ca15 f701ae60 f69f42c0 f7ff9b60 f6bc9ce8 00000000 
Feb 21 19:45:00 elm3b78 kernel:        f6bc9c30 00000010 00000001 00000000 f73dd540 f6bc9ce8 00000000 f6bc9c4c 
Feb 21 19:45:00 elm3b78 kernel: Call Trace:
Feb 21 19:45:01 elm3b78 kernel:  [<c0157e30>] lookup_hash+0x70/0xa0
Feb 21 19:45:01 elm3b78 kernel:  [<c035ca15>] rpc_rmdir+0x65/0xa0
Feb 21 19:45:01 elm3b78 kernel:  [<c034ddd6>] rpc_destroy_client+0x46/0x70
Feb 21 19:45:01 elm3b78 kernel:  [<c034de4b>] rpc_release_client+0x4b/0x60
Feb 21 19:45:01 elm3b78 kernel:  [<c0352957>] rpc_release_task+0x1a7/0x1d0
Feb 21 19:45:01 elm3b78 kernel:  [<c03522db>] __rpc_execute+0x35b/0x370
Feb 21 19:45:01 elm3b78 kernel:  [<c0119900>] default_wake_function+0x0/0x20
Feb 21 19:45:01 elm3b78 kernel:  [<c034dfe4>] rpc_call_sync+0x64/0xa0
Feb 21 19:45:01 elm3b78 kernel:  [<c034dff7>] rpc_call_sync+0x77/0xa0
Feb 21 19:45:01 elm3b78 kernel:  [<c0351440>] rpc_run_timer+0x0/0xa0
Feb 21 19:45:01 elm3b78 kernel:  [<c035941b>] rpc_register+0xcb/0x100
Feb 21 19:45:01 elm3b78 kernel:  [<c0354af4>] svc_register+0x94/0x100
Feb 21 19:45:01 elm3b78 kernel:  [<c0354714>] svc_create+0xd4/0xe0
Feb 21 19:45:01 elm3b78 kernel:  [<c01b5069>] lockd_up+0x69/0x130
Feb 21 19:45:01 elm3b78 kernel:  [<c01a28b4>] nfs_fill_super+0x364/0x390
Feb 21 19:45:01 elm3b78 kernel:  [<c01a434d>] nfs_get_sb+0x1ed/0x230
Feb 21 19:45:01 elm3b78 kernel:  [<c0151592>] do_kern_mount+0x42/0xa0
Feb 21 19:45:01 elm3b78 kernel:  [<c0164d23>] do_add_mount+0x73/0x170
Feb 21 19:45:01 elm3b78 kernel:  [<c01349b6>] __alloc_pages+0x96/0x2e0
Feb 21 19:45:01 elm3b78 kernel:  [<c0165037>] do_mount+0x147/0x160
Feb 21 19:45:01 elm3b78 kernel:  [<c01654b8>] sys_mount+0xa8/0x110
Feb 21 19:45:01 elm3b78 kernel:  [<c010909b>] syscall_call+0x7/0xb
Feb 21 19:45:01 elm3b78 kernel: 
Feb 21 19:45:01 elm3b78 kernel: Code: f0 ff 48 6c 0f 88 bf 09 00 00 59 5b f0 fe 0d 60 a6 47 c0 0f 

--------------4E701B19BF0901ECCAA1BA1B--

