Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTJVFKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 01:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTJVFKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 01:10:42 -0400
Received: from web13904.mail.yahoo.com ([216.136.175.67]:15880 "HELO
	web13904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263422AbTJVFKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 01:10:35 -0400
Message-ID: <20031022051034.2702.qmail@web13904.mail.yahoo.com>
Date: Tue, 21 Oct 2003 22:10:34 -0700 (PDT)
From: Troy Rockwood <troyrock@rocketmail.com>
Subject: Kernel BUG at /usr/src/build/295325-athlon/BUILD/kernel-2.4.20/linux-2.4.20/include/linux/mm_inline.h:160!
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I'm not really sure what the protocol is for reporting bugs or even
if this is relevant.  If it's not, or if I did the wrong thing, please
send me back a note and I'll not do it again.

My machine hung while my wife was browsing with Mozilla (had to do a
hard reset).  I can't consistently duplicate the problem but the
following appeared in the syslog:

Oct 21 21:52:56 quiteblue kernel: ------------[ cut here ]------------
Oct 21 21:52:56 quiteblue kernel: kernel BUG at
/usr/src/build/295325-athlon/BUILD/kernel-2.4.20/linux-2.4.20/include/linux/mm_inline.h:160!
Oct 21 21:52:56 quiteblue kernel: invalid operand: 0000
Oct 21 21:52:56 quiteblue kernel: sr_mod via82cxxx_audio uart401
ac97_codec sound soundcore sch_ingress cls_u32 sch_sfq sch_cbq
ipt_state ipt_LOG ipt_limit iptable_mangle iptable_nat iptable_f
Oct 21 21:52:56 quiteblue kernel: CPU:    0
Oct 21 21:52:56 quiteblue kernel: EIP:    0010:[<c012f55a>]    Not
tainted
Oct 21 21:52:56 quiteblue kernel: EFLAGS: 00010206
Oct 21 21:52:56 quiteblue kernel:
Oct 21 21:52:56 quiteblue kernel: EIP is at deactivate_page_nolock
[kernel] 0x8a (2.4.20-20.7)
Oct 21 21:52:56 quiteblue kernel: eax: 020c1099   ebx: c1f22f68   ecx:
c1f22f84   edx: c1f54bfc
Oct 21 21:52:56 quiteblue kernel: esi: c02daef0   edi: 00000005   ebp:
0000c692   esp: c3abdf90
Oct 21 21:52:56 quiteblue kernel: ds: 0018   es: 0018   ss: 0018
Oct 21 21:52:56 quiteblue kernel: Process kswapd (pid: 5,
stackpage=c3abd000)
Oct 21 21:52:57 quiteblue kernel: Stack: c1f22f84 c1f22f68 00000005
c0132227 c3abc000 0000001a fffffffe 00000003
Oct 21 21:52:57 quiteblue kernel:        00000026 000004e0 00000001
000004db 66666667 c02daef0 c3abc000 c0133860
Oct 21 21:52:57 quiteblue kernel:        c02daef0 00000006 0000001a
00000000 00010f00 c219bfa0 c0105000 0008e000
Oct 21 21:52:57 quiteblue kernel: Call Trace:   [<c0132227>]
refill_inactive_zone [kernel] 0x1077 (0xc3abdf9c))
Oct 21 21:52:57 quiteblue kernel: [<c0133860>] kswapd [kernel] 0x2a0
(0xc3abdfcc))
Oct 21 21:52:57 quiteblue kernel: [<c0105000>] stext [kernel] 0x0
(0xc3abdfe8))
Oct 21 21:52:57 quiteblue kernel: [<c01070d6>] arch_kernel_thread
[kernel] 0x26 (0xc3abdff0))
Oct 21 21:52:57 quiteblue kernel: [<c01335c0>] kswapd [kernel] 0x0
(0xc3abdff8))
Oct 21 21:52:57 quiteblue kernel:
Oct 21 21:52:57 quiteblue kernel:
Oct 21 21:52:57 quiteblue kernel: Code: 0f 0b a0 00 c0 f7 22 c0 8b 43
18 ba 07 00 00 00 a9 80 00 00

I can't say how thankful I am to everyone that works on the linux
kernel.  I use linux all the time and love it.  Please accept my most
sincere thanks for your work.

=====
Troy Rockwood - troyrock@rocketmail.com

That which we obtain too easily, we esteem too lightly. It is dearness only which gives everything its value. Heaven knows how to put a proper price on its goods.   -- Thomas Paine

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
