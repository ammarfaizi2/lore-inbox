Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVAGSZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVAGSZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVAGSXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:23:02 -0500
Received: from pD9F87953.dip0.t-ipconnect.de ([217.248.121.83]:52097 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261523AbVAGSOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:14:49 -0500
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: 2.4.x oops with X
Date: Fri, 07 Jan 2005 19:13:50 +0100
Organization: privat
Message-ID: <41DED15E.1070706@pD9F87953.dip0.t-ipconnect.de>
References: <fa.m16skii.8mkd12@ifi.uio.no> <fa.f3n91fn.b42ahv@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.4) Gecko/20041217
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.f3n91fn.b42ahv@ifi.uio.no>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

Marcelo Tosatti schrieb:
> On Fri, Jan 07, 2005 at 10:03:11AM +0100, Andreas Hartmann wrote:
>> Hello!
>> 
>> 
>> I installed glibc 2.3.4 with the options
>> 
>> --enable-kernel=2.4.1 --enable-add-ons=linuxthreads --prefix=/usr
>> --disable-static
>> 
>> and installed it. Afterwards, I'm getting oopses with kernel 2.4.x (kernel
>> 2.6.10 works fine). X itself segfaults.
>> 
>> ksymoops 2.4.1 on i686 2.4.29-pre3.  Options used
>>      -V (default)
>>      -k /proc/ksyms (default)
>>      -l /proc/modules (default)
>>      -o /lib/modules/2.4.29-pre3/ (default)
>>      -m /usr/src/linux/System.map (default)
>> 
>> Warning: You did not tell me where to find symbol information.  I will
>> assume that the log matches the kernel and modules that are running
>> right now and I'll use the default options above for symbol resolution.
>> If the current kernel and/or modules do not match the log, you can get
>> more accurate output by telling me the kernel version and where to find
>> map, modules, ksyms etc.  ksymoops -h explains the options.
>> 
>> Warning (compare_maps): ksyms_base symbol
>> do_suspend2_lowlevel_R__ver_do_suspend2_lowlevel not found in System.map.
>>  Ignoring ksyms_base entry
>> Warning (compare_maps): ksyms_base symbol
>> highstart_pfn_R__ver_highstart_pfn not found in System.map.  Ignoring
>> ksyms_base entry
>> Warning (compare_maps): mismatch on symbol loadtime  , lvm-mod says
>> e0905660, /lib/modules/2.4.29-pre3/kernel/drivers/md/lvm-mod.o says
>> e09055a0.  Ignoring /lib/modules/2.4.29-pre3/kernel/drivers/md/lvm-mod.o entry
>> Warning (compare_maps): mismatch on symbol vg  , lvm-mod says e0905680,
>> /lib/modules/2.4.29-pre3/kernel/drivers/md/lvm-mod.o says e09055c0.
>> Ignoring /lib/modules/2.4.29-pre3/kernel/drivers/md/lvm-mod.o entry
>> Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says
>> e08bb5a0, /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o says e08bb340.
>> Ignoring /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o entry
>> Warning (compare_maps): mismatch on symbol unix_table_lock  , unix says
>> e08bb580, /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o says e08bb320.
>> Ignoring /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o entry
>> Warning (compare_maps): mismatch on symbol unix_tot_inflight  , unix says
>> e08bb9a8, /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o says e08bb748.
>> Ignoring /lib/modules/2.4.29-pre3/kernel/net/unix/unix.o entry
>> Jan  6 15:30:03 athlon kernel: kernel BUG at memory.c:535!
>> Jan  6 15:30:03 athlon kernel: invalid operand: 0000
>> Jan  6 15:30:03 athlon kernel: CPU:    0
>> Jan  6 15:30:03 athlon kernel: EIP:    0010:[<c0137e93>]    Not tainted
>> Using defaults from ksymoops -t elf32-i386 -a i386
>> Jan  6 15:30:03 athlon kernel: EFLAGS: 00010282
>> Jan  6 15:30:03 athlon kernel: eax: 00000045   ebx: 000a0000   ecx:
>> d2226000   edx: db897f7c
>> Jan  6 15:30:03 athlon kernel: esi: ffffffff   edi: c54106c0   ebp:
>> 00000001   esp: d2227c04
>> Jan  6 15:30:03 athlon kernel: ds: 0018   es: 0018   ss: 0018
>> Jan  6 15:30:03 athlon kernel: Process X (pid: 21100, stackpage=d2227000)
>> Jan  6 15:30:03 athlon kernel: Stack: c0246860 c54106c0 000800ff 00000000
>> 00002cb0 00000010 00000000 c54106c0
>> Jan  6 15:30:03 athlon kernel:        000a0000 000a03d4 d2226000 c0166b9c
>> d2226000 db673b40 000a0000 00000001
>> Jan  6 15:30:04 athlon kernel:        00000000 00000001 d2227c6c d2227c70
>> 00002cb0 00000003 01388000 0070c000
>> Jan  6 15:30:04 athlon kernel: Call Trace: [<c0166b9c>]  [<c019023d>]
>> [<c018f587>]  [<c0148612>]  [<c0152d90>]  [<c0116546>]  [<c0106e84>]
>> [<c01223a1>]  [<c0107ef0>]  [<c012281f>]  [<c0107ef0>]  [<c010705c>]
>> Jan  6 15:30:04 athlon kernel: Code: 0f 0b 17 02 97 65 24 c0 be f2 ff ff
>> ff eb b2 ff 41 14 eb 86
>> 
>> >>EIP; c0137e93 <get_user_pages+163/200>   <=====
>> Trace; c0166b9c <elf_core_dump+7ec/975>
>> Trace; c019023d <do_journal_end+bd/b60>
>> Trace; c018f587 <journal_end+27/30>
>> Trace; c0148612 <do_truncate+72/a0>
>> Trace; c0152d90 <do_coredump+170/177>
>> Trace; c0116546 <schedule+236/3e0>
>> Trace; c0106e84 <do_signal+214/2c0>
>> Trace; c01223a1 <deliver_signal+31/70>
>> Trace; c0107ef0 <do_general_protection+0/a0>
>> Trace; c012281f <force_sig+1f/30>
>> Trace; c0107ef0 <do_general_protection+0/a0>
>> Trace; c010705c <signal_return+14/18>
>> Code;  c0137e93 <get_user_pages+163/200>
>> 00000000 <_EIP>:
>> Code;  c0137e93 <get_user_pages+163/200>   <=====
>>    0:   0f 0b                     ud2a      <=====
>> Code;  c0137e95 <get_user_pages+165/200>
>>    2:   17                        pop    %ss
>> Code;  c0137e96 <get_user_pages+166/200>
>>    3:   02 97 65 24 c0 be         add    0xbec02465(%edi),%dl
>> Code;  c0137e9c <get_user_pages+16c/200>
>>    9:   f2 ff                     repnz (bad)
>> Code;  c0137e9e <get_user_pages+16e/200>
>>    b:   ff                        (bad)
>> Code;  c0137e9f <get_user_pages+16f/200>
>>    c:   ff eb                     ljmp   *<internal disassembler error>
>> Code;  c0137ea1 <get_user_pages+171/200>
>>    e:   b2 ff                     mov    $0xff,%dl
>> Code;  c0137ea3 <get_user_pages+173/200>
>>   10:   41                        inc    %ecx
>> Code;  c0137ea4 <get_user_pages+174/200>
>>   11:   14 eb                     adc    $0xeb,%al
>> Code;  c0137ea6 <get_user_pages+176/200>
>>   13:   86 00                     xchg   %al,(%eax)
> 
> We added a BUG() call in get_user_pages() to catch VM_IO flagged vma's 
> (virtual memory areas) with PageReserved pages.
> 
> Can you disable AGP and run X ? 

