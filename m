Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317431AbSHHJtn>; Thu, 8 Aug 2002 05:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSHHJtm>; Thu, 8 Aug 2002 05:49:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44555 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317431AbSHHJtl>; Thu, 8 Aug 2002 05:49:41 -0400
Message-ID: <3D523E53.2030702@evision.ag>
Date: Thu, 08 Aug 2002 11:48:03 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: bad: schedule() with irqs disabled! (+ ksymoops)
References: <20020808093335.GA11179@gnuppy.monkey.org> <20020808094026.GA11264@gnuppy.monkey.org>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Bill Huey (Hui) napisa?:

> 
> It got better instructions this time around...
> 
> =================================================================================
> 
> ksymoops 2.4.6 on i686 2.5.30.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.5.30/ (default)
>      -m /boot/System.map-2.5.30 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
>        d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
>        d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625e94 d2789460 
> Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
>    [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
>    [<c01f7297>] [<c01f7f47>] [<c010a561>] [<c01082c2>] [<c01f6469>] [<c01f763e>] 
>    [<c01f7660>] [<c01f7bc4>] [<c0106de3>] 
> d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
>        d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
>        d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625c94 d2789aa0 
> Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
>    [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
>    [<c01f7297>] [<c01f7f47>] [<c01f6469>] [<c01f763e>] [<c01f7660>] [<c01f7bc4>] 
>    [<c0106de3>] 
> d2895d5c c024a360 c1521580 d2895d84 c0110c58 00000001 c02fabf8 fffffffa 
>        d2895d80 00000046 d2895d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
>        d2894000 00000003 c02b3060 00000002 00000246 c0203c30 d4625c94 d27895a0 
> Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
>    [<c020e450>] [<c0106f28>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] 
>    [<c022d21c>] [<c01f7297>] [<c01f7f47>] [<c010a561>] [<c01f6469>] [<c01f763e>] 
>    [<c01f7660>] [<c01f7bc4>] [<c0106de3>] 
> c3701d64 c024a360 c1521580 c3701d8c c0110c58 00000001 c02fabf0 fffffffc 
>        c3701d88 00000046 c3701d9c c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
>        c3700000 00000003 d7cf6800 00000002 00000246 c0203c30 d4625e9c c8f096c0 
> Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
>    [<c020e450>] [<c0106f28>] [<c0210018>] [<c021be09>] [<c021be2d>] [<c021e223>] 
>    [<c0213250>] [<c0213dfe>] [<c01dbec6>] [<c022d601>] [<c01f6649>] [<c01f674b>] 
>    [<c01358cb>] [<c0135aa6>] [<c0106de3>] 
> cb8e7d64 c024a360 c1521580 cb8e7d8c c0110c58 00000001 c02fabf0 fffffffc 
>        cb8e7d88 00000046 cb8e7d9c c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
>        cb8e6000 00000003 d7cf6800 00000002 00000246 c0203c30 d4625e9c d707bda0 
> Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
>    [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e223>] [<c0213250>] [<c0213dfe>] 
>    [<c022d601>] [<c01f6649>] [<c01f674b>] [<c014475f>] [<c01358cb>] [<c0135aa6>] 
>    [<c0106de3>] 
> cf9d5d5c c024a360 c1521580 cf9d5d84 c0110c58 00000001 c02fabf8 fffffffa 
>        cf9d5d80 00000046 cf9d5d94 c0110c6f c1521580 00000000 c02fabe0 c0118ae0 
>        cf9d4000 00000003 c02b3060 00000002 00000246 c0203c30 d4625e94 c6442d40 
> Call Trace: [<c0110c58>] [<c0110c6f>] [<c0118ae0>] [<c0203c30>] [<c020d53a>] 
>    [<c020e450>] [<c021bd7e>] [<c021be2d>] [<c021e00c>] [<c0220514>] [<c022d21c>] 
>    [<c01f7297>] [<c01f7f47>] [<c01f6469>] [<c01f763e>] [<c01f7660>] [<c01f7bc4>] 
>    [<c0106de3>] 
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> 
> Trace; c0110c58 <try_to_wake_up+100/10c>
> Trace; c0110c6f <wake_up_process+b/10>
> Trace; c0118ae0 <do_softirq+a0/ac>
> Trace; c0203c30 <nf_hook_slow+1ac/1cc>
> Trace; c020d53a <ip_queue_xmit+296/2ec>
> Trace; c020e450 <ip_queue_xmit2+0/210>

I can report pretty the same:

Trace; c0113f84 <try_to_wake_up+104/110>
Trace; c0113fa6 <wake_up_process+16/20>
Trace; c011d1f7 <do_softirq+a7/c0>
Trace; c01d4a57 <dev_queue_xmit+157/3c0>
Trace; c01e88ba <ip_finish_output2+aa/130>
Trace; c01e8a0f <ip_queue_xmit2+cf/280>
Trace; c01e8a12 <ip_queue_xmit2+d2/280>
Trace; c01e78ef <ip_queue_xmit+1ff/2b0>
Trace; c01fcc7d <tcp_v4_send_check+4d/e0>
Trace; c01f76b8 <tcp_transmit_skb+2b8/450>
Trace; c01f8231 <tcp_write_xmit+181/270>
Trace; c01ece4b <tcp_sendmsg+57b/10d0>
Trace; c020b7b4 <inet_sendmsg+44/50>
Trace; c01ccda6 <sock_sendmsg+76/c0>
Trace; c01fdf99 <tcp_v4_rcv+3b9/400>
Trace; c01cd111 <sock_readv_writev+71/a0>
Trace; c01e4dfd <ip_local_deliver_finish+12d/130>
Trace; c01cd1ef <sock_writev+4f/60>
Trace; c01403a5 <do_readv_writev+155/260>
Trace; c01405e1 <sys_writev+91/a0>
Trace; c01075fb <syscall_call+7/b>


