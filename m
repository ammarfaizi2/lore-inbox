Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319128AbSH2HbO>; Thu, 29 Aug 2002 03:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319130AbSH2HbO>; Thu, 29 Aug 2002 03:31:14 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:20465 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S319128AbSH2HbM>; Thu, 29 Aug 2002 03:31:12 -0400
Message-ID: <3D6DCEC1.7020102@attbi.com>
Date: Thu, 29 Aug 2002 02:35:29 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.5.23-mm1
Content-Type: multipart/mixed;
 boundary="------------080603020205090800040109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080603020205090800040109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

   I am trying to run 2.5.32-mm1.  The first problem that I have is that 
if SMP, Preempt and Highmem are all turned on I get lots of problems at 
boot including a BUG in highmem.c, I can get the line number later if 
someone wants it (later tomorrow night).  I then disabled highmem and 
got the system to boot.  I have a few weird problems, one is that every 
once in a while I see the message "bad: schedule() with irqs disabled!" 
and then there is a code trace.  I am attaching the decoded output of 
some of the traces.  Another problem I am having is that I get this 
message on bootup: "mtrr: SMP support incomplete for this vendor".  It 
seems that this would be a problem however the box works fine as far as 
I can tell.  Thanks for any light anyone can shed on any of this and 
please let me know whether anyone needs to know more about this box or 
about the highmem line number to figure and of these problems out.

Jordan Breeding

--------------080603020205090800040109
Content-Type: text/plain;
 name="error.processed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="error.processed"

ksymoops 2.4.5 on i686 2.5.32.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.32 (specified)
     -m /boot/System.map-2.5.32-mm1 (specified)

