Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129895AbQJaQFr>; Tue, 31 Oct 2000 11:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129885AbQJaQFi>; Tue, 31 Oct 2000 11:05:38 -0500
Received: from z211-19-80-17.dialup.wakwak.ne.jp ([211.19.80.17]:62710 "EHLO
	220fx.luky.org") by vger.kernel.org with ESMTP id <S129809AbQJaQFX>;
	Tue, 31 Oct 2000 11:05:23 -0500
To: axboe@suse.de
Cc: shibata@luky.org, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
In-Reply-To: <20001030145950.E521@suse.de>
In-Reply-To: <20001029141214.B615@suse.de>
	<20001031031455T.shibata@luky.org>
	<20001030145950.E521@suse.de>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Nov__1_01:08:05_2000_559)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20001101010806O.shibata@luky.org>
Date: Wed, 01 Nov 2000 01:08:06 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Wed_Nov__1_01:08:05_2000_559)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

> > By using serial console, I get messages for you ;-)
> 
> Thanks, now you're just one step short of being really
> helpful :-). Pass it through ksymoops please, so the
> addresses will map to function names + offsets.

I atacched files. Is it OK?

> > hdc: timeout waiting for DMA
> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> 
> Try it without DMA as well, please. I think I see a DMA bug in there right
> now, I'll recheck and send you a new patch.

I see. I will try it and will report it.

Best Regards,

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata
0(mmm)0 P-mail: 070-5419-3233    IRC: #luky
   ~    http://his.luky.org/ last update:2000.3.12

----Next_Part(Wed_Nov__1_01:08:05_2000_559)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="trace2.txt"

ksymoops 2.3.4 on i686 2.2.17-RAID-reiser-ide.all-ide-cd.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17-RAID-reiser-ide.all-ide-cd/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
current->tss.cr3 = 13185000, %cr3 = 13185000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01a7b0a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000000   ebx: 0000f008   ecx: 128e395c   edx: c02402d8
esi: 00000001   edi: d7fda800   ebp: c0240318   esp: d3013bec
ds: 0018   es: 0018   ss: 0018
Process fdisk (pid: 704, process nr: 60, stackpage=d3013000)
Stack: c02402d8 c0240318 00000002 00000087 c017d6bc c01c5d49 000001c2 00000000
       c016afd4 c01a7fde c0240318 00000001 00000001 c019a771 c0240318 d5960e00
       00008000 00000001 c0240318 d5960e00 00000000 00000001 c02296f8 00000286
Call Trace: [<c017d6bc>] [<c01c5d49>] [<c016afd4>] [<c01a7fde>] [<c019a771>] [<c01a9f82>] [<d8aaf81c>]
       [<d8aaf85a>] [<c019961a>] [<c01c5d49>] [<d8ab0832>] [<d8ab0788>] [<c012c44f>] [<d8ab094d>] [<c019aa66>]
       [<c012c44f>] [<c019adc6>] [<c01989cf>] [<c019ae8b>] [<c0197bb0>] [<d880164c>] [<c012b631>] [<d880164c>]
       [<c0164430>] [<d8800000>] [<d8801674>] [<d8801680>] [<c0167623>] [<d880164c>] [<d8820e3c>] [<c0166933>]
       [<c01d99cf>] [<c0159d77>] [<c012e95c>] [<c012b8f7>] [<c012b8ee>] [<c01b8aa4>] [<c012b94d>] [<c010a47d>]
       [<c010a344>]
Code: 8b 58 2c c7 44 24 1c 00 00 00 00 85 db 75 13 8b 70 20 8b 48 

