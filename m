Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQLNETr>; Wed, 13 Dec 2000 23:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129724AbQLNETi>; Wed, 13 Dec 2000 23:19:38 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:64759 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129572AbQLNET0>; Wed, 13 Dec 2000 23:19:26 -0500
Date: Wed, 13 Dec 2000 22:48:56 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12 lockups -- need feedback
In-Reply-To: <Pine.LNX.4.30.0012132157020.1272-100000@viper.haque.net>
Message-ID: <Pine.LNX.4.30.0012132244290.1875-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here we go folks. I hope I got everything right. The only place I have a
doubt is the 0010: part of EIP. I couldn't read what I wrote there.
Looks like it's ip fragment related?

ksymoops 0.7c on i686 2.4.0-test11.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test12 (specified)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01e610e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: d15c83e0   ecx: d1f4aa60   edx: d1f4aa60
esi: 000003d8   edi: d15c8660   ebp: 000003d8   esp: c0303c1c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0303000)
Stack: d1f4aa60 00000000 0000625b d957accf 00000014 00000000 c01e6493 d1f4aa60
       d15c8660 d3fc9680 d15c8660 00000008 c0303d28 011e51be 00000000 d58ce1bf
       d15c8660 d58d0008 c0303018 00000003 d58cd3ed d15c8660 d58d0d08 c0303018
Call Trace: [<d957accf>] [<c01e6493>] [<d58ce1bf>] [<d5800008>] [<d58cd3ed>] [<d5800008>] [<c012e146>]
       [<d58cf370>] [<c01e88a4>] [<c01d925c>] [<c01e88a4>] [<c01e88a4>] [<c01d94b7>] [<c01e88a4>] [<d58d0d08>]
       [<c01e7faf>] [<c01e88a4>] [<c01fdf2c>] [<c01e80be>] [<c01fdf2c>] [<c01fe122>] [<c01fdf2c>] [<d957accf>]
       [<d957accf>] [<c01fe64b>] [<d58cc945>] [<d58d0d38>] [<d58cf2bf>] [<c01fe89a>] [<c01e59f3>] [<c01e5a68>]
       [<c01d94fa>] [<c01e5845>] [<c01e5970>] [<c01e5c0f>] [<c01e5a68>] [<c01d94fa>] [<c01e593d>] [<c01e5a68>]
       [<c01dce3d>] [<c011ef4f>] [<c010c891>] [<c0109420>] [<c0109420>] [<c010b128>] [<c0109420>] [<c0109420>]
       [<c0100018>] [<c0109443>] [<c01094a9>] [<c0105000>] [<c0100191>]
Code: 8b 40 3c 89 41 3c 8b 47 5c c7 47 18 00 00 00 00 01 41 18 8b

>>EIP; c01e610e <ip_frag_queue+20a/254>   <=====
Trace; d957accf <END_OF_CODE+19209c2b/????>
Trace; c01e6493 <ip_defrag+b3/130>
Trace; d58ce1bf <END_OF_CODE+1555d11b/????>
Trace; d5800008 <END_OF_CODE+1548ef64/????>
Trace; d58cd3ed <END_OF_CODE+1555c349/????>
Trace; d5800008 <END_OF_CODE+1548ef64/????>
Trace; c012e146 <__alloc_pages+de/2d0>
Trace; d58cf370 <END_OF_CODE+1555e2cc/????>
Trace; c01e88a4 <output_maybe_reroute+0/14>
Trace; c01d925c <nf_iterate+30/8c>
Trace; c01e88a4 <output_maybe_reroute+0/14>
Trace; c01e88a4 <output_maybe_reroute+0/14>
Trace; c01d94b7 <nf_hook_slow+7f/100>
Trace; c01e88a4 <output_maybe_reroute+0/14>
Trace; d58d0d08 <END_OF_CODE+1555fc64/????>
Trace; c01e7faf <ip_build_xmit_slow+3b7/478>
Trace; c01e88a4 <output_maybe_reroute+0/14>
Trace; c01fdf2c <icmp_glue_bits+0/88>
Trace; c01e80be <ip_build_xmit+4e/2fc>
Trace; c01fdf2c <icmp_glue_bits+0/88>
Trace; c01fe122 <icmp_reply+16e/18c>
Trace; c01fdf2c <icmp_glue_bits+0/88>
Trace; d957accf <END_OF_CODE+19209c2b/????>
Trace; d957accf <END_OF_CODE+19209c2b/????>
Trace; c01fe64b <icmp_echo+3f/48>
Trace; d58cc945 <END_OF_CODE+1555b8a1/????>
Trace; d58d0d38 <END_OF_CODE+1555fc94/????>
Trace; d58cf2bf <END_OF_CODE+1555e21b/????>
Trace; c01fe89a <icmp_rcv+9a/d0>
Trace; c01e59f3 <ip_local_deliver_finish+83/f8>
Trace; c01e5a68 <ip_rcv_finish+0/1d8>
Trace; c01d94fa <nf_hook_slow+c2/100>
Trace; c01e5845 <ip_local_deliver+39/40>
Trace; c01e5970 <ip_local_deliver_finish+0/f8>
Trace; c01e5c0f <ip_rcv_finish+1a7/1d8>
Trace; c01e5a68 <ip_rcv_finish+0/1d8>
Trace; c01d94fa <nf_hook_slow+c2/100>
Trace; c01e593d <ip_rcv+f1/124>
Trace; c01e5a68 <ip_rcv_finish+0/1d8>
Trace; c01dce3d <net_rx_action+19d/278>
Trace; c011ef4f <do_softirq+3f/64>
Trace; c010c891 <do_IRQ+a1/b0>
Trace; c0109420 <default_idle+0/28>
Trace; c0109420 <default_idle+0/28>
Trace; c010b128 <ret_from_intr+0/20>
Trace; c0109420 <default_idle+0/28>
Trace; c0109420 <default_idle+0/28>
Trace; c0100018 <startup_32+18/139>
Trace; c0109443 <default_idle+23/28>
Trace; c01094a9 <cpu_idle+41/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c01e610e <ip_frag_queue+20a/254>
00000000 <_EIP>:
Code;  c01e610e <ip_frag_queue+20a/254>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c01e6111 <ip_frag_queue+20d/254>
   3:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c01e6114 <ip_frag_queue+210/254>
   6:   8b 47 5c                  mov    0x5c(%edi),%eax
Code;  c01e6117 <ip_frag_queue+213/254>
   9:   c7 47 18 00 00 00 00      movl   $0x0,0x18(%edi)
Code;  c01e611e <ip_frag_queue+21a/254>
  10:   01 41 18                  add    %eax,0x18(%ecx)
Code;  c01e6121 <ip_frag_queue+21d/254>
  13:   8b 00                     mov    (%eax),%eax



On Wed, 13 Dec 2000, Mohammad A. Haque wrote:

> Ok, got locked up. Dropped me into kdb and I was able to write down the
> oops after doing a ss on btp 0.
>
> I'll try to have something posted in an hour.
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