Aug 29 01:54:04 ledzep kernel: f1e07df8 00000000 f1e07e28 c0141452 c18ce500 ebd92000 c18ce524 c04fa680 
Aug 29 01:54:04 ledzep kernel:        00000002 f7f5c7bc c16cf678 eb95c000 f1e07e48 c0142997 c18ce500 f7f5c83c 
Aug 29 01:54:04 ledzep kernel:        0000001e c16cf678 eb95c000 006cf660 f1e07e68 c01415cc c18ce500 eb95c000 
Aug 29 01:54:04 ledzep kernel: Call Trace: [<c0141452>] [<c0142997>] [<c01415cc>] [<c035caf7>] [<c035b561>] 
Aug 29 01:54:04 ledzep kernel:    [<c035cc22>] [<c03b06ad>] [<c035893f>] [<c0358a70>] [<c0151fb9>] [<c012b5c0>] 
Aug 29 01:54:04 ledzep kernel:    [<c015213c>] [<c0109e6b>] 
Aug 29 01:58:26 ledzep kernel: f4ca5da4 f4ca4000 f4ca5dd8 c0142669 c18ce940 f6c8965c c18ce964 00003246 
Aug 29 01:58:26 ledzep kernel:        00000000 f4ca5dec f6d5d1b4 f6d5d1b4 00003246 f4ca5df4 c035c8d6 c18ce940 
Aug 29 01:58:26 ledzep kernel:        000001d0 ffffffe0 00000000 f6cd2ab4 f4ca5e1c c035b8a5 00003fc0 000001d0 
Aug 29 01:58:26 ledzep kernel: Call Trace: [<c0142669>] [<c035c8d6>] [<c035b8a5>] [<c035b9ce>] [<c03aff87>] 
Aug 29 01:58:26 ledzep kernel:    [<c03588b9>] [<c0358c11>] [<c0358cef>] [<c01523c8>] [<c012c052>] [<c012b5c0>] 
Aug 29 01:58:26 ledzep kernel:    [<c01525ff>] [<c0109e6b>] 
Aug 29 01:58:26 ledzep kernel: f4ca5da4 f4ca4000 f4ca5dd8 c0142669 c18ce940 f6c8965c c18ce964 00003246 
Aug 29 01:58:26 ledzep kernel:        00000000 f4ca5dec efbe4c64 efbe4c64 00003246 f4ca5df4 c035c8d6 c18ce940 
Aug 29 01:58:26 ledzep kernel:        000001d0 ffffffe0 00000000 f6cd2ab4 f4ca5e1c c035b8a5 00003fc0 000001d0 
Aug 29 01:58:26 ledzep kernel: Call Trace: [<c0142669>] [<c035c8d6>] [<c035b8a5>] [<c035b9ce>] [<c03aff87>] 
Aug 29 01:58:26 ledzep kernel:    [<c03588b9>] [<c0358c11>] [<c0358cef>] [<c01523c8>] [<c012c052>] [<c012b5c0>] 
Aug 29 01:58:26 ledzep kernel:    [<c01525ff>] [<c0109e6b>] 
Aug 29 02:09:41 ledzep kernel: e24b7e84 00000000 e24b7eb4 c0141452 c18dfe50 e6396878 c18dfe74 f7b14400 
Aug 29 02:09:41 ledzep kernel:        e24b7eb4 f7f0a000 c15f8f88 e6396a48 e24b7ed4 c0142997 c18dfe50 f7f0a200 
Aug 29 02:09:41 ledzep kernel:        0000007e 00000246 005f8f70 e6396a48 e24b7ef0 c0141526 c18dfe50 e6396a48 
Aug 29 02:09:41 ledzep kernel: Call Trace: [<c0141452>] [<c0142997>] [<c0141526>] [<c016a743>] [<c011b403>] 
Aug 29 02:09:41 ledzep kernel:    [<c016aca4>] [<c0161fef>] [<c011b660>] [<c0162189>] [<c01623e9>] [<c0109e6b>] 
Aug 29 02:09:41 ledzep kernel: e24b7e80 00000000 e24b7eb0 c0141452 c18cf080 f2f1a5fc c18cf0a4 c18dfe74 
Aug 29 02:09:41 ledzep kernel:        e24b7edc f7efd800 c17f5c28 f2f1a5d4 e24b7ed0 c0142997 c18cf080 f7efda00 
Aug 29 02:09:41 ledzep kernel:        0000007e c17f5c28 f2f1a5d4 007f5c10 e24b7ef0 c01415cc c18cf080 f2f1a5d4 
Aug 29 02:09:41 ledzep kernel: Call Trace: [<c0141452>] [<c0142997>] [<c01415cc>] [<c016a7f2>] [<c016aca4>] 
Aug 29 02:09:41 ledzep kernel:    [<c0161fef>] [<c015fa1f>] [<c0162189>] [<c01623e9>] [<c0109e6b>] 
Aug 29 02:10:00 ledzep kernel: e081fe84 00000000 e081feb4 c0141452 c18dfe50 f048fe5c c18dfe74 0058fe58 
Aug 29 02:10:00 ledzep kernel:        e081ff84 f7f0b400 c16e0158 ec008220 e081fed4 c0142997 c18dfe50 f7f0b600 
Aug 29 02:10:00 ledzep kernel:        0000007e 00000246 006e0140 ec008220 e081fef0 c0141526 c18dfe50 ec008220 
Aug 29 02:10:00 ledzep kernel: Call Trace: [<c0141452>] [<c0142997>] [<c0141526>] [<c016a743>] [<c016aca4>] 
Aug 29 02:10:00 ledzep kernel:    [<c0161fef>] [<c015fa1f>] [<c0162189>] [<c01623e9>] [<c0109e6b>] 
Aug 29 02:25:10 ledzep kernel: f1e07df8 00000000 f1e07e28 c0141452 c18ce500 ec21d000 c18ce524 00000000 
Aug 29 02:25:10 ledzep kernel:        00000001 f7f5c8c4 c16873c8 e9c7e000 f1e07e48 c0142997 c18ce500 f7f5c944 
Aug 29 02:25:10 ledzep kernel:        0000001e c16873c8 e9c7e000 006873b0 f1e07e68 c01415cc c18ce500 e9c7e000 
Aug 29 02:25:10 ledzep kernel: Call Trace: [<c0141452>] [<c0142997>] [<c01415cc>] [<c035caf7>] [<c035b561>] 
Aug 29 02:25:10 ledzep kernel:    [<c035cc22>] [<c03b06ad>] [<c035893f>] [<c0358a70>] [<c0151fb9>] [<c015213c>] 
Aug 29 02:25:10 ledzep kernel:    [<c0109e6b>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0141452 <free_block+b2/c0>
Trace; c0142997 <__kmem_cache_free+97/f2>
Trace; c01415cc <kfree+5c/a0>
Trace; c035caf7 <kfree_skbmem+17/80>
Trace; c035b561 <sock_wfree+41/50>
Trace; c035cc22 <__kfree_skb+c2/110>
Trace; c03b06ad <unix_stream_recvmsg+1bd/330>
Trace; c035893f <sock_recvmsg+4f/f0>
Trace; c0358a70 <sock_read+90/a0>
Trace; c0151fb9 <vfs_read+b9/100>
Trace; c012b5c0 <update_process_times+40/50>
Trace; c015213c <sys_read+3c/50>
Trace; c0109e6b <syscall_call+7/b>
Trace; c0142669 <__kmem_cache_alloc+139/1d0>
Trace; c035c8d6 <alloc_skb+b6/1c0>
Trace; c035b8a5 <sock_alloc_send_pskb+d5/1d0>
Trace; c035b9ce <sock_alloc_send_skb+2e/30>
Trace; c03aff87 <unix_stream_sendmsg+107/330>
Trace; c03588b9 <sock_sendmsg+79/b0>
Trace; c0358c11 <sock_readv_writev+71/a0>
Trace; c0358cef <sock_writev+4f/60>
Trace; c01523c8 <do_readv_writev+148/250>
Trace; c012c052 <update_times+112/117>
Trace; c012b5c0 <update_process_times+40/50>
Trace; c01525ff <sys_writev+8f/a0>
Trace; c0109e6b <syscall_call+7/b>
Trace; c0142669 <__kmem_cache_alloc+139/1d0>
Trace; c035c8d6 <alloc_skb+b6/1c0>
Trace; c035b8a5 <sock_alloc_send_pskb+d5/1d0>
Trace; c035b9ce <sock_alloc_send_skb+2e/30>
Trace; c03aff87 <unix_stream_sendmsg+107/330>
Trace; c03588b9 <sock_sendmsg+79/b0>
Trace; c0358c11 <sock_readv_writev+71/a0>
Trace; c0358cef <sock_writev+4f/60>
Trace; c01523c8 <do_readv_writev+148/250>
Trace; c012c052 <update_times+112/117>
Trace; c012b5c0 <update_process_times+40/50>
Trace; c01525ff <sys_writev+8f/a0>
Trace; c0109e6b <syscall_call+7/b>
Trace; c0141452 <free_block+b2/c0>
Trace; c0142997 <__kmem_cache_free+97/f2>
Trace; c0141526 <kmem_cache_free+66/b0>
Trace; c016a743 <prune_dcache+103/1f0>
Trace; c011b403 <schedule+1b3/3e0>
Trace; c016aca4 <shrink_dcache_parent+24/30>
Trace; c0161fef <d_unhash+af/160>
Trace; c011b660 <preempt_schedule+30/70>
Trace; c0162189 <vfs_rmdir+e9/270>
Trace; c01623e9 <sys_rmdir+d9/100>
Trace; c0109e6b <syscall_call+7/b>
Trace; c0141452 <free_block+b2/c0>
Trace; c0142997 <__kmem_cache_free+97/f2>
Trace; c01415cc <kfree+5c/a0>
Trace; c016a7f2 <prune_dcache+1b2/1f0>
Trace; c016aca4 <shrink_dcache_parent+24/30>
Trace; c0161fef <d_unhash+af/160>
Trace; c015fa1f <permission+4f/60>
Trace; c0162189 <vfs_rmdir+e9/270>
Trace; c01623e9 <sys_rmdir+d9/100>
Trace; c0109e6b <syscall_call+7/b>
Trace; c0141452 <free_block+b2/c0>
Trace; c0142997 <__kmem_cache_free+97/f2>
Trace; c0141526 <kmem_cache_free+66/b0>
Trace; c016a743 <prune_dcache+103/1f0>
Trace; c016aca4 <shrink_dcache_parent+24/30>
Trace; c0161fef <d_unhash+af/160>
Trace; c015fa1f <permission+4f/60>
Trace; c0162189 <vfs_rmdir+e9/270>
Trace; c01623e9 <sys_rmdir+d9/100>
Trace; c0109e6b <syscall_call+7/b>
Trace; c0141452 <free_block+b2/c0>
Trace; c0142997 <__kmem_cache_free+97/f2>
Trace; c01415cc <kfree+5c/a0>
Trace; c035caf7 <kfree_skbmem+17/80>
Trace; c035b561 <sock_wfree+41/50>
Trace; c035cc22 <__kfree_skb+c2/110>
Trace; c03b06ad <unix_stream_recvmsg+1bd/330>
Trace; c035893f <sock_recvmsg+4f/f0>
Trace; c0358a70 <sock_read+90/a0>
Trace; c0151fb9 <vfs_read+b9/100>
Trace; c015213c <sys_read+3c/50>
Trace; c0109e6b <syscall_call+7/b>


1 warning issued.  Results may not be reliable.

--------------080603020205090800040109--