Well, what do you mean with "disable AGP"? I can't disable it in the BIOS.
I disabled DRI in the XF86Config-file. agpgart and r128 haven't been
loaded (they are built as modules). The behaviour of the X-starting
doesn't change and it's always the same:

X Window System Version 6.8.1
Release Date: 17 September 2004
X Protocol Version 11, Revision 0, Release 6.8.1
Build Operating System: Linux 2.4.29-pre3 i686 [ELF]
Current Operating System: Linux athlon 2.4.29-pre3 #5 Do Jan 6 17:42:51
CET 2005 i686
Build Date: 06 January 2005
        Before reporting problems, check http://wiki.X.Org
        to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Fri Jan  7 18:43:10 2005
(==) Using config file: "/etc/X11/XF86Config"
(==) ServerLayout "XFree86 Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Card0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) Option "AutoRepeat" "50 50"
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "de"
(**) XKB: layout: "de"
(**) Option "XkbVariant" "nodeadkeys"
(**) XKB: variant: "nodeadkeys"
(==) Keyboard: CustomKeycode disabled
(WW) The directory "/usr/X11R6/lib/X11/fonts/Speedo" does not exist.
        Entry deleted from font path.
(**) FontPath set to
"/usr/X11R6/lib/X11/fonts/misc,/usr/X11R6/lib/X11/fonts/Type1,/usr/local/OpenOffice.org1.1.2/share/fonts/truetype,/opt/kde-3.3/share/fonts,/usr/X11R6/lib/X11/fonts/TrueType,/usr/X11R6/lib/X11/fonts/Vera,/usr/X11R6/lib/X11/fonts/TrueType2,/usr/X11R6/lib/X11/fonts/TTF,/usr/X11R6/lib/X11/fonts/java2,/usr/X11R6/lib/X11/fonts/75dpi,/usr/X11R6/lib/X11/fonts/100dpi,/usr/X11R6/lib/X11/fonts/cyrillic"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(**) ModulePath set to "/usr/X11R6/lib/modules"
(WW) Open APM failed (/dev/apm_bios) (No such device)
(II) Module ABI versions:
        X.Org ANSI C Emulation: 0.2
        X.Org Video Driver: 0.7
        X.Org XInput driver : 0.4
        X.Org Server Extension : 0.2
        X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org Font Renderer
        ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Video Driver, version 0.7
