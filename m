Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUGWAFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUGWAFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 20:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267432AbUGWAFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 20:05:49 -0400
Received: from S01060001023ff1ee.su.shawcable.net ([24.76.66.102]:19584 "EHLO
	spacebox.net") by vger.kernel.org with ESMTP id S267431AbUGWAFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 20:05:31 -0400
Date: Thu, 22 Jul 2004 20:08:53 -0400
From: Matt DeLuco <duke@spacebox.net>
To: linux-kernel@vger.kernel.org
Subject: [duke@spacebox.net: oops related crash]
Message-ID: <20040723000853.GB2483@mobius.su.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
X-URL: http://spacebox.net/
X-HTML: HTML in email is a Bad Thing(tm).
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, sorry for the double post.  While I did read
Documentation/oops-tracing.txt, I failed to read the rest of the bug
report document on kernel.org.  Here's the rest of the info.

/proc/version:

Linux version 2.4.26 (root@spacebox.net) (gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r6, ssp-3.3.2-2, pie-8.7.6)) #2 Sun Jun 27 13:34:35 EDT 2004


scripts/ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
 Linux spacebox.net 2.4.26 #2 Sun Jun 27 13:34:35 EDT 2004 i686 AMD
 Athlon(tm) processor AuthenticAMD GNU/Linux
  
  Gnu C                  3.3.3
  Gnu make               3.80
  util-linux             2.12
  mount                  2.12
  modutils               2.4.26
  e2fsprogs              1.34
  reiserfsprogs          3.6.3
  Linux C Library        2.3.3
  head: `-1' option is obsolete; use `-n 1' since this will be removed
  in the future
  Dynamic linker (ldd)   2.3.3
  Procps                 3.1.15
  Net-tools              1.60
  Kbd                    1.08
  Sh-utils               5.2.1
  Modules Loaded         rtc usbcore iptable_filter ipt_state ipt_LOG
  ipt_MIRROR ipt_REJECT nfsd lockd sunrpc via686a i2c-proc i2c-isa
  i2c-viapro i2c-core

  
/proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 2
cpu MHz         : 1302.999
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2601.77


/proc/modules:

rtc                     7080   0 (autoclean)
usbcore                39236   0 (unused)
iptable_filter          1740   1
ipt_state                504   1
ipt_LOG                 3416   0 (unused)
ipt_MIRROR              1304   0 (unused)
ipt_REJECT              3512   0 (unused)
nfsd                   72880   0
lockd                  51920   0 [nfsd]
sunrpc                 68704   0 [nfsd lockd]
via686a                 7828   0 (unused)
i2c-proc                6900   0 [via686a]
i2c-isa                  716   0 (unused)
i2c-viapro              3436   0 (unused)
i2c-core               15460   0 [via686a i2c-proc i2c-isa i2c-viapro]

(note: module nfs was loaded but unused at the time of the crash.)


/proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  5000-5007 : viapro-smbus
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  6000-607f : via686a-sensors
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Radeon R100 QD [Radeon 7200]
d000-d003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
d400-d40f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE
  d400-d407 : ide0
  d408-d40f : ide1
