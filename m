Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSHHJgu>; Thu, 8 Aug 2002 05:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317568AbSHHJgu>; Thu, 8 Aug 2002 05:36:50 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:9098 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S317561AbSHHJgq>; Thu, 8 Aug 2002 05:36:46 -0400
Date: Thu, 8 Aug 2002 02:40:26 -0700
To: linux-kernel@vger.kernel.org
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: bad: schedule() with irqs disabled! (+ ksymoops)
Message-ID: <20020808094026.GA11264@gnuppy.monkey.org>
References: <20020808093335.GA11179@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808093335.GA11179@gnuppy.monkey.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 02:33:35AM -0700, Bill Huey wrote:
> Hello,
> 
> Looks like some critical section got botched.
> 
> I don't do bug reports very often, so don't know exactly if this is
> helpful. If somebody would like point me to something more exact, I'll
> be happy to help out trying to trigger this again.
> 
> It happened under very high IDE activity, heavy VM and file system IO.

It got better instructions this time around...

=================================================================================

ksymoops 2.4.6 on i686 2.5.30.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.30/ (default)
     -m /boot/System.map-2.5.30 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
       d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625e94 d2789460 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
   [<c01f7297>] [<c01f7f47>] [<c010a561>] [<c01082c2>] [<c01f6469>] [<c01f763e>] 
   [<c01f7660>] [<c01f7bc4>] [<c0106de3>] 
d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
       d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625c94 d2789aa0 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
   [<c01f7297>] [<c01f7f47>] [<c01f6469>] [<c01f763e>] [<c01f7660>] [<c01f7bc4>] 
   [<c0106de3>] 
d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
       d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625c94 d27895a0 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c0106f28>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] 
   [<c022d21c>] [<c01f7297>] [<c01f7f47>] [<c010a561>] [<c01f6469>] [<c01f763e>] 
   [<c01f7660>] [<c01f7bc4>] [<c0106de3>] 
c3701d64 c024a360 c1521580 c3701d8c c0110c58 00000001 c02fabf0 fffffffc 
       c3701d88 00000046 c3701d9c c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       c3700000 00000003 d7cf6800 00000002 00000246 c0203c30 d4625e9c c8f096c0 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c0106f28>] [<c0210018>] [<c021be09>] [<c021be2d>] [<c021e223>] 
   [<c0213250>] [<c0213dfe>] [<c01dbec6>] [<c022d601>] [<c01f6649>] [<c01f674b>] 
   [<c01358cb>] [<c0135aa6>] [<c0106de3>] 
cb8e7d64 c024a360 c1521580 cb8e7d8c c0110c58 00000001 c02fabf0 fffffffc 
       cb8e7d88 00000046 cb8e7d9c c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       cb8e6000 00000003 d7cf6800 00000002 00000246 c0203c30 d4625e9c d707bda0 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e223>] [<c0213250>] [<c0213dfe>] 
   [<c022d601>] [<c01f6649>] [<c01f674b>] [<c014475f>] [<c01358cb>] [<c0135aa6>] 
   [<c0106de3>] 