(--) using VT number 7

(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x80006004, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 1106,3099 card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 1106,b099 card 0000,0000 rev 00 class 06,04,00 hdr 01
(II) PCI: 00:09:0: chip 1039,0900 card 1039,0900 rev 02 class 02,00,00 hdr 00
(II) PCI: 00:0c:0: chip 8086,1229 card 8086,0040 rev 0c class 02,00,00 hdr 00
(II) PCI: 00:10:0: chip 1106,3038 card 1106,3038 rev 80 class 0c,03,00 hdr 80
(II) PCI: 00:10:1: chip 1106,3038 card 1106,3038 rev 80 class 0c,03,00 hdr 80
(II) PCI: 00:10:2: chip 1106,3038 card 1106,3038 rev 80 class 0c,03,00 hdr 80
(II) PCI: 00:10:3: chip 1106,3104 card 1106,3104 rev 82 class 0c,03,20 hdr 00
(II) PCI: 00:11:0: chip 1106,3177 card 1106,3177 rev 00 class 06,01,00 hdr 80
(II) PCI: 00:11:1: chip 1106,0571 card 1106,0571 rev 06 class 01,01,8a hdr 00
(II) PCI: 00:11:5: chip 1106,3059 card 1695,3005 rev 50 class 04,01,00 hdr 00
(II) PCI: 01:00:0: chip 1002,5046 card 1002,0008 rev 00 class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,1), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
        [0] -1  0       0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
        [0] -1  0       0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
        [0] -1  0       0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000c (VGA_EN is set)
(II) Bus 1 I/O range:
        [0] -1  0       0x0000c000 - 0x0000c0ff (0x100) IX[B]
        [1] -1  0       0x0000c400 - 0x0000c4ff (0x100) IX[B]
        [2] -1  0       0x0000c800 - 0x0000c8ff (0x100) IX[B]
        [3] -1  0       0x0000cc00 - 0x0000ccff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
        [0] -1  0       0xdc000000 - 0xddffffff (0x2000000) MX[B]