>>EIP; c01a7b0a <ide_build_dmatable+1a/114>   <=====
Trace; c017d6bc <tcp_write_space+1c/60>
Trace; c01c5d49 <__const_udelay+29/30>
Trace; c016afd4 <kfree_skbmem+3c/4c>
Trace; c01a7fde <ide_dmaproc+e2/20c>
Trace; c019a771 <ide_wait_stat+85/e8>
Trace; c01a9f82 <piix_dmaproc+2e/38>
Trace; d8aaf81c <END_OF_CODE+e1f9/????>
Trace; d8aaf85a <END_OF_CODE+e237/????>
Trace; c019961a <ide_end_request+4e/94>
Trace; c01c5d49 <__const_udelay+29/30>
Trace; d8ab0832 <END_OF_CODE+f20f/????>
Trace; d8ab0788 <END_OF_CODE+f165/????>
Trace; c012c44f <refile_buffer+57/bc>
Trace; d8ab094d <END_OF_CODE+f32a/????>
Trace; c019aa66 <start_request+17e/1ec>
Trace; c012c44f <refile_buffer+57/bc>
Trace; c019adc6 <ide_do_request+2ce/32c>
Trace; c01989cf <make_request+673/844>
Trace; c019ae8b <do_ide1_request+13/1c>
Trace; c0197bb0 <unplug_device+48/58>
Trace; d880164c <_end+185bece4/186b9698>
Trace; c012b631 <__wait_on_buffer+c1/134>
Trace; d880164c <_end+185bece4/186b9698>
Trace; c0164430 <flush_commit_list+2dc/44c>
Trace; d8800000 <_end+185bd698/186b9698>
Trace; d8801674 <_end+185bed0c/186b9698>
Trace; d8801680 <_end+185bed18/186b9698>
Trace; c0167623 <do_journal_end+767/9d0>
Trace; d880164c <_end+185bece4/186b9698>
Trace; d8820e3c <_end+185de4d4/186b9698>
Trace; c0166933 <flush_old_commits+1d3/1e4>
Trace; c01d99cf <cprt+6f4f/8640>
Trace; c0159d77 <reiserfs_write_super+1b/28>
Trace; c012e95c <sync_supers+70/84>
Trace; c012b8f7 <fsync_dev+1f/4c>
Trace; c012b8ee <fsync_dev+16/4c>
Trace; c01b8aa4 <write_chan+0/24c>
Trace; c012b94d <sys_sync+29/44>
Trace; c010a47d <error_code+2d/40>
Trace; c010a344 <system_call+34/40>
Code;  c01a7b0a <ide_build_dmatable+1a/114>
00000000 <_EIP>:
Code;  c01a7b0a <ide_build_dmatable+1a/114>   <=====
   0:   8b 58 2c                  mov    0x2c(%eax),%ebx   <=====
Code;  c01a7b0d <ide_build_dmatable+1d/114>
   3:   c7 44 24 1c 00 00 00      movl   $0x0,0x1c(%esp,1)
Code;  c01a7b14 <ide_build_dmatable+24/114>
   a:   00 
Code;  c01a7b15 <ide_build_dmatable+25/114>
   b:   85 db                     test   %ebx,%ebx
Code;  c01a7b17 <ide_build_dmatable+27/114>
   d:   75 13                     jne    22 <_EIP+0x22> c01a7b2c <ide_build_dmatable+3c/114>
Code;  c01a7b19 <ide_build_dmatable+29/114>
   f:   8b 70 20                  mov    0x20(%eax),%esi
Code;  c01a7b1c <ide_build_dmatable+2c/114>
  12:   8b 48 00                  mov    0x0(%eax),%ecx


2 warnings issued.  Results may not be reliable.

----Next_Part(Wed_Nov__1_01:08:05_2000_559)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="trace1.txt"

ksymoops 2.3.4 on i686 2.2.17-RAID-reiser-ide.all-ide-cd.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17-RAID-reiser-ide.all-ide-cd/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000014
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d8ab07a1>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000000   ebx: c0240318   ecx: 00000003   edx: d8ab0788
esi: d58a2600   edi: 00000080   ebp: 00000001   esp: c020dd74
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c020d000)
Stack: 00000080 00000001 c0240318 d58a2600 00008000 00000001 c0229c20 00000286
       00feaac0 0080a3a4 c022d900 d2f157a0 c0229c20 d8aaf81c c020dde8 c0240318
       00000000 d8aaf917 c0240318 00000000 00000188 c019961a 00000000 d58a2600