d800-d81f : VIA Technologies, Inc. USB
dc00-dc1f : VIA Technologies, Inc. USB (#2)
e000-e07f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
  e000-e07f : 00:0d.0
e400-e4ff : Accton Technology Corporation SMC2-1211TX
  e400-e4ff : 8139too


/proc/iomem:

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0020c991 : Kernel code
  0020c992-00249aa3 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : ATI Technologies Inc Radeon R100 QD [Radeon 7200]
f8000000-f9ffffff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
fa000000-fbffffff : PCI Bus #01
  fb000000-fb00ffff : ATI Technologies Inc Radeon R100 QD [Radeon 7200]
fd000000-fd00007f : 3Com Corporation 3c900B-TPO [Etherlink XL TPO]
fd001000-fd001fff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
fd002000-fd0020ff : Accton Technology Corporation SMC2-1211TX
  fd002000-fd0020ff : 8139too
ffff0000-ffffffff : reserved


lspci -vvv:

I just got this while trying to compile pciutils -

collect2: ld terminated with signal 11 [Segmentation fault]

followed by a whack of compiler errors involving invalid string offsets.
Is this indicative of a hardware problem?  I recently had memory issues
with another machine - I did run memtest86+ after this crash though not
for very long (no errors.)  I had no problems compiling ksymoops
though.

I've also recently been having problems getting rpc.nfsd to run, though
I couldn't say if it's related.  I ran it through strace and although I
don't know what I'm looking for there were a few odd things that stood
out.  Basically nfsd couldn't contact the localhost, which is strange,
because it only stopped working recently, and I have nothing blocking it
(firewalls, etc.)


Thanks again,

    -- Matt.

--1LKvkjL3sHcu1TtY
Content-Type: message/rfc822
Content-Disposition: inline

Date: Thu, 22 Jul 2004 19:50:10 -0400
From: Matt DeLuco <duke@spacebox.net>
To: linux-kernel@vger.kernel.org
Subject: oops related crash
Message-ID: <20040722235010.GA2483@mobius.su.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
X-URL: http://spacebox.net/
X-HTML: HTML in email is a Bad Thing(tm).
User-Agent: Mutt/1.5.6i


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

last night I had a seemingly random crash with serveral oopses.  I say
random because my debug log showed nothing for 7 hours between the last
log and the oops log.  Though I don't really know if that's significant.

Anywho, I read Documentation/oops-tracing.txt.  As suggested I ran the
oops through ksymoops and I've attached the output.  I'm not sure how
reliable it'll be.. I had to edit all the log stuff (host, date/time,
etc.) out of the oops.

I'm running a "vanilla" 2.4.26 kernel with a patch I inserted manually
to prevent distcc from causing the system to crash.  The patch seemed to
be holding up well, and nothing was being compiled at the time of last
night's oops attack.  I have attached the patch (which I found on the
lkml.)

Sorry for not having done much else, but my skills in dealing with the
kernel are.. limited at best.

I hope this info is useful.  Please let me know if there's anything else
I can do.

Thanks,

    -- Matt.

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.out"

ksymoops 2.4.9 on i686 2.4.26.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /usr/src/linux/System.map (default)