(II) Bus 1 prefetchable memory range:
        [0] -1  0       0xd8000000 - 0xdbffffff (0x4000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:17:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(--) PCI:*(1:0:0) ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS rev 0,
Mem @ 0xd8000000/26, 0xdd000000/14, I/O @ 0xc000/8
(II) Addressable bus resource ranges are
        [0] -1  0       0x00000000 - 0xffffffff (0x0) MX[B]
        [1] -1  0       0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
        [0] -1  0       0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1  0       0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
        [2] -1  0       0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1  0       0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1  0       0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1  0       0x0000ffff - 0x0000ffff (0x1) IX[B]
        [6] -1  0       0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xd0000000 from 0xd7ffffff to
0xcfffffff
(II) Active PCI resource ranges:
        [0] -1  0       0xdf022000 - 0xdf0220ff (0x100) MX[B]
        [1] -1  0       0xdf000000 - 0xdf01ffff (0x20000) MX[B]
        [2] -1  0       0xdf020000 - 0xdf020fff (0x1000) MX[B]
        [3] -1  0       0xdf021000 - 0xdf021fff (0x1000) MX[B]
        [4] -1  0       0xd0000000 - 0xcfffffff (0x0) MX[B]O
        [5] -1  0       0xdd000000 - 0xdd003fff (0x4000) MX[B](B)
        [6] -1  0       0xd8000000 - 0xdbffffff (0x4000000) MX[B](B)
        [7] -1  0       0x0000e800 - 0x0000e8ff (0x100) IX[B]
        [8] -1  0       0x0000e400 - 0x0000e40f (0x10) IX[B]
        [9] -1  0       0x0000e000 - 0x0000e01f (0x20) IX[B]
        [10] -1 0       0x0000dc00 - 0x0000dc1f (0x20) IX[B]
        [11] -1 0       0x0000d800 - 0x0000d81f (0x20) IX[B]
        [12] -1 0       0x0000d400 - 0x0000d43f (0x40) IX[B]
        [13] -1 0       0x0000d000 - 0x0000d0ff (0x100) IX[B]
        [14] -1 0       0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
        [0] -1  0       0xdf022000 - 0xdf0220ff (0x100) MX[B]
        [1] -1  0       0xdf000000 - 0xdf01ffff (0x20000) MX[B]
        [2] -1  0       0xdf020000 - 0xdf020fff (0x1000) MX[B]
        [3] -1  0       0xdf021000 - 0xdf021fff (0x1000) MX[B]
        [4] -1  0       0xd0000000 - 0xcfffffff (0x0) MX[B]O
        [5] -1  0       0xdd000000 - 0xdd003fff (0x4000) MX[B](B)
        [6] -1  0       0xd8000000 - 0xdbffffff (0x4000000) MX[B](B)
        [7] -1  0       0x0000e800 - 0x0000e8ff (0x100) IX[B]
        [8] -1  0       0x0000e400 - 0x0000e40f (0x10) IX[B]
        [9] -1  0       0x0000e000 - 0x0000e01f (0x20) IX[B]
        [10] -1 0       0x0000dc00 - 0x0000dc1f (0x20) IX[B]
        [11] -1 0       0x0000d800 - 0x0000d81f (0x20) IX[B]
        [12] -1 0       0x0000d400 - 0x0000d43f (0x40) IX[B]
        [13] -1 0       0x0000d000 - 0x0000d0ff (0x100) IX[B]
        [14] -1 0       0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
        [0] -1  0       0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1  0       0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
        [2] -1  0       0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1  0       0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1  0       0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1  0       0x0000ffff - 0x0000ffff (0x1) IX[B]
        [6] -1  0       0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
        [0] -1  0       0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1  0       0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
        [2] -1  0       0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1  0       0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1  0       0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1  0       0xdf022000 - 0xdf0220ff (0x100) MX[B]
        [6] -1  0       0xdf000000 - 0xdf01ffff (0x20000) MX[B]
        [7] -1  0       0xdf020000 - 0xdf020fff (0x1000) MX[B]
        [8] -1  0       0xdf021000 - 0xdf021fff (0x1000) MX[B]
        [9] -1  0       0xd0000000 - 0xcfffffff (0x0) MX[B]O
        [10] -1 0       0xdd000000 - 0xdd003fff (0x4000) MX[B](B)
        [11] -1 0       0xd8000000 - 0xdbffffff (0x4000000) MX[B](B)
        [12] -1 0       0x0000ffff - 0x0000ffff (0x1) IX[B]
        [13] -1 0       0x00000000 - 0x000000ff (0x100) IX[B]
        [14] -1 0       0x0000e800 - 0x0000e8ff (0x100) IX[B]
        [15] -1 0       0x0000e400 - 0x0000e40f (0x10) IX[B]
        [16] -1 0       0x0000e000 - 0x0000e01f (0x20) IX[B]
        [17] -1 0       0x0000dc00 - 0x0000dc1f (0x20) IX[B]
        [18] -1 0       0x0000d800 - 0x0000d81f (0x20) IX[B]
        [19] -1 0       0x0000d400 - 0x0000d43f (0x40) IX[B]
        [20] -1 0       0x0000d000 - 0x0000d0ff (0x100) IX[B]
        [21] -1 0       0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.13.0
        Module class: X.Org Server Extension
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org Server Extension
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org Server Extension
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "xtrap"
(II) Loading /usr/X11R6/lib/modules/extensions/libxtrap.a
(II) Module xtrap: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org Server Extension
        ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DEC-XTRAP
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.2
        Module class: X.Org Font Renderer
        ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.so
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
        compiled for 6.8.1, module version = 2.1.0
        Module class: X.Org Font Renderer
        ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 6.5.6
        Module class: X.Org Video Driver
        ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org XInput Driver
        ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "keyboard"
(II) Loading /usr/X11R6/lib/modules/input/keyboard_drv.o
(II) Module keyboard: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        Module class: X.Org XInput Driver
        ABI class: X.Org XInput driver, version 0.4
(II) ATI: ATI driver (version 6.5.6) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets:
        ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
        ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
        ATI Rage 128 Pro GL PA (PCI/AGP), ATI Rage 128 Pro GL PB (PCI/AGP),
        ATI Rage 128 Pro GL PC (PCI/AGP), ATI Rage 128 Pro GL PD (PCI),
        ATI Rage 128 Pro GL PE (PCI/AGP), ATI Rage 128 Pro GL PF (AGP),
        ATI Rage 128 Pro VR PG (PCI/AGP), ATI Rage 128 Pro VR PH (PCI/AGP),
        ATI Rage 128 Pro VR PI (PCI/AGP), ATI Rage 128 Pro VR PJ (PCI/AGP),
        ATI Rage 128 Pro VR PK (PCI/AGP), ATI Rage 128 Pro VR PL (PCI/AGP),
        ATI Rage 128 Pro VR PM (PCI/AGP), ATI Rage 128 Pro VR PN (PCI/AGP),
        ATI Rage 128 Pro VR PO (PCI/AGP), ATI Rage 128 Pro VR PP (PCI),
        ATI Rage 128 Pro VR PQ (PCI/AGP), ATI Rage 128 Pro VR PR (PCI),
        ATI Rage 128 Pro VR PS (PCI/AGP), ATI Rage 128 Pro VR PT (PCI/AGP),
        ATI Rage 128 Pro VR PU (PCI/AGP), ATI Rage 128 Pro VR PV (PCI/AGP),
        ATI Rage 128 Pro VR PW (PCI/AGP), ATI Rage 128 Pro VR PX (PCI/AGP),
        ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
        ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
        ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (PCI/AGP),
        ATI Rage 128 4X SF (PCI/AGP), ATI Rage 128 4X SG (PCI/AGP),
        ATI Rage 128 4X SH (PCI/AGP), ATI Rage 128 4X SK (PCI/AGP),
        ATI Rage 128 4X SL (PCI/AGP), ATI Rage 128 4X SM (AGP),
        ATI Rage 128 4X SN (PCI/AGP), ATI Rage 128 Pro ULTRA TF (AGP),
        ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
        ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
        ATI Rage 128 Pro ULTRA TU (AGP?)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
        ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
        ATI Radeon VE/7000 QY (AGP/PCI), ATI Radeon VE/7000 QZ (AGP/PCI),
        ATI Radeon Mobility M7 LW (AGP),
        ATI Mobility FireGL 7800 M7 LX (AGP),
        ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
        ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
        ATI Radeon IGP330/340/350 (A4) 4137,
        ATI Radeon IGP330M/340M/350M (U2) 4337,
        ATI Radeon 7000 IGP (A4+) 4237, ATI Radeon Mobility 7000 IGP 4437,
        ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QL (AGP),
        ATI Radeon 9100 QM (AGP), ATI Radeon 8500 AIW BB (AGP),
        ATI Radeon 8500 AIW BC (AGP), ATI Radeon 7500 QW (AGP/PCI),
        ATI Radeon 7500 QX (AGP/PCI), ATI Radeon 9000/PRO If (AGP/PCI),
        ATI Radeon 9000 Ig (AGP/PCI), ATI FireGL Mobility 9000 (M9) Ld (AGP),
        ATI Radeon Mobility 9000 (M9) Lf (AGP),
        ATI Radeon Mobility 9000 (M9) Lg (AGP),
        ATI Radeon 9100 IGP (A5) 5834,
        ATI Radeon Mobility 9100 IGP (U3) 5835, ATI Radeon 9100 PRO IGP 7834,
        ATI Radeon Mobility 9200 IGP 7835, ATI Radeon 9200PRO 5960 (AGP),
        ATI Radeon 9200 5961 (AGP), ATI Radeon 9200 5962 (AGP),
        ATI Radeon 9200SE 5964 (AGP),
        ATI Radeon Mobility 9200 (M9+) 5C61 (AGP),
        ATI Radeon Mobility 9200 (M9+) 5C63 (AGP), ATI Radeon 9500 AD (AGP),
        ATI Radeon 9500 AE (AGP), ATI Radeon 9600TX AF (AGP),
        ATI FireGL Z1 AG (AGP), ATI Radeon 9700 Pro ND (AGP),
        ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9700 NF (AGP),
        ATI FireGL X1 NG (AGP), ATI Radeon 9600 AP (AGP),
        ATI Radeon 9600SE AQ (AGP), ATI Radeon 9600XT AR (AGP),
        ATI Radeon 9600 AS (AGP), ATI FireGL T2 AT (AGP),
        ATI FireGL RV360 AV (AGP),
        ATI Radeon Mobility 9600/9700 (M10/M11) NP (AGP),
        ATI Radeon Mobility 9600 (M10) NQ (AGP),
        ATI Radeon Mobility 9600 (M11) NR (AGP),
        ATI Radeon Mobility 9600 (M10) NS (AGP),
        ATI FireGL Mobility T2 (M10) NT (AGP),
        ATI FireGL Mobility T2e (M11) NV (AGP), ATI Radeon 9800SE AH (AGP),
        ATI Radeon 9800 AI (AGP), ATI Radeon 9800 AJ (AGP),
        ATI FireGL X2 AK (AGP), ATI Radeon 9800PRO NH (AGP),
        ATI Radeon 9800 NI (AGP), ATI FireGL X2 NK (AGP),
        ATI Radeon 9800XT NJ (AGP), ATI Radeon X600 (RV380) 3E50 (PCIE),
        ATI FireGL V3200 (RV380) 3E54 (PCIE),
        ATI Radeon Mobility X600 (M24) 3150 (PCIE),
        ATI FireGL M24 GL 3154 (PCIE), ATI Radeon X300 (RV370) 5B60 (PCIE),
        ATI Radeon X600 (RV370) 5B62 (PCIE),
        ATI FireGL V3100 (RV370) 5B64 (PCIE),
        ATI FireGL D1100 (RV370) 5B65 (PCIE),
        ATI Radeon Mobility M300 (M22) 5460 (PCIE),
        ATI FireGL M22 GL 5464 (PCIE), ATI Radeon X800 (R420) JH (AGP),
        ATI Radeon X800PRO (R420) JI (AGP),
        ATI Radeon X800SE (R420) JJ (AGP), ATI Radeon X800 (R420) JK (AGP),
        ATI Radeon X800 (R420) JL (AGP), ATI FireGL X3 (R420) JM (AGP),
        ATI Radeon Mobility 9800 (M18) JN (AGP),
        ATI Radeon X800XT (R420) JP (AGP), ATI Radeon X800 (R423) UH (PCIE),
        ATI Radeon X800PRO (R423) UI (PCIE),
        ATI Radeon X800LE (R423) UJ (PCIE),
        ATI Radeon X800SE (R423) UK (PCIE),
        ATI FireGL V7200 (R423) UQ (PCIE), ATI FireGL V5100 (R423) UR (PCIE),
        ATI FireGL V7100 (R423) UT (PCIE),
        ATI Radeon X800XT (R423) 5D57 (PCIE)
(II) Primary Device is: PCI 01:00:0
(II) ATI:  Candidate "Device" section "Card0".
(**) ChipID override: 0x5046
(**) Chipset ATI Rage 128 Pro GL PF (AGP) found
(II) Loading sub module "r128"
(II) LoadModule: "r128"
(II) Loading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) Module r128: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 4.0.1
        Module class: X.Org Video Driver
        ABI class: X.Org Video Driver, version 0.7
