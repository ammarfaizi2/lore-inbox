Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVAGOTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVAGOTk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVAGOTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:19:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261314AbVAGOSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:18:38 -0500
Date: Fri, 7 Jan 2005 09:30:06 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x oops with X
Message-ID: <20050107113006.GE29176@logos.cnet>
References: <crlj8e$1sj$1@pD9F86DA9.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <crlj8e$1sj$1@pD9F86DA9.dip0.t-ipconnect.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 10:03:11AM +0100, Andreas Hartmann wrote:
> Hello!
> 
> 
> I installed glibc 2.3.4 with the options
> 
> --enable-kernel=2.4.1 --enable-add-ons=linuxthreads --prefix=/usr
> --disable-static
> 
> and installed it. Afterwards, I'm getting oopses with kernel 2.4.x (kernel
> 2.6.10 works fine). X itself segfaults.
> 
> ksymoops 2.4.1 on i686 2.4.29-pre3.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.29-pre3/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Warning (compare_maps): ksyms_base symbol
> do_suspend2_lowlevel_R__ver_do_suspend2_lowlevel not found in System.map.
>  Ignoring ksyms_base entry
> Warning (compare_maps): ksyms_base symbol
> highstart_pfn_R__ver_highstart_pfn not found in System.map.  Ignoring
> ksyms_base entry
> Warning (compare_maps): mismatch on symbol loadtime  , lvm-mod says
> e0905660, /lib/modules/2.4.29-pre3/kernel/drivers/md/lvm-mod.o says
> e09055a0.  Ignoring /lib/modules/2.4.29-pre3/kernel/drivers/md/lvm-mod.o entry
> Warning (compare_maps): mismatch on symbol vg  , lvm-mod says e0905680,
> /lib/modules/2.4.29-pre3/kernel/drivers/md/lvm-mod.o says e09055c0.
> Ignoring /lib/modules/2.4.29-pre3/kernel/drivers/md/lvm-mod.o entry
> Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says
> e08bb5a0, /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o says e08bb340.
> Ignoring /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o entry
> Warning (compare_maps): mismatch on symbol unix_table_lock  , unix says
> e08bb580, /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o says e08bb320.
> Ignoring /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o entry
> Warning (compare_maps): mismatch on symbol unix_tot_inflight  , unix says
> e08bb9a8, /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o says e08bb748.
> Ignoring /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o entry
> Jan  6 15:30:03 athlon kernel: kernel BUG at memory.c:535!
> Jan  6 15:30:03 athlon kernel: invalid operand: 0000
> Jan  6 15:30:03 athlon kernel: CPU:    0
> Jan  6 15:30:03 athlon kernel: EIP:    0010:[<c0137e93>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Jan  6 15:30:03 athlon kernel: EFLAGS: 00010282
> Jan  6 15:30:03 athlon kernel: eax: 00000045   ebx: 000a0000   ecx:
> d2226000   edx: db897f7c
> Jan  6 15:30:03 athlon kernel: esi: ffffffff   edi: c54106c0   ebp:
> 00000001   esp: d2227c04
> Jan  6 15:30:03 athlon kernel: ds: 0018   es: 0018   ss: 0018
> Jan  6 15:30:03 athlon kernel: Process X (pid: 21100, stackpage=d2227000)
> Jan  6 15:30:03 athlon kernel: Stack: c0246860 c54106c0 000800ff 00000000
> 00002cb0 00000010 00000000 c54106c0
> Jan  6 15:30:03 athlon kernel:        000a0000 000a03d4 d2226000 c0166b9c
> d2226000 db673b40 000a0000 00000001
> Jan  6 15:30:04 athlon kernel:        00000000 00000001 d2227c6c d2227c70
> 00002cb0 00000003 01388000 0070c000
> Jan  6 15:30:04 athlon kernel: Call Trace: [<c0166b9c>]  [<c019023d>]
> [<c018f587>]  [<c0148612>]  [<c0152d90>]  [<c0116546>]  [<c0106e84>]
> [<c01223a1>]  [<c0107ef0>]  [<c012281f>]  [<c0107ef0>]  [<c010705c>]
> Jan  6 15:30:04 athlon kernel: Code: 0f 0b 17 02 97 65 24 c0 be f2 ff ff
> ff eb b2 ff 41 14 eb 86
> 
> >>EIP; c0137e93 <get_user_pages+163/200>   <=====
> Trace; c0166b9c <elf_core_dump+7ec/975>
> Trace; c019023d <do_journal_end+bd/b60>
> Trace; c018f587 <journal_end+27/30>
> Trace; c0148612 <do_truncate+72/a0>
> Trace; c0152d90 <do_coredump+170/177>
> Trace; c0116546 <schedule+236/3e0>
> Trace; c0106e84 <do_signal+214/2c0>
> Trace; c01223a1 <deliver_signal+31/70>
> Trace; c0107ef0 <do_general_protection+0/a0>
> Trace; c012281f <force_sig+1f/30>
> Trace; c0107ef0 <do_general_protection+0/a0>
> Trace; c010705c <signal_return+14/18>
> Code;  c0137e93 <get_user_pages+163/200>
> 00000000 <_EIP>:
> Code;  c0137e93 <get_user_pages+163/200>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0137e95 <get_user_pages+165/200>
>    2:   17                        pop    %ss
> Code;  c0137e96 <get_user_pages+166/200>
>    3:   02 97 65 24 c0 be         add    0xbec02465(%edi),%dl
> Code;  c0137e9c <get_user_pages+16c/200>
>    9:   f2 ff                     repnz (bad)
> Code;  c0137e9e <get_user_pages+16e/200>
>    b:   ff                        (bad)
> Code;  c0137e9f <get_user_pages+16f/200>
>    c:   ff eb                     ljmp   *<internal disassembler error>
> Code;  c0137ea1 <get_user_pages+171/200>
>    e:   b2 ff                     mov    $0xff,%dl
> Code;  c0137ea3 <get_user_pages+173/200>
>   10:   41                        inc    %ecx
> Code;  c0137ea4 <get_user_pages+174/200>
>   11:   14 eb                     adc    $0xeb,%al
> Code;  c0137ea6 <get_user_pages+176/200>
>   13:   86 00                     xchg   %al,(%eax)

We added a BUG() call in get_user_pages() to catch VM_IO flagged vma's 
(virtual memory areas) with PageReserved pages.

Can you disable AGP and run X ? 

Andrea, I guess I'll better revert the patch since it might break out-of-the tree
drivers.

