Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268597AbTGIWDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268602AbTGIWDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:03:03 -0400
Received: from www5.mail.lycos.com ([209.202.220.85]:60053 "HELO lycos.com")
	by vger.kernel.org with SMTP id S268597AbTGIWCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:02:39 -0400
To: sitsofe@lycos.com, "Randy.Dunlap" <rddunlap@osdl.org>
Date: Wed, 09 Jul 2003 22:17:09  0000
From: "Sitsofe Wheeler" <sitsofe@lycos.com>
Message-ID: <HKPMABMHDMPELBAA@mailcity.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: on
Reply-To: sitsofe@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: 2.4.21 oops running video capture software
X-Sender-Ip: 80.5.120.62
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: multipart/mixed; boundary="=_-=_-KAPKNAMHDMPELBAA"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
You need a MIME compliant mail reader to completely decode it.

--=_-=_-KAPKNAMHDMPELBAA
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Length: 898
Content-Transfer-Encoding: 7bit

>On Wed, 09 Jul 2003 10:21:42  0000 "Sitsofe Wheeler" <sitsofe@lycos.com> wrote:
>
>| While running video capture software, the kernel will eventually oops in kswapd. There do seem to be some different kernels where it will take longer for this to happen (possibly those with apic support) but so far I haven't been able to isolate them. The oops will only happen while video capture is happening otherwise the system is extremely solid.
>| 
>| The kernel being used is 2.4.21 patched with preempt, low-latency, bootsplash and variable hz (the hz was set to 200).
>
>You'll need to run that oops message thru ksymoops for it to be
>useful.

Ok I've reproduced the crash and attached the output of ksymoops.


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005
--=_-=_-KAPKNAMHDMPELBAA
Content-Type: text/plain; charset=us-ascii; name="ksymoops"
Content-Language: en
Content-Length: 4203
Content-Transfer-Encoding: 7bit

ksymoops 2.4.4 on i686 2.4.21.  Options used
     -v /boot/vmlinux-2.4.21 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (default)

cpu: 0, clocks: 1338969, slice: 669484
8139too Fast Ethernet driver 0.9.26
bttv2: aiee: error loops
bttv1: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv2: aiee: error loops
bttv2: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv2: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv1: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
bttv3: aiee: error loops
Unable to handle kernel NULL pointer dereference at virtual address 0000001b
ce95cef7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<ce95cef7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000100   edi: 00000200   ebp: cb18fbf8   esp: cb18fbb0
ds: 0018   es: 0018   ss: 0018
Process motion (pid: 1203, stackpage=cb18f000)
Stack: cafd63d8 00000480 00000480 00000000 0001b000 00000001 cf400000 cf474480 
       cf459480 00000001 cb18fc08 00000000 b4000000 00850001 03000240 0000000f 
       00000300 cf3e7000 cb18fc44 ce95d79c ce96efa4 cafd4634 cafd63e0 cf3e7000 
Call Trace:    [<ce95d79c>] [<ce96efa4>] [<ce96efa4>] [<ce95e390>] [<ce96efa4>]
  [<ce96f138>] [<ce96efa4>] [<ce95eeb9>] [<ce96efa4>] [<c01647e5>] [<c0170059>]
  [<c016972f>] [<c016f9c1>] [<c0169c01>] [<c0169c12>] [<c016f6de>] [<c011a200>]
  [<c0125a6d>] [<c0126441>] [<c0122897>] [<c0122774>] [<c01225a3>] [<c010a776>]
  [<c010ceb3>] [<c013669f>] [<c0137487>] [<c012dfcc>] [<c012f210>] [<c0136fee>]
  [<c01365e4>] [<c012edd3>] [<ce9433a8>] [<ce96efa4>] [<c014e9c2>] [<c0109233>]
Code: 8a 40 1b 25 ff 00 00 00 8b 04 85 7c ad 2a c0 8b 88 9c 00 00 

>>EIP; ce95cef7 <[bttv]make_prisctab+237/5d0>   <=====
Trace; ce95d79c <[bttv]make_vrisctab+50c/530>
Trace; ce96efa4 <[bttv]bttvs+524/1490>
Trace; ce96efa4 <[bttv]bttvs+524/1490>
Trace; ce95e390 <[bttv]vgrab+100/2e0>
Trace; ce96efa4 <[bttv]bttvs+524/1490>
Trace; ce96f138 <[bttv]bttvs+6b8/1490>
Trace; ce96efa4 <[bttv]bttvs+524/1490>
Trace; ce95eeb9 <[bttv]bttv_ioctl+4e9/1530>
Trace; ce96efa4 <[bttv]bttvs+524/1490>
Trace; c01647e5 <ext3_new_block+445/870>
Trace; c0170059 <journal_dirty_metadata+149/1d0>
Trace; c016972f <ext3_do_update_inode+17f/3b0>
Trace; c016f9c1 <journal_get_write_access+41/60>
Trace; c0169c01 <ext3_mark_iloc_dirty+21/60>
Trace; c0169c12 <ext3_mark_iloc_dirty+32/60>
Trace; c016f6de <do_get_write_access+2fe/5a0>
Trace; c011a200 <__wake_up+20/50>
Trace; c0125a6d <update_wall_time+d/40>
Trace; c0126441 <update_times+f1/100>
Trace; c0122897 <bh_action+47/90>
Trace; c0122774 <tasklet_hi_action+44/70>
Trace; c01225a3 <do_softirq+e3/f0>
Trace; c010a776 <do_IRQ+106/140>
Trace; c010ceb3 <call_do_IRQ+5/12>
Trace; c013669f <kfree+6f/b0>
Trace; c0137487 <lru_cache_del+17/30>
Trace; c012dfcc <__vma_link+4c/c0>
Trace; c012f210 <__insert_vm_struct+50/70>
Trace; c0136fee <kmem_cache_free_one+10e/220>
Trace; c01365e4 <kmem_cache_free+74/c0>
Trace; c012edd3 <do_munmap+263/290>
Trace; ce9433a8 <[videodev]video_ioctl+18/30>
Trace; ce96efa4 <[bttv]bttvs+524/1490>
Trace; c014e9c2 <sys_ioctl+d2/1f0>
Trace; c0109233 <system_call+33/40>
Code;  ce95cef7 <[bttv]make_prisctab+237/5d0>
00000000 <_EIP>:
Code;  ce95cef7 <[bttv]make_prisctab+237/5d0>   <=====
   0:   8a 40 1b                  mov    0x1b(%eax),%al   <=====
Code;  ce95cefa <[bttv]make_prisctab+23a/5d0>
   3:   25 ff 00 00 00            and    $0xff,%eax
Code;  ce95ceff <[bttv]make_prisctab+23f/5d0>
   8:   8b 04 85 7c ad 2a c0      mov    0xc02aad7c(,%eax,4),%eax
Code;  ce95cf06 <[bttv]make_prisctab+246/5d0>
   f:   8b 88 9c 00 00 00         mov    0x9c(%eax),%ecx

--=_-=_-KAPKNAMHDMPELBAA--

