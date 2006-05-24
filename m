Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWEXNcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWEXNcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWEXNcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:32:23 -0400
Received: from elasmtp-spurfowl.atl.sa.earthlink.net ([209.86.89.66]:22457
	"EHLO elasmtp-spurfowl.atl.sa.earthlink.net") by vger.kernel.org
	with ESMTP id S932671AbWEXNcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:32:22 -0400
Message-ID: <44746064.30607@netwolves.com>
Date: Wed, 24 May 2006 09:32:20 -0400
From: Steve Clark <sclark@netwolves.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.7.12) Gecko/20051110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: uclinux 2.4.32 panic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: a437fbc6971e80f61aa676d7e74259b7b3291a7d08dfec79f25030b2f19cfc4237136b5aad68a403350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 63.122.229.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I realize this is uClinux - but I received no response from the 
uclinux-devel list so I am
posting here in the hope that someone will be kind enough to at least 
give me a
direction in which to proceed in trying to track down this panic. It 
only seems to
happen under heavy traffic - especially outbound, in other words 
ethernet to modem to internet.

I am having trouble with cnxtserial.c causing a panic on an actiontec 
dualpc
modem. I've looked at the code but can't figure out how I can be 
getting a null pointer. I have very
limited experience working in the kernel so if anyone can give 
somethings to try I would appreciate
it. Below is the output from ksymoops of the panic.

Thanks,
Steve

ksymoops 2.4.11 on i686 2.6.16-1.2122_FC5.  Options used
       -v /home/sclark/actiontec/linux-2.4.32/vmlinux (specified)
       -K (specified)
       -L (specified)
       -O (specified)
       -m ../System.map (specified)
       -t elf32-littlearm -a armnommu

# Unable to handle kernel NULL pointer dereference at virtual address 
0000003f
Internal error: Oops: ffffffff
CPU: 0
pc : [<0090e5fc>]    lr : [<008727cc>]    Not tainted
sp : 0098bc14  ip : 7e17685d  fp : 0098bc38
r10: 00a10000  r9 : 173706d5  r8 : 800e000a
r7 : 08010100  r6 : 00dc08d0  r5 : 24108090  r4 : c914d625
r3 : 6c9c0a91  r2 : 00000018  r1 : 009922b8  r0 : c3400038
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment user
Control: C000107D
Process ksoftirqd_CPU0 (pid: 3, stackpage=0098b000)
0098bc00:          008727cc 0090e5fc 20000093  ffffffff 00000038 
00000000 00992
0098bc20: 00000038 00956228 20000013 0098bc6c  0098bc3c 008727cc 
0090e3b0 00000
0098bc40: 00000000 00992200 00000038 0099221c  0094ce68 00000000 
00000001 00a10
0098bc60: 0098bc98 0098bc70 008820e0 00872694  00992200 00a29760 
00a29760 00994
0098bc80: 00000034 00000000 009ea9e2 0098bcb0  0098bc9c 00882004 
00882024 00994
0098bca0: 00000000 0098bcc8 0098bcb4 008794f4  00881fd4 0000002f 
00a29760 0098b
0098bcc0: 0098bccc 008793c0 00879434 0098bcd4  00000001 009ea9e2 
00994d64 00994
0098bce0: 00000000 0094ce68 00994d60 00000000  0098bd1c 0098bd00 
00878e04 00878
0098bd00: 00a24080 009edec0 009edec0 00992400  0098bd44 0098bd20 
00878b60 00878
0098bd20: 00a24080 00992400 009edec0 00000000  008b7744 00000002 
0098bd60 0098b
0098bd40: 008a9c74 0087891c 0094ce68 0094ce60  00992400 0098bd80 
0098bd64 0089e
0098bd60: 008a9c1c 00000001 009edec0 00000000  00000000 0098bd9c 
0098bd84 008b7
0098bd80: 0089ea64 00000001 00000004 00992400  0098bde0 0098bda0 
008a8fec 008b7
0098bda0: 00992400 0098bdb0 008b7744 80000000  00964ac0 009edec0 
009edec0 009ed
0098bdc0: 00992400 0093ded4 008b4204 00000000  00000002 0098be08 
0098bde4 008b5
0098bde0: 008a8ea4 00992400 008b7744 80000000  009edec0 00000002 
00992400 0098b
0098be00: 0098be0c 008b4258 008b5730 00000001  0098be60 0098be20 
008a8fec 008b4
0098be20: 00992400 0098be30 008b4204 80000000  00964ab0 009edec0 
009edef0 009ed
0098be40: 000005f4 00992400 008b29e0 00000000  00000002 0098be8c 
0098be64 008b4
0098be60: 008a8ea4 00992400 008b4204 80000000  00a243a0 0093ded4 
009edec0 0093d
0098be80: 0098bebc 0098be90 008b2c08 008b3f38  0093ded4 00000005 
00000000 00000
0098bea0: 0093ded4 00000001 00000000 00000000  0098bf00 0098bec0 
008a8fec 008b2
0098bec0: 00000000 0098bed0 008b29e0 80000000  00964aa0 009edec0 
00000005 009ed
0098bee0: 009edec0 00965500 0093ded4 00036356  009381a0 0098bf38 
0098bf04 008b2
0098bf00: 008a8ea4 00000000 008b29e0 80000000  009edec0 0093fc1c 
009edec0 00000
0098bf20: 00000008 00000001 0098bf88 0098bf54  0098bf3c 0089f54c 
008b2284 0093d
0098bf40: 009381cc 009381ac 0098bf84 0098bf58  0089f65c 0089f2ec 
00000040 00938
0098bf60: 009381cc 009381a0 009381bc 00036356  60000013 0094d224 
0098bfb0 0098b
0098bf80: 0089f7dc 0089f5c4 0000012c 00938090  00000003 fffffff2 
0094ce60 00000
0098bfa0: 00938080 0098bfdc 0098bfb4 0081e090  0089f754 0098a000 
0098a000 0098a
0098bfc0: 0094ce60 00938d48 41029402 0080ae58  0098bffc 0098bfe0 
0081e70c 0081d
0098bfe0: 00000000 0097e000 0081e674 00945730  00000000 0098c000 
00810f28 0081e
Backtrace:
Function entered at [<0090e3a0>] from [<008727cc>]
   r9 = 20000013  r8 = 00956228  r7 = 00000038  r6 = 009922A0
   r5 = 00000000  r4 = 00000038