(II) resource ranges after xf86ClaimFixedResources() call:
        [0] -1  0       0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1  0       0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
        [2] -1  0       0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1  0       0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1  0       0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1  0       0xdf022000 - 0xdf0220ff (0x100) MX[B]
        [6] -1  0       0xdf000000 - 0xdf01ffff (0x20000) MX[B]
        [7] -1  0       0xdf020000 - 0xdf020fff (0x1000) MX[B]
        [8] -1  0       0xdf021000 - 0xdf021fff (0x1000) MX[B]
        [9] -1  0       0xd0000000 - 0xcfffffff (0x0) MX[B]O
        [10] -1 0       0xdd000000 - 0xdd003fff (0x4000) MX[B](B)
        [11] -1 0       0xd8000000 - 0xdbffffff (0x4000000) MX[B](B)
        [12] -1 0       0x0000ffff - 0x0000ffff (0x1) IX[B]
        [13] -1 0       0x00000000 - 0x000000ff (0x100) IX[B]
        [14] -1 0       0x0000e800 - 0x0000e8ff (0x100) IX[B]
        [15] -1 0       0x0000e400 - 0x0000e40f (0x10) IX[B]
        [16] -1 0       0x0000e000 - 0x0000e01f (0x20) IX[B]
        [17] -1 0       0x0000dc00 - 0x0000dc1f (0x20) IX[B]
        [18] -1 0       0x0000d800 - 0x0000d81f (0x20) IX[B]
        [19] -1 0       0x0000d400 - 0x0000d43f (0x40) IX[B]
        [20] -1 0       0x0000d000 - 0x0000d0ff (0x100) IX[B]
        [21] -1 0       0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) resource ranges after probing:
        [0] -1  0       0xffe00000 - 0xffffffff (0x200000) MX[B](B)
        [1] -1  0       0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
        [2] -1  0       0x000f0000 - 0x000fffff (0x10000) MX[B]
        [3] -1  0       0x000c0000 - 0x000effff (0x30000) MX[B]
        [4] -1  0       0x00000000 - 0x0009ffff (0xa0000) MX[B]
        [5] -1  0       0xdf022000 - 0xdf0220ff (0x100) MX[B]
        [6] -1  0       0xdf000000 - 0xdf01ffff (0x20000) MX[B]
        [7] -1  0       0xdf020000 - 0xdf020fff (0x1000) MX[B]
        [8] -1  0       0xdf021000 - 0xdf021fff (0x1000) MX[B]
        [9] -1  0       0xd0000000 - 0xcfffffff (0x0) MX[B]O
        [10] -1 0       0xdd000000 - 0xdd003fff (0x4000) MX[B](B)
        [11] -1 0       0xd8000000 - 0xdbffffff (0x4000000) MX[B](B)
        [12] 0  0       0x000a0000 - 0x000affff (0x10000) MS[B]
        [13] 0  0       0x000b0000 - 0x000b7fff (0x8000) MS[B]
        [14] 0  0       0x000b8000 - 0x000bffff (0x8000) MS[B]
        [15] -1 0       0x0000ffff - 0x0000ffff (0x1) IX[B]
        [16] -1 0       0x00000000 - 0x000000ff (0x100) IX[B]
        [17] -1 0       0x0000e800 - 0x0000e8ff (0x100) IX[B]
        [18] -1 0       0x0000e400 - 0x0000e40f (0x10) IX[B]
        [19] -1 0       0x0000e000 - 0x0000e01f (0x20) IX[B]
        [20] -1 0       0x0000dc00 - 0x0000dc1f (0x20) IX[B]
        [21] -1 0       0x0000d800 - 0x0000d81f (0x20) IX[B]
        [22] -1 0       0x0000d400 - 0x0000d43f (0x40) IX[B]
        [23] -1 0       0x0000d000 - 0x0000d0ff (0x100) IX[B]
        [24] -1 0       0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
        [25] 0  0       0x000003b0 - 0x000003bb (0xc) IS[B]
        [26] 0  0       0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 0.1.0
        ABI class: X.Org Video Driver, version 0.7
