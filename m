Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264521AbSIQS62>; Tue, 17 Sep 2002 14:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264528AbSIQS62>; Tue, 17 Sep 2002 14:58:28 -0400
Received: from nuevo.divinia.com ([216.32.176.4]:39628 "HELO nuevo.divinia.com")
	by vger.kernel.org with SMTP id <S264521AbSIQS6Z>;
	Tue, 17 Sep 2002 14:58:25 -0400
Date: Tue, 17 Sep 2002 11:57:36 -0700 (PDT)
From: Aaron Gowatch <aarong@divinia.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.2.19
In-Reply-To: <Pine.LNX.4.44.0209171120300.13536-100000@nuevo.divinia.com>
Message-ID: <Pine.LNX.4.44.0209171155210.13536-100000@nuevo.divinia.com>
X-Favorite-Cola: Coke
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous ksymoops was from 2.2.21.  The ksymoops from 2.2.19 follows, 
which looks somewhat similar.

Sorry for the confusion.

Aaron.

ksymoops 2.3.4 on i686 2.2.19-cpproxy-1.0.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19-cpproxy-1.0.0/ (default)
     -m /boot/System.map-2.2.19-cpproxy-1.0.0 (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list 
not found in System.map.  Ignoring ksyms_base entry
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<80122fc4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000003c   ebx: 8160f080   ecx: 00000000   edx: e23c4e5c
esi: e23c4e20   edi: 00000283   ebp: e93b9b80   esp: 8023bcec
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=8023b000)
Stack: 00000010 e93b9b80 e23c4e5c 00000010 80174590 e23c4e20 0000000c 
80174843 
       e7b50dc0 e93b9c30 e93b9b80 e6ef4900 e93b9c30 0e1db48f 00000001 
d9006140 
       a88f47ca cc2b8eb2 00000246 f18db000 e954d720 f1971000 8023bdb8 
00000004 
Call Trace: [<80174590>] [<80174843>] [<8016447d>] [<8010e3c4>] 
[<8010e440>] [<80111786>] [<8015e3af>] 
       [<8015e454>] [<80111714>] [<8017da71>] [<8017cf5e>] [<8017c112>] 
[<801704eb>] [<8017510f>] [<8017538b>] 
       [<801753eb>] [<80167e06>] [<801680f1>] [<8016036d>] [<80119ef5>] 
[<80109b76>] [<80108b64>] [<8010631d>] 
       [<80106000>] [<80106000>] [<801001ae>] 
Code: 8b 69 08 81 fd 2b 2f c3 a5 0f 85 e5 00 00 00 8b 69 0c 85 ed 

>>EIP; 80122fc4 <kfree_s+94/1d8>   <=====
Trace; 80174590 <tcp_v4_or_free+20/24>
Trace; 80174843 <tcp_v4_conn_request+2af/354>
Trace; 8016447d <qdisc_restart+39/6c>
Trace; 8010e3c4 <smp_local_timer_interrupt+c4/130>
Trace; 8010e440 <smp_apic_timer_interrupt+10/18>
Trace; 80111786 <wake_up_process+52/64>
Trace; 8015e3af <kfree_skbmem+33/40>
Trace; 8015e454 <__kfree_skb+98/a0>
Trace; 80111714 <reschedule_idle+1bc/1dc>
Trace; 8017da71 <fn_hash_lookup+91/d4>
Trace; 8017cf5e <__fib_res_prefsrc+1a/20>
Trace; 8017c112 <fib_validate_source+9e/174>
Trace; 801704eb <tcp_rcv_state_process+63/86c>
Trace; 8017510f <tcp_v4_do_rcv+14f/17c>
Trace; 8017538b <tcp_v4_rcv+24f/338>
Trace; 801753eb <tcp_v4_rcv+2af/338>
Trace; 80167e06 <ip_local_deliver+16a/1b8>
Trace; 801680f1 <ip_rcv+29d/2d0>
Trace; 8016036d <net_bh+199/1fc>
Trace; 80119ef5 <do_bottom_half+81/a0>
Trace; 80109b76 <do_IRQ+52/5c>
Trace; 80108b64 <common_interrupt+18/20>
Trace; 8010631d <cpu_idle+3d/50>
Trace; 80106000 <get_options+0/74>
Trace; 80106000 <get_options+0/74>
Trace; 801001ae <L6+0/2>
Code;  80122fc4 <kfree_s+94/1d8>
00000000 <_EIP>:
Code;  80122fc4 <kfree_s+94/1d8>   <=====
   0:   8b 69 08                  mov    0x8(%ecx),%ebp   <=====
Code;  80122fc7 <kfree_s+97/1d8>
   3:   81 fd 2b 2f c3 a5         cmp    $0xa5c32f2b,%ebp
Code;  80122fcd <kfree_s+9d/1d8>
   9:   0f 85 e5 00 00 00         jne    f4 <_EIP+0xf4> 801230b8 
<kfree_s+188/1d8>
Code;  80122fd3 <kfree_s+a3/1d8>
   f:   8b 69 0c                  mov    0xc(%ecx),%ebp
Code;  80122fd6 <kfree_s+a6/1d8>
  12:   85 ed                     test   %ebp,%ebp


1 warning issued.  Results may not be reliable.

On Tue, 17 Sep 2002, Aaron Gowatch wrote:

