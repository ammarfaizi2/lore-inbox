Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSGRMZm>; Thu, 18 Jul 2002 08:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318030AbSGRMZm>; Thu, 18 Jul 2002 08:25:42 -0400
Received: from basket.ball.reliam.net ([213.91.6.7]:50182 "HELO
	basket.ball.reliam.net") by vger.kernel.org with SMTP
	id <S318027AbSGRMZl>; Thu, 18 Jul 2002 08:25:41 -0400
Date: Thu, 18 Jul 2002 14:29:39 +0200
From: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Mailer: The Bat! (v1.60q)
Reply-To: Tobias Rittweiler <inkognito.anonym@uni.de>
X-Priority: 3 (Normal)
Message-ID: <139914576.20020718142939@uni.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: 2.5.26 broken on headless boxes
In-Reply-To: <20020718104604.GQ1096@holomorphy.com>
References: <20020717165538.D13352@parcelfarce.linux.theplanet.co.uk>
 <20020718010617.GL1096@holomorphy.com> <1251977776.20020718114800@uni.de>
 <20020718104604.GQ1096@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello William,

Thursday, July 18, 2002, 12:46:04 PM, you wrote:

WLII> Please, decode your oopses.

Ville Herva did already point me to do this, thanks.

=======================================================
ksymoops 2.4.5 on i686 2.5.25.  Options used
     -v linux-2.5.26/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m linux-2.5.26/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c025a9d7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c025a9d7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c039e060   ecx: 00000013   edx: c02db5d4
esi: 00000014   edi: 00000000   ebp: c02dc85c   esp: c11f3f98
ds: 0018   es: 0018   ss: 0018
Stack: c02f86cc c02dc85c 00000014 00000000 c02dffc8 c039df41 0008e000 00000005
       c039e000 c02f8618 c039df20 c11c5360 00000000 c02589ac c031ebe8 00000000
       c02e0746 c11f2000 c02e077f c0105073 00010f00 c02dffc8 c01056a4 00000000
Call Trace: [<c02589ac>] [<c0105073>] [<c01056a4>]
Code: 83 38 00 75 f4 0f b7 c1 c3 8b 54 24 04 8b 4c 24 08 31 c0 49


>>EIP; c025a9d7 <find_next_offset+1f/28>   <=====

>>ebx; c039e060 <llc_offset_table+60/f0>
>>edx; c02db5d4 <llc_reject_state_transitions+9c/d8>
>>ebp; c02dc85c <llc_conn_state_table+20/60>
>>esp; c11f3f98 <END_OF_CODE+e55c28/????>

Trace; c02589ac <mac_indicate+0/224>
Trace; c0105073 <init+2b/178>
Trace; c01056a4 <kernel_thread+28/38>

Code;  c025a9d7 <find_next_offset+1f/28>
00000000 <_EIP>:
Code;  c025a9d7 <find_next_offset+1f/28>   <=====
   0:   83 38 00                  cmpl   $0x0,(%eax)   <=====
Code;  c025a9da <find_next_offset+22/28>
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> c025a9d0 <find_next_offset+18/28>
Code;  c025a9dc <find_next_offset+24/28>
   5:   0f b7 c1                  movzwl %cx,%eax
Code;  c025a9df <find_next_offset+27/28>
   8:   c3                        ret    
Code;  c025a9e0 <llc_find_offset+0/4b>
   9:   8b 54 24 04               mov    0x4(%esp,1),%edx
Code;  c025a9e4 <llc_find_offset+4/4b>
   d:   8b 4c 24 08               mov    0x8(%esp,1),%ecx
Code;  c025a9e8 <llc_find_offset+8/4b>
  11:   31 c0                     xor    %eax,%eax
Code;  c025a9ea <llc_find_offset+a/4b>
  13:   49                        dec    %ecx

 <0>Kernel panic: Attempted to kill init!
=======================================================

--
cheers,
  Tobias

http://freebits.org