Function entered at [<00872684>] from [<008820e0>]
Function entered at [<00882014>] from [<00882004>]
Function entered at [<00881fc4>] from [<008794f4>]
   r5 = 00000000  r4 = 00994D60
Function entered at [<00879424>] from [<008793c0>]
   r5 = 00A29760  r4 = 0000002F
Function entered at [<00878ebc>] from [<00878e04>]
Function entered at [<00878d60>] from [<00878b60>]
   r7 = 00992400  r6 = 009EDEC0  r5 = 009EDEC0  r4 = 00A24080
Function entered at [<0087890c>] from [<008a9c74>]
Function entered at [<008a9c0c>] from [<0089ebf0>]
   r6 = 00992400  r5 = 0094CE60  r4 = 0094CE68
Function entered at [<0089ea54>] from [<008b781c>]
   r7 = 00000000  r6 = 00000000  r5 = 009EDEC0  r4 = 00000001
Function entered at [<008b7744>] from [<008a8fec>]
   r6 = 00992400  r5 = 00000004  r4 = 00000001
Function entered at [<008a8e94>] from [<008b58cc>]
Function entered at [<008b5720>] from [<008b4258>]
   r6 = 00992400  r5 = 00000002  r4 = 009EDEC0
Function entered at [<008b4204>] from [<008a8fec>]
   r4 = 00000001
Function entered at [<008a8e94>] from [<008b413c>]
Function entered at [<008b3f28>] from [<008b2c08>]
   r7 = 0093DED4  r6 = 009EDEC0  r5 = 0093DED4  r4 = 00A243A0
Function entered at [<008b29e0>] from [<008a8fec>]
   r6 = 00000000  r5 = 00000000  r4 = 00000001
Function entered at [<008a8e94>] from [<008b2768>]
Function entered at [<008b2274>] from [<0089f54c>]
   r8 = 0098BF88  r7 = 00000001  r6 = 00000008  r5 = 00000000
   r4 = 009EDEC0
Function entered at [<0089f2dc>] from [<0089f65c>]
   r6 = 009381AC  r5 = 009381CC  r4 = 0093DED4
