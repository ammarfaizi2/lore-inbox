Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269699AbUINVXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269699AbUINVXY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUINVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:20:47 -0400
Received: from vapor.arctrix.com ([66.220.1.99]:61452 "HELO vapor.arctrix.com")
	by vger.kernel.org with SMTP id S266175AbUINVNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:13:02 -0400
Date: Tue, 14 Sep 2004 17:13:01 -0400
From: Neil Schemenauer <nas@arctrix.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG: debugging patch
Message-ID: <20040914211301.GA18197@mems-exchange.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

One of our AMD K7 machines seems to be running into the dcache bug.
I'm attaching the oops trace.  Is it possible to apply your BUG
patch to the 2.6.7 or 2.6.8.1 kernel or should I use 2.6.9-rc1-mm5?

Best regards,

  Neil


======================================================================

Unable to handle kernel paging request at virtual address 705f6573
 printing eip:
c01539c6
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: via_rhine crc32 binfmt_capwrap
CPU:    0
EIP:    0060:[prune_dcache+38/288]    Not tainted
EFLAGS: 00010212   (2.6.7) 
EIP is at prune_dcache+0x26/0x120
eax: c038edd4   ebx: c0601ec4   ecx: c8601e50   edx: 705f6573
esi: c05e8be0   edi: 00000061   ebp: f7ffea48   esp: f7d92f0c
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 32, threadinfo=f7d92000 task=f7dc6050)
Stack: 00000080 00000000 f7d92000 c0153d92 c0131417 02c47800 00000000 00030260 
       000000eb 00000000 000000d0 000000c0 c038dca4 00000001 0000000a c038db80 
       c01324b3 00000000 f7d92f9c 000000a0 00000000 000000c0 000000c0 000000c0 
Call Trace:
 [shrink_dcache_memory+18/32] shrink_dcache_memory+0x12/0x20
 [shrink_slab+311/368] shrink_slab+0x137/0x170
 [balance_pgdat+419/496] balance_pgdat+0x1a3/0x1f0
 [kswapd+182/192] kswapd+0xb6/0xc0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [kswapd+0/192] kswapd+0x0/0xc0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Code: 89 02 89 49 04 89 09 a1 d8 ed 38 c0 0f 18 00 90 ff 0d e0 ed 


$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2400+
stepping        : 1
cpu MHz         : 2001.026
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3956.73