Warning (compare_maps): ksyms_base symbol sk_chk_filter_R__ver_sk_chk_filter not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol sk_run_filter_R__ver_sk_run_filter not found in vmlinux.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 31383131
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__kmem_cache_alloc+160/240]    Not tainted
EIP:    0010:[<c012aa00>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 31383131   ebx: c158f5d8   ecx: d5667540  
esi: c158f5d0   edi: 00000246   ebp: 000001f0  
ds: 0018   es: 0018   ss: 0018
Process ircd (pid: 2342, stackpage=d8ad9000)
Stack: 000005a8 d86d8118 d9572c00 000001f0 d86d817c c788e2e0 c01b810a c158f5d0 
000001f0 d86d80c0 d86d80c0 c01d4749 00000680 000001f0 00000042 00000000 
d8ad9e28 00000000 d8ad8000 00000001 00000000 00000000 d86d8118 402bc4d8 
Call Trace:    [alloc_skb+170/448] [tcp_sendmsg+2297/4032] [inet_recvmsg+82/112] [inet_sendmsg+66/80] [sock_sendmsg+117/176]
Call Trace:    [<c01b810a>] [<c01d4749>] [<c01f1482>] [<c01f14e2>] [<c01b4c55>] [sockfd_lookup+28/128] [sockfd_lookup+28/128] [sys_sendto+227/256] [locate_hd_struct+56/144] [account_io_end+42/80] [req_finished_io+76/96] [<c01b4a6c>] [<c01b4a6c>] [<c01b5c93>] [<c0193968>] [<c0193a7a>] [<c0193bcc>] [sock_poll+44/64] [do_pollfd+79/144] [sys_send+55/64] [sys_socketcall+311/608] [system_call+51/56] [<c01b513c>] [<c014232f>] [<c01b5ce7>] [<c01b6557>] [<c010720b>]
Code: 89 10 89 42 04 c7 01 00 00 00 00 8b 46 08 89 48 04 89 01 89 


>>EIP; c012aa00 <__kmem_cache_alloc+a0/f0>   <=====

>>ebx; c158f5d8 <_end+12dc514/205adf9c>
>>ecx; d5667540 <_end+153b447c/205adf9c>
>>esi; c158f5d0 <_end+12dc50c/205adf9c>

Trace; c01b810a <alloc_skb+aa/1c0>
Trace; c01d4749 <tcp_sendmsg+8f9/fc0>
Trace; c01f1482 <inet_recvmsg+52/70>
Trace; c01f14e2 <inet_sendmsg+42/50>
Trace; c01b4c55 <sock_sendmsg+75/b0>

Code;  c012aa00 <__kmem_cache_alloc+a0/f0>
00000000 <_EIP>:
Code;  c012aa00 <__kmem_cache_alloc+a0/f0>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c012aa02 <__kmem_cache_alloc+a2/f0>
   2:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c012aa05 <__kmem_cache_alloc+a5/f0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c012aa0b <__kmem_cache_alloc+ab/f0>
   b:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c012aa0e <__kmem_cache_alloc+ae/f0>
   e:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012aa11 <__kmem_cache_alloc+b1/f0>
  11:   89 01                     mov    %eax,(%ecx)
Code;  c012aa13 <__kmem_cache_alloc+b3/f0>
  13:   89 00                     mov    %eax,(%eax)

<1>Unable to handle kernel paging request at virtual address 31303838
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__kmem_cache_alloc+160/240]    Not tainted
EIP:    0010:[<c012aa00>]    Not tainted
EFLAGS: 00010006
eax: 31303838   ebx: c158f5d8   ecx: d5667540  
esi: c158f5d0   edi: 00000246   ebp: 000001f0  
ds: 0018   es: 0018   ss: 0018
Process gkrellmd (pid: 1754, stackpage=dd62d000)
Stack: 00000008 00000282 d7298780 000001f0 d86d8e7c cceeede0 c01b810a c158f5d0 000001f0 d86d8dc0 d86d8dc0 c01d4749 00000680 000001f0 00000002 ffffffff c48ab220 fffffff4 c0239638 c0239808 00000000 000001d2 d86d8e18 08063e48 
Call Trace:    [alloc_skb+170/448] [tcp_sendmsg+2297/4032] [inet_sendmsg+66/80] [sock_sendmsg+117/176] [sockfd_lookup+28/128]
Call Trace:    [<c01b810a>] [<c01d4749>] [<c01f14e2>] [<c01b4c55>] [<c01b4a6c>] [sys_sendto+227/256] [link_path_walk+1333/1664] [cp_new_stat64+247/288] [sys_send+55/64] [sys_socketcall+311/608] [math_state_restore+30/64] [<c01b5c93>] [<c013d4e5>] [<c013a3a7>] [<c01b5ce7>] [<c01b6557>] [<c010828e>] [system_call+51/56] [<c010720b>]
Code: 89 10 89 42 04 c7 01 00 00 00 00 8b 46 08 89 48 04 89 01 89 


>>EIP; c012aa00 <__kmem_cache_alloc+a0/f0>   <=====

>>ebx; c158f5d8 <_end+12dc514/205adf9c>
>>ecx; d5667540 <_end+153b447c/205adf9c>
>>esi; c158f5d0 <_end+12dc50c/205adf9c>

Trace; c01b810a <alloc_skb+aa/1c0>
Trace; c01d4749 <tcp_sendmsg+8f9/fc0>
Trace; c01f14e2 <inet_sendmsg+42/50>
Trace; c01b4c55 <sock_sendmsg+75/b0>
Trace; c01b4a6c <sockfd_lookup+1c/80>

Code;  c012aa00 <__kmem_cache_alloc+a0/f0>
00000000 <_EIP>:
Code;  c012aa00 <__kmem_cache_alloc+a0/f0>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c012aa02 <__kmem_cache_alloc+a2/f0>
   2:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c012aa05 <__kmem_cache_alloc+a5/f0>
   5:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c012aa0b <__kmem_cache_alloc+ab/f0>
   b:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c012aa0e <__kmem_cache_alloc+ae/f0>
   e:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012aa11 <__kmem_cache_alloc+b1/f0>
  11:   89 01                     mov    %eax,(%ecx)
