Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423099AbWJZLCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423099AbWJZLCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423118AbWJZLCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:02:53 -0400
Received: from ip-213-135-240-128.static.luxdsl.pt.lu ([213.135.240.128]:39178
	"EHLO server.intern.prnet.org") by vger.kernel.org with ESMTP
	id S1423099AbWJZLCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:02:52 -0400
Message-ID: <58488.212.24.212.169.1161860570.squirrel@server.prnet.org>
Date: Thu, 26 Oct 2006 13:02:50 +0200 (CEST)
Subject: 2.6.18: unable to handle kernel paging request at virtual address 
     e5e9ec24
From: admin@prnet.org
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get repeated times (approximately every 2 days) a similiar exception
with kernel
2.6.18 ?

I never noticed a problem like this using 2.6.17.

Does anyone have any suggestion what could go wrong ?

Thanks in advance
Bye,
David Arendt

Oct 25 19:54:26 server kernel: BUG: unable to handle kernel paging request at
virtual address e5e9ec24
Oct 25 19:54:26 server kernel:  printing eip:
Oct 25 19:54:26 server kernel: c014f7b6
Oct 25 19:54:26 server kernel: *pde = 00000000
Oct 25 19:54:26 server kernel: Oops: 0002 [#1]
Oct 25 19:54:26 server kernel: PREEMPT
Oct 25 19:54:26 server kernel: Modules linked in: ivtv_fb ivtv tveeprom
saa7127
saa7115 msp3400 tuner capi capifs fcpci kernelcapi cx2341x vmnet vmmon
Oct 25 19:54:26 server kernel: CPU:    0
Oct 25 19:54:26 server kernel: EIP:    0060:[free_block+130/273]   
Tainted: P      VLI
Oct 25 19:54:26 server kernel: EFLAGS: 00010082   (2.6.18server #3)
Oct 25 19:54:26 server kernel: EIP is at free_block+0x82/0x111
Oct 25 19:54:26 server kernel: eax: df77f000   ebx: dfe186c0   ecx:
d4d29000   edx:
e5e9ec20
Oct 25 19:54:26 server kernel: esi: d4d29080   edi: c14dfc40   ebp:
0000000a   esp:
dfe11e60
Oct 25 19:54:26 server kernel: ds: 007b   es: 007b   ss: 0068
Oct 25 19:54:26 server kernel: Process kswapd0 (pid: 148, ti=dfe10000
task=c14da030
task.ti=dfe10000)
Oct 25 19:54:27 server kernel: Stack: c02234f2 0000001b dff741d0 c14d2500
0000001b
c14dfc40 dff741d0 c014f952
Oct 25 19:54:27 server kernel:        00000000 00000001 db65ae18 dff741c0
dfe11ef0
dff741c0 00000246 db65ae00
Oct 25 19:54:27 server kernel:        0000004b c014fa95 db65ae20 db65ae18
dfe11ef0
c0234291 c14dfc40 db65ae00
Oct 25 19:54:27 server kernel: Call Trace:
Oct 25 19:54:27 server kernel:  [xfs_finish_reclaim+44/369]
xfs_finish_reclaim+0x2c/0x171
Oct 25 19:54:27 server kernel:  [cache_flusharray+71/206]
cache_flusharray+0x47/0xce
Oct 25 19:54:27 server kernel:  [kmem_cache_free+88/112]
kmem_cache_free+0x58/0x70
Oct 25 19:54:27 server kernel:  [xfs_fs_destroy_inode+27/31]
xfs_fs_destroy_inode+0x1b/0x1f
Oct 25 19:54:27 server kernel:  [dispose_list+132/274]
dispose_list+0x84/0x112
Oct 25 19:54:27 server kernel:  [__activate_task+25/43]
__activate_task+0x19/0x2b
Oct 25 19:54:27 server kernel:  [shrink_icache_memory+372/590]
shrink_icache_memory+0x174/0x24e
Oct 25 19:54:27 server kernel:  [shrink_slab+321/427] shrink_slab+0x141/0x1ab
Oct 25 19:54:27 server kernel:  [kswapd+813/1048] kswapd+0x32d/0x418
Oct 25 19:54:27 server kernel:  [autoremove_wake_function+0/75]
autoremove_wake_function+0x0/0x4b
Oct 25 19:54:27 server kernel:  [kswapd+0/1048] kswapd+0x0/0x418
Oct 25 19:54:27 server kernel:  [kthread+225/229] kthread+0xe1/0xe5
Oct 25 19:54:27 server kernel:  [kthread+0/229] kthread+0x0/0xe5
Oct 25 19:54:27 server kernel:  [kernel_thread_helper+5/11]
kernel_thread_helper+0x5/0xb
Oct 25 19:54:27 server kernel: Code: 03 15 3c 16 4b c0 8b 02 f6 c4 40 0f
85 90 00 00
00 8b 02 84 c0 0f 89 8e 00 00 00 8b 4a 1c 8b 54 24 20 8b 5c 97 14 8b 11 8b
41 04
<89> 42 04 89 10 c7 01 00 01 10 00 c7 41 04 0
0 02 20 00 2b 71 0c