> This oops occurred a few days ago that is basically a very, very busy
> proxy.  I'm new to kernel debugging, and I havent been on linux-kernel in 
> a few years, but I thought someone here might be able to help find the 
> cause.
> 
> Happy to provide any other information that might be needed...
> 
> Box is running an unpatched 2.2.21 kernel.
> 
> Thanks in advance,
> Aaron
> 
> ksymoops 2.3.4 on i686 2.2.21-cpproxy-1.0.0.  Options used
>      -V (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.2.21-cpproxy-1.0.0/ (default)
>      -m /boot/System.map-2.2.21-cpproxy-1.0.0 (specified)
> 
> Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list 
> not found in System.map.  Ignoring ksyms_base entry
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<8012353c>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010082
> eax: 0000003c   ebx: 81629080   ecx: 00000000   edx: f49bffbc
> esi: f49bff80   edi: 00000283   ebp: 8167fd00   esp: 8162dcbc
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, process nr: 1, stackpage=8162d000)
> Stack: 00000010 8167fd00 f49bffbc 00000010 8017492c f49bff80 0000000c 
> 80174bdf 
>        f521fe20 8167fdb0 8167fd00 f592eb40 8167fdb0 f57a68e0 00000001 
> 7050e6d1 
>        a88f47ca fb26c800 80160367 fb26c800 fadf58a0 f57a68e0 8016a535 
> f57a68e0 
> Call Trace: [<8017492c>] [<80174bdf>] [<80160367>] [<8016a535>] 
> [<8016ad2e>] 
> [<fc833000>] [<80164811>] 
>        [<fc833000>] [<80164811>] [<80160367>] [<8016a535>] [<8016a843>] 
> [<8017de11>] [<8017d2fe>] [<8017c4b2>] 
>        [<80170883>] [<801754ab>] [<80175727>] [<80175787>] [<801681a6>] 
> [<80168491>] [<80160701>] [<8011a46d>] 
>        [<80109b6a>] [<80108b58>] [<8010631d>] [<80108b2d>] [<8011a46d>] 
> [<80109b6a>] [<80108b58>] 
> Code: 8b 69 08 81 fd 2b 2f c3 a5 0f 85 e5 00 00 00 8b 69 0c 85 ed 
> 
> >>EIP; 8012353c <kfree_s+94/1d8>   <=====
> Trace; 8017492c <tcp_v4_or_free+20/24>
> Trace; 80174bdf <tcp_v4_conn_request+2af/354>
> Trace; 80160367 <dev_queue_xmit+3b/c8>
> Trace; 8016a535 <ip_output+95/bc>
> Trace; 8016ad2e <ip_build_xmit_slow+41e/478>
> Trace; fc833000 <.data.end+347d/???
> Trace; 80164811 <qdisc_restart+39/6c>
> Trace; fc833000 <.data.end+347d/???
> Trace; 80164811 <qdisc_restart+39/6c>
> Trace; 80160367 <dev_queue_xmit+3b/c8>
> Trace; 8016a535 <ip_output+95/bc>
> Trace; 8016a843 <ip_queue_xmit+2e7/3b4>
> Trace; 8017de11 <fn_hash_lookup+91/d4>
> Trace; 8017d2fe <__fib_res_prefsrc+1a/20>
> Trace; 8017c4b2 <fib_validate_source+9e/174>
> Trace; 80170883 <tcp_rcv_state_process+63/860>
> Trace; 801754ab <tcp_v4_do_rcv+14f/17c>
> Trace; 80175727 <tcp_v4_rcv+24f/338>
> Trace; 80175787 <tcp_v4_rcv+2af/338>
> Trace; 801681a6 <ip_local_deliver+176/1c4>
> Trace; 80168491 <ip_rcv+29d/2d0>
> Trace; 80160701 <net_bh+199/1fc>
> Trace; 8011a46d <do_bottom_half+81/a0>
> Trace; 80109b6a <do_IRQ+52/5c>
> Trace; 80108b58 <common_interrupt+18/20>
> Trace; 8010631d <cpu_idle+3d/50>
> Trace; 80108b2d <do_8259A_IRQ+c5/d8>
> Trace; 8011a46d <do_bottom_half+81/a0>
> Trace; 80109b6a <do_IRQ+52/5c>
> Trace; 80108b58 <common_interrupt+18/20>
> Code;  8012353c <kfree_s+94/1d8>
> 00000000 <_EIP>:
> Code;  8012353c <kfree_s+94/1d8>   <=====
>    0:   8b 69 08                  mov    0x8(%ecx),%ebp   <=====
> Code;  8012353f <kfree_s+97/1d8>
>    3:   81 fd 2b 2f c3 a5         cmp    $0xa5c32f2b,%ebp
> Code;  80123545 <kfree_s+9d/1d8>
>    9:   0f 85 e5 00 00 00         jne    f4 <_EIP+0xf4> 80123630 
> <kfree_s+188/1d8>
> Code;  8012354b <kfree_s+a3/1d8>
>    f:   8b 69 0c                  mov    0xc(%ecx),%ebp
> Code;  8012354e <kfree_s+a6/1d8>
>   12:   85 ed                     test   %ebp,%ebp
> 
> Aiee, killing interrupt handler
> Kernel panic: Attempted to kill the idle task!
> 
> 1 warning issued.  Results may not be reliable.
> 
> 