cf9d5d5c c024a360 c1521580 cf9d5d84 c0110c58 00000001 c02fabf8 fffffffa 
       cf9d5d80 00000046 cf9d5d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
       cf9d4000 00000003 c02b3060 00000002 00000246 c0203c30 d4625e94 c6442d40 
Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
   [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
   [<c01f7297>] [<c01f7f47>] [<c01f6469>] [<c01f763e>] [<c01f7660>] [<c01f7bc4>] 
   [<c0106de3>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0110c58 <try_to_wake_up+100/10c>
Trace; c0110c6f <wake_up_process+b/10>
Trace; c0118ae0 <do_softirq+a0/ac>
Trace; c0203c30 <nf_hook_slow+1ac/1cc>
Trace; c020d53a <ip_queue_xmit+296/2ec>
Trace; c020e450 <ip_queue_xmit2+0/210>
Trace; c021bd7e <tcp_transmit_skb+43a/59c>
Trace; c021be2d <tcp_transmit_skb+4e9/59c>
Trace; c021e00c <tcp_connect+394/428>
Trace; c0220514 <tcp_v4_connect+338/3dc>
Trace; c022d21c <inet_stream_connect+114/270>
Trace; c01f7297 <sys_connect+5b/78>
Trace; c01f7f47 <sock_setsockopt+33/5f0>
Trace; c010a561 <end_8259A_irq+21/28>
Trace; c01082c2 <do_IRQ+be/118>
Trace; c01f6469 <sockfd_lookup+11/6c>
Trace; c01f763e <sys_setsockopt+4a/78>
Trace; c01f7660 <sys_setsockopt+6c/78>
Trace; c01f7bc4 <sys_socketcall+88/1fc>
Trace; c0106de3 <syscall_call+7/b>
Trace; c0110c58 <try_to_wake_up+100/10c>
Trace; c0110c6f <wake_up_process+b/10>
Trace; c0118ae0 <do_softirq+a0/ac>
Trace; c0203c30 <nf_hook_slow+1ac/1cc>
Trace; c020d53a <ip_queue_xmit+296/2ec>
Trace; c020e450 <ip_queue_xmit2+0/210>
Trace; c021bd7e <tcp_transmit_skb+43a/59c>
Trace; c021be2d <tcp_transmit_skb+4e9/59c>
Trace; c021e00c <tcp_connect+394/428>
Trace; c0220514 <tcp_v4_connect+338/3dc>
Trace; c022d21c <inet_stream_connect+114/270>
Trace; c01f7297 <sys_connect+5b/78>
Trace; c01f7f47 <sock_setsockopt+33/5f0>
Trace; c01f6469 <sockfd_lookup+11/6c>
Trace; c01f763e <sys_setsockopt+4a/78>
Trace; c01f7660 <sys_setsockopt+6c/78>
Trace; c01f7bc4 <sys_socketcall+88/1fc>
Trace; c0106de3 <syscall_call+7/b>
Trace; c0110c58 <try_to_wake_up+100/10c>
Trace; c0110c6f <wake_up_process+b/10>
Trace; c0118ae0 <do_softirq+a0/ac>
Trace; c0203c30 <nf_hook_slow+1ac/1cc>
Trace; c020d53a <ip_queue_xmit+296/2ec>
Trace; c020e450 <ip_queue_xmit2+0/210>
Trace; c0106f28 <common_interrupt+18/20>
Trace; c021bd7e <tcp_transmit_skb+43a/59c>
Trace; c021be2d <tcp_transmit_skb+4e9/59c>
Trace; c021e00c <tcp_connect+394/428>
Trace; c0220514 <tcp_v4_connect+338/3dc>
Trace; c022d21c <inet_stream_connect+114/270>
Trace; c01f7297 <sys_connect+5b/78>
Trace; c01f7f47 <sock_setsockopt+33/5f0>
Trace; c010a561 <end_8259A_irq+21/28>
Trace; c01f6469 <sockfd_lookup+11/6c>
Trace; c01f763e <sys_setsockopt+4a/78>
Trace; c01f7660 <sys_setsockopt+6c/78>
Trace; c01f7bc4 <sys_socketcall+88/1fc>
Trace; c0106de3 <syscall_call+7/b>
Trace; c0110c58 <try_to_wake_up+100/10c>
Trace; c0110c6f <wake_up_process+b/10>
Trace; c0118ae0 <do_softirq+a0/ac>
Trace; c0203c30 <nf_hook_slow+1ac/1cc>
Trace; c020d53a <ip_queue_xmit+296/2ec>
Trace; c020e450 <ip_queue_xmit2+0/210>
Trace; c0106f28 <common_interrupt+18/20>
Trace; c0210018 <ip_getsockopt+634/a1c>
Trace; c021be09 <tcp_transmit_skb+4c5/59c>
Trace; c021be2d <tcp_transmit_skb+4e9/59c>
Trace; c021e223 <tcp_send_ack+c3/cc>
Trace; c0213250 <cleanup_rbuf+d4/dc>
Trace; c0213dfe <tcp_recvmsg+7ca/944>
Trace; c01dbec6 <task_out_intr+f6/104>
Trace; c022d601 <inet_recvmsg+3d/54>
Trace; c01f6649 <sock_recvmsg+3d/b4>
Trace; c01f674b <sock_read+8b/98>
Trace; c01358cb <vfs_read+bb/13c>
Trace; c0135aa6 <sys_read+2a/3c>
Trace; c0106de3 <syscall_call+7/b>
Trace; c0110c58 <try_to_wake_up+100/10c>
Trace; c0110c6f <wake_up_process+b/10>
Trace; c0118ae0 <do_softirq+a0/ac>
Trace; c0203c30 <nf_hook_slow+1ac/1cc>
Trace; c020d53a <ip_queue_xmit+296/2ec>
Trace; c020e450 <ip_queue_xmit2+0/210>
Trace; c021bd7e <tcp_transmit_skb+43a/59c>
Trace; c021be2d <tcp_transmit_skb+4e9/59c>
Trace; c021e223 <tcp_send_ack+c3/cc>
Trace; c0213250 <cleanup_rbuf+d4/dc>
Trace; c0213dfe <tcp_recvmsg+7ca/944>
Trace; c022d601 <inet_recvmsg+3d/54>
Trace; c01f6649 <sock_recvmsg+3d/b4>
Trace; c01f674b <sock_read+8b/98>
Trace; c014475f <sys_select+463/470>
Trace; c01358cb <vfs_read+bb/13c>
Trace; c0135aa6 <sys_read+2a/3c>
Trace; c0106de3 <syscall_call+7/b>
Trace; c0110c58 <try_to_wake_up+100/10c>
Trace; c0110c6f <wake_up_process+b/10>
Trace; c0118ae0 <do_softirq+a0/ac>
Trace; c0203c30 <nf_hook_slow+1ac/1cc>
Trace; c020d53a <ip_queue_xmit+296/2ec>
Trace; c020e450 <ip_queue_xmit2+0/210>
Trace; c021bd7e <tcp_transmit_skb+43a/59c>
Trace; c021be2d <tcp_transmit_skb+4e9/59c>
Trace; c021e00c <tcp_connect+394/428>
Trace; c0220514 <tcp_v4_connect+338/3dc>
Trace; c022d21c <inet_stream_connect+114/270>
Trace; c01f7297 <sys_connect+5b/78>
Trace; c01f7f47 <sock_setsockopt+33/5f0>
Trace; c01f6469 <sockfd_lookup+11/6c>
Trace; c01f763e <sys_setsockopt+4a/78>
Trace; c01f7660 <sys_setsockopt+6c/78>
Trace; c01f7bc4 <sys_socketcall+88/1fc>
Trace; c0106de3 <syscall_call+7/b>


2 warnings issued.  Results may not be reliable.