Function entered at [<0089f5b4>] from [<0089f7dc>]
Function entered at [<0089f744>] from [<0081e090>]
Function entered at [<0081dfd8>] from [<0081e70c>]
Function entered at [<0081e674>] from [<00810f28>]
   r7 = 00945730  r6 = 0081E674  r5 = 0097E000  r4 = 00000000
Code: ba000003 e93113f8 (e92013f8) e2522020 aafffffb
Error (Oops_bfd_perror): /tmp/ksymoops.BYmaYB Invalid bfd target


  >>LR;  008727cc <rs_write+148/294>

  >>PC;  0090e5fc <memmove+25c/460>   <=====

Trace; 0090e3a0 <memcpy+0/0>
Trace; 008727cc <rs_write+148/294>

  >>r8; 00956228 <tmp_buf+0/1000>

Trace; 00872684 <rs_write+0/294>
Trace; 008820e0 <ppp_async_push+cc/230>
Trace; 00882014 <ppp_async_push+0/230>
Trace; 00882004 <ppp_async_send+40/50>
Trace; 00881fc4 <ppp_async_send+0/50>
Trace; 008794f4 <ppp_push+d0/1b8>
Trace; 00879424 <ppp_push+0/1b8>
Trace; 008793c0 <ppp_send_frame+504/568>
Trace; 00878ebc <ppp_send_frame+0/568>
Trace; 00878e04 <ppp_xmit_process+a4/15c>
Trace; 00878d60 <ppp_xmit_process+0/15c>
Trace; 00878b60 <ppp_start_xmit+254/2c8>
Trace; 0087890c <ppp_start_xmit+0/2c8>
Trace; 008a9c74 <.gcc2_compiled.+68/100>
Trace; 008a9c0c <qdisc_restart+0/0>
Trace; 0089ebf0 <dev_queue_xmit+19c/3b0>

  >>r5; 0094ce60 <irq_stat+0/20>
  >>r4; 0094ce68 <irq_stat+8/20>

Trace; 0089ea54 <dev_queue_xmit+0/3b0>
Trace; 008b781c <ip_finish_output2+d8/150>
Trace; 008b7744 <ip_finish_output2+0/150>
Trace; 008a8fec <nf_hook_slow+158/1f0>
Trace; 008a8e94 <nf_hook_slow+0/1f0>
Trace; 008b58cc <ip_finish_output+1ac/1b8>
Trace; 008b5720 <ip_finish_output+0/1b8>
Trace; 008b4258 <ip_forward_finish+54/98>
Trace; 008b4204 <ip_forward_finish+0/98>
Trace; 008a8fec <nf_hook_slow+158/1f0>
Trace; 008a8e94 <nf_hook_slow+0/1f0>
Trace; 008b413c <.gcc2_compiled.+214/2dc>
Trace; 008b3f28 <ip_forward+0/0>
Trace; 008b2c08 <ip_rcv_finish+228/29c>

  >>r7; 0093ded4 <eth0_dev+0/164>
  >>r5; 0093ded4 <eth0_dev+0/164>

Trace; 008b29e0 <ip_rcv_finish+0/29c>
Trace; 008a8fec <nf_hook_slow+158/1f0>
Trace; 008a8e94 <nf_hook_slow+0/1f0>
Trace; 008b2768 <ip_rcv+4f4/568>
Trace; 008b2274 <ip_rcv+0/568>
Trace; 0089f54c <netif_receive_skb+270/2d8>
Trace; 0089f2dc <netif_receive_skb+0/2d8>
Trace; 0089f65c <process_backlog+a8/190>

  >>r6; 009381ac <softnet_data+c/1a0>
  >>r5; 009381cc <softnet_data+2c/1a0>
  >>r4; 0093ded4 <eth0_dev+0/164>

Trace; 0089f5b4 <process_backlog+0/190>
Trace; 0089f7dc <net_rx_action+98/1bc>
Trace; 0089f744 <net_rx_action+0/1bc>
Trace; 0081e090 <__do_softirq+b8/15c>
Trace; 0081dfd8 <.gcc2_compiled.+0/0>
Trace; 0081e70c <ksoftirqd+98/cc>
Trace; 0081e674 <ksoftirqd+0/cc>
Trace; 00810f28 <arch_kernel_thread+38/44>

  >>r7; 00945730 <__machine_arch_type+0/4>
  >>r6; 0081e674 <ksoftirqd+0/cc>

Kernel panic: Aiee, killing interrupt handler

1 error issued.  Results may not be reliable.