Code;  c012aa13 <__kmem_cache_alloc+b3/f0>
  13:   89 00                     mov    %eax,(%eax)

<1>Unable to handle kernel paging request at virtual address 32333031
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[kmem_cache_reap+128/448]    Not tainted
EIP:    0010:[<c012a4f0>]    Not tainted
EFLAGS: 00010003
eax: 32333031   ebx: 00000001   ecx: c158f5d0  
esi: 00000000   edi: 00000001   ebp: c158f6a8  
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1599000)
Stack: c11c89d4 000001d0 c158f5d0 00000000 00000003 00000003 00000020 000001d0 c0239638 c0239638 c012b3ec c1599f84 000001d0 0000003c 00000020 c012b483 c1599f84 c1598000 00000000 00000000 c0239638 c1598000 c0239560 00000000 
Call Trace:    [shrink_caches+28/96] [try_to_free_pages_zone+83/224] [kswapd_balance_pgdat+94/160] [kswapd_balance+25/48] [kswapd+141/176]
Call Trace:    [<c012b3ec>] [<c012b483>] [<c012b62e>] [<c012b689>] [<c012b7ad>] [kswapd+0/176] [rest_init+0/64] [arch_kernel_thread+43/64] [kswapd+0/176] [<c012b720>] [<c0105000>] [<c010574b>] [<c012b720>]
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c012a4f0 <kmem_cache_reap+80/1c0>   <=====

>>ecx; c158f5d0 <_end+12dc50c/205adf9c>
>>ebp; c158f6a8 <_end+12dc5e4/205adf9c>

Trace; c012b3ec <shrink_caches+1c/60>
Trace; c012b483 <try_to_free_pages_zone+53/e0>
Trace; c012b62e <kswapd_balance_pgdat+5e/a0>
Trace; c012b689 <kswapd_balance+19/30>
Trace; c012b7ad <kswapd+8d/b0>


3 warnings issued.  Results may not be reliable.

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="distcc.patch"

--- a/mm/page_alloc.c.orig 2004-04-29 17:38:14.184021976 -0300
+++ b/mm/page_alloc.c 2004-04-29 17:47:27.906843312 -0300
@@ -46,6 +46,34 @@
 
 int vm_gfp_debug = 0;
 
+static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
+
+static spinlock_t free_pages_ok_no_irq_lock = SPIN_LOCK_UNLOCKED;
+struct page * free_pages_ok_no_irq_head;
+
+static void do_free_pages_ok_no_irq(void * arg)
+{
+       struct page * page, * __page;
+
+       spin_lock_irq(&free_pages_ok_no_irq_lock);
+
+       page = free_pages_ok_no_irq_head;
+       free_pages_ok_no_irq_head = NULL;
+
+       spin_unlock_irq(&free_pages_ok_no_irq_lock);
+
+       while (page) {
+               __page = page;
+               page = page->next_hash;
+               __free_pages_ok(__page, __page->index);
+       }
+}
+
+static struct tq_struct free_pages_ok_no_irq_task = {
+       .routine        = do_free_pages_ok_no_irq,
+};
+
+
 /*
  * Temporary debugging check.
  */
@@ -81,7 +109,6 @@
  * -- wli
  */
 
-static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
 static void __free_pages_ok (struct page *page, unsigned int order)
 {
  unsigned long index, page_idx, mask, flags;
@@ -94,8 +121,20 @@
   * a reference to a page in order to pin it for io. -ben
   */
  if (PageLRU(page)) {
-  if (unlikely(in_interrupt()))
-   BUG();
+  if (unlikely(in_interrupt())) {
+   unsigned long flags;
+
+   spin_lock_irqsave(&free_pages_ok_no_irq_lock, flags);
+   page->next_hash = free_pages_ok_no_irq_head;
+   free_pages_ok_no_irq_head = page;
+   page->index = order;
+ 
+   spin_unlock_irqrestore(&free_pages_ok_no_irq_lock, flags);
+ 
+   schedule_task(&free_pages_ok_no_irq_task);
+   return;
+  }
+  
   lru_cache_del(page);
  }

--gKMricLos+KVdGMg--

--1LKvkjL3sHcu1TtY--