Call Trace: [<d8aaf81c>] [<d8aaf917>] [<c019961a>] [<c01c5d49>] [<d8ab0832>] [<d8ab0788>] [<d8ab094d>]
       [<c019aa66>] [<c019adc0>] [<c019adc6>] [<c019b19e>] [<c019af74>] [<c011123b>] [<c0115775>] [<c0111994>]
       [<c0111946>] [<c011c99d>] [<c0106000>] [<c010ca89>] [<c010caa0>] [<c010b4f8>] [<c0106000>] [<c0108a11>]
       [<c0106000>] [<c010607c>] [<c0106000>] [<c01001ae>]
Code: 8b 50 14 8b 70 10 8d 44 24 34 89 44 24 18 c1 ee 02 31 c0 8b

>>EIP; d8ab07a1 <END_OF_CODE+f17e/????>   <=====
Trace; d8aaf81c <END_OF_CODE+e1f9/????>
Trace; d8aaf917 <END_OF_CODE+e2f4/????>
Trace; c019961a <ide_end_request+4e/94>
Trace; c01c5d49 <__const_udelay+29/30>
Trace; d8ab0832 <END_OF_CODE+f20f/????>
Trace; d8ab0788 <END_OF_CODE+f165/????>
Trace; d8ab094d <END_OF_CODE+f32a/????>
Trace; c019aa66 <start_request+17e/1ec>
Trace; c019adc0 <ide_do_request+2c8/32c>
Trace; c019adc6 <ide_do_request+2ce/32c>
Trace; c019b19e <ide_timer_expiry+22a/244>
Trace; c019af74 <ide_timer_expiry+0/244>
Trace; c011123b <smp_local_timer_interrupt+d3/148>
Trace; c0115775 <timer_bh+2d1/404>
Trace; c0111994 <do_edge_ioapic_IRQ+78/a8>
Trace; c0111946 <do_edge_ioapic_IRQ+2a/a8>
Trace; c011c99d <do_bottom_half+89/ac>
Trace; c0106000 <get_options+0/7c>
Trace; c010ca89 <do_IRQ+3d/58>
Trace; c010caa0 <do_IRQ+54/58>
Trace; c010b4f8 <common_interrupt+18/20>
Trace; c0106000 <get_options+0/7c>
Trace; c0108a11 <cpu_idle+41/54>
Trace; c0106000 <get_options+0/7c>
Trace; c010607c <init+0/144>
Trace; c0106000 <get_options+0/7c>
Trace; c01001ae <L6+0/2>
Code;  d8ab07a1 <END_OF_CODE+f17e/????>
00000000 <_EIP>:
Code;  d8ab07a1 <END_OF_CODE+f17e/????>   <=====
   0:   8b 50 14                  mov    0x14(%eax),%edx   <=====
Code;  d8ab07a4 <END_OF_CODE+f181/????>
   3:   8b 70 10                  mov    0x10(%eax),%esi
Code;  d8ab07a7 <END_OF_CODE+f184/????>
   6:   8d 44 24 34               lea    0x34(%esp,1),%eax
Code;  d8ab07ab <END_OF_CODE+f188/????>
   a:   89 44 24 18               mov    %eax,0x18(%esp,1)
Code;  d8ab07af <END_OF_CODE+f18c/????>
   e:   c1 ee 02                  shr    $0x2,%esi
Code;  d8ab07b2 <END_OF_CODE+f18f/????>
  11:   31 c0                     xor    %eax,%eax
Code;  d8ab07b4 <END_OF_CODE+f191/????>
  13:   8b 00                     mov    (%eax),%eax

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing   

2 warnings issued.  Results may not be reliable.

----Next_Part(Wed_Nov__1_01:08:05_2000_559)----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