(II) R128(0): PCI bus 1 card 0 func 0
(**) R128(0): Depth 24, (--) framebuffer bpp 32
(II) R128(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) R128(0): Default visual is TrueColor
(==) R128(0): RGB weight 888
(II) R128(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Video Driver, version 0.7
(II) R128(0): initializing int10
(II) R128(0): Primary V_BIOS segment is: 0xc000
(**) R128(0): Chipset: "ATI Rage 128 Pro GL PF (AGP)" (ChipID = 0x5046)
(--) R128(0): Linear framebuffer at 0xd8000000
(--) R128(0): MMIO registers at 0xdd000000
(II) R128(0): Video RAM override, using 32768 kB instead of 32768 kB
(**) R128(0): VideoRAM: 32768 kByte (64-bit SDR SGRAM 1:1)
(**) R128(0): Using external CRT for display
(WW) R128(0): Can't determine panel dimensions, and none specified.
                    Disabling programming of FP registers.
(II) R128(0): PLL parameters: rf=2950 rd=65 min=12500 max=40000; xclk=12000
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.0.0
        ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="X.Org Foundation"
        compiled for 6.8.1, module version = 1.1.0
        ABI class: X.Org Video Driver, version 0.7


The last lines of strace are:

1149  open("/usr/X11R6/lib/modules/libvbe.a", O_RDONLY) = 6
1149  read(6, "!<arch>\n/               11049778"..., 256) = 256
1149  lseek(6, 0, SEEK_SET)             = 0
1149  read(6, "!<arch>\n", 8)           = 8
1149  read(6, "/               1104977839  0   "..., 60) = 60
1149  lseek(6, 0, SEEK_CUR)             = 68
1149  lseek(6, 658, SEEK_SET)           = 658
1149  read(6, "vbe.o/          1104977839  0   "..., 60) = 60
1149  lseek(6, 0, SEEK_CUR)             = 718
1149  read(6,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 256) = 256
1149  lseek(6, 718, SEEK_SET)           = 718
1149  lseek(6, 718, SEEK_SET)           = 718
1149  read(6,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 52) = 52
1149  lseek(6, 7834, SEEK_SET)          = 7834
1149  read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
520) = 520
1149  lseek(6, 7745, SEEK_SET)          = 7745
1149  read(6, "\0.symtab\0.strtab\0.shstrtab\0.rel."..., 89) = 89
1149  lseek(6, 10098, SEEK_SET)         = 10098
1149  read(6, "\23\0\0\0\2\16\0\0F\0\0\0\2\17\0\0`\0\0\0\1\5\0\0h\0\0"...,
1200) = 1200
1149  lseek(6, 11298, SEEK_SET)         = 11298
1149  read(6, "\0\0\0\0\1\5\0\0", 8)    = 8
1149  lseek(6, 11306, SEEK_SET)         = 11306
1149  read(6, "D\2\0\0\1\5\0\0`\2\0\0\1\5\0\0", 16) = 16
1149  lseek(6, 8354, SEEK_SET)          = 8354
1149  read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0"...,
960) = 960
1149  lseek(6, 9314, SEEK_SET)          = 9314
1149  read(6, "\0vbe.c\0vbeVersionString\0VBEOptio"..., 783) = 783
1149  lseek(6, 782, SEEK_SET)           = 782
1149  read(6, "U\211\345WVS\203\354,\213u\f\213]\10\2114$\350\374\377"...,
5760) = 5760
1149  mprotect(0x84c0000, 6000, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  lseek(6, 6542, SEEK_SET)          = 6542
1149  read(6, "\0\0\0\0\0\0\0\0", 8)    = 8
1149  mprotect(0x8352000, 2024, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  lseek(6, 6574, SEEK_SET)          = 6574
1149  read(6, "xf86InterpretEDID\0VBE2\0Invalid\n\0"..., 1153) = 1153
1149  mprotect(0x86d9000, 3377, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  lseek(6, 11322, SEEK_SET)         = 11322
1149  read(6, "vbeModes.o/     1104977839  0   "..., 60) = 60
1149  lseek(6, 0, SEEK_CUR)             = 11382
1149  read(6,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 256) = 256
1149  lseek(6, 11382, SEEK_SET)         = 11382
1149  lseek(6, 11382, SEEK_SET)         = 11382
1149  read(6,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 52) = 52
1149  lseek(6, 16102, SEEK_SET)         = 16102
1149  read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
480) = 480
1149  lseek(6, 16014, SEEK_SET)         = 16014
1149  read(6, "\0.symtab\0.strtab\0.shstrtab\0.rel."..., 85) = 85
1149  lseek(6, 17410, SEEK_SET)         = 17410
1149  read(6,
"\374\1\0\0\2\f\0\0\32\2\0\0\1\6\0\0)\2\0\0\2\r\0\0;\2\0"..., 960) = 960
1149  lseek(6, 18370, SEEK_SET)         = 18370
1149  read(6, "x\0\0\0\1\2\0\0|\0\0\0\1\2\0\0\200\0\0\0\1\2\0\0\204\0"...,
200) = 200
1149  lseek(6, 16582, SEEK_SET)         = 16582
1149  read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0"...,
480) = 480
1149  lseek(6, 17062, SEEK_SET)         = 17062
1149  read(6, "\0vbeModes.c\0GetDepthFlag\0CheckMo"..., 345) = 345
1149  lseek(6, 11446, SEEK_SET)         = 11446
1149  read(6,
"U\211\345WV1\366S1\333\203\354\f\366E\24\1\213}\10t1\213"..., 3333) = 3333
1149  mprotect(0x84c1000, 5245, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  mprotect(0, 0, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  lseek(6, 14806, SEEK_SET)         = 14806
1149  read(6, "Not using mode \"%dx%d\" (%s)\n\0\0\0\0"..., 1190) = 1190
1149  mprotect(0x8474000, 4686, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  lseek(6, 18570, SEEK_SET)         = 18570
1149  read(6, "vbe_module.o/   1104977839  0   "..., 60) = 60
1149  lseek(6, 0, SEEK_CUR)             = 18630
1149  read(6,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 256) = 256
1149  lseek(6, 18630, SEEK_SET)         = 18630
1149  lseek(6, 18630, SEEK_SET)         = 18630
1149  read(6,
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 52) = 52
1149  lseek(6, 18966, SEEK_SET)         = 18966
1149  read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
480) = 480
1149  lseek(6, 18880, SEEK_SET)         = 18880
1149  read(6, "\0.symtab\0.strtab\0.shstrtab\0.rel."..., 85) = 85
1149  lseek(6, 19766, SEEK_SET)         = 19766
1149  read(6, "\10\0\0\0\1\4\0\0\31\0\0\0\1\4\0\0,\0\0\0\1\f\0\0001\0"...,
32) = 32
1149  lseek(6, 19798, SEEK_SET)         = 19798
1149  read(6, "\0\0\0\0\1\5\0\0\4\0\0\0\1\5\0\0\30\0\0\0\1\5\0\0004\0"...,
40) = 40
1149  lseek(6, 19446, SEEK_SET)         = 19446
1149  read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\0\0\0\0\0"...,
224) = 224
1149  lseek(6, 19670, SEEK_SET)         = 19670
1149  read(6, "\0vbe_module.c\0vbeVersRec\0vbeSetu"..., 93) = 93
1149  lseek(6, 18694, SEEK_SET)         = 18694
1149  read(6, "U\211\345\203\354\10\213\25\0\0\0\0\205\322t\7\270\1\0"...,
55) = 55
1149  mprotect(0x84c2000, 1991, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  lseek(6, 18758, SEEK_SET)         = 18758
1149  read(6,
"\0\0\0\0\4\0\0\0\305\375#\357:\2\334\20\350\277\237\3\1"..., 64) = 64
1149  mprotect(0x86da000, 928, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  lseek(6, 18822, SEEK_SET)         = 18822
1149  read(6, "vbe\0X.Org Foundation\0X.Org Video"..., 40) = 40
1149  mprotect(0x84c2000, 1880, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
1149  lseek(6, 19838, SEEK_SET)         = 19838
1149  read(6, "", 60)                   = 0
1149  close(6)                          = 0
1149  write(0, "(II) Module vbe: vendor=\"X.Org F"..., 43) = 43
1149  write(0, "\tcompiled for 6.8.1", 19) = 19
1149  write(0, ", module version = 1.1.0\n", 25) = 25
1149  write(0, "\tABI class: X.Org Video Driver, "..., 44) = 44
1149  rt_sigprocmask(SIG_BLOCK, [IO], [], 8) = 0
1149  vm86old(0x85b1820)                = -1 ENOSYS (Function not implemented)
1149  vm86old(0x85b1820)                = -1 ENOSYS (Function not implemented)
1149  --- SIGSEGV (Segmentation fault) @ 0 (0) ---
1149  rt_sigaction(SIGSEGV, {SIG_IGN}, {0x8087ec0, [SEGV],
SA_RESTORER|SA_RESTART, 0x4009d7f8}, 8) = 0
1149  --- SIGSEGV (Segmentation fault) @ 0 (0) ---
1149  +++ killed by SIGSEGV +++



Kind regards,
Andreas Hartmann
