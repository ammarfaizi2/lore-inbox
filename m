Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277431AbRKSK0O>; Mon, 19 Nov 2001 05:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKSK0I>; Mon, 19 Nov 2001 05:26:08 -0500
Received: from [203.94.130.164] ([203.94.130.164]:37644 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S277431AbRKSKZt>;
	Mon, 19 Nov 2001 05:25:49 -0500
Date: Mon, 19 Nov 2001 21:54:48 +1100 (EST)
From: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: oops 2 of 2, [jbd]journal_try_to_free_buffers, 2.4.9-13
Message-ID: <Pine.LNX.4.40.0111192153470.14019-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And another one...

again, let me know if further info is needed.

thanks,

	/ Brett

ksymoops 2.4.1 on i686 2.4.9-13.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-13/ (default)
     -m /boot/System.map-2.4.9-13 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01b5c80, System.map says c0156ea0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol tone_control  , emu10k1 says d5b98ef4, /lib/modules/2.4.9-13/kernel/drivers/sound/emu10k1/emu10k1.o says d5b98120.  Ignoring /lib/modules/2.4.9-13/kernel/drivers/sound/emu10k1/emu10k1.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d086aa00, /lib/modules/2.4.9-13/kernel/drivers/usb/usbcore.o says d086a520.  Ignoring /lib/modules/2.4.9-13/kernel/drivers/usb/usbcore.o entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Unable to handle kernel paging request at virtual address 7a7e7fa7
d0801b92
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d0801b92>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a87
eax: 00000000   ebx: 7a7e7f7f   ecx: c1827f5c   edx: 7a7e7f7f
esi: cd9fa980   edi: 00000000   ebp: 00000000   esp: c1827f5c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1827000)
Stack: 00000001 c13cb5c8 00000080 00000000 00000007 d0810522 c17ca200 c13cb5c8 
       00000080 c01389ca c13cb5c8 00000080 00000000 c13cb5c8 c012ea44 c13cb5c8 
       00000080 00000000 00000000 00000060 000040d3 00000000 00000000 000000c0 
Call Trace: [<d0810522>] __insmod_ext3_S.text_L42880 [ext3] 0x44c2 
[<c01389ca>] try_to_release_page [kernel] 0x3a 
[<c012ea44>] page_launder [kernel] 0x3f4 
[<c012f2b1>] do_try_to_free_pages [kernel] 0x11 
[<c012f345>] kswapd [kernel] 0x55 
[<c0105000>] stext [kernel] 0x0 
[<c0105726>] kernel_thread [kernel] 0x26 
[<c012f2f0>] kswapd [kernel] 0x0 
Code: 8b 5b 28 f6 42 18 80 74 10 89 e0 50 52 e8 dc fe ff ff 5a 85 

>>EIP; d0801b92 <[jbd]journal_try_to_free_buffers+62/a0>   <=====
Trace; d0810522 <[ext3].text.start+44c2/a77f>
Trace; c01389ca <try_to_release_page+3a/60>
Trace; c012ea44 <page_launder+3f4/8e0>
Trace; c012f2b1 <do_try_to_free_pages+11/50>
Trace; c012f345 <kswapd+55/f0>
Trace; c0105000 <_stext+0/0>
Trace; c0105726 <kernel_thread+26/30>
Trace; c012f2f0 <kswapd+0/f0>
Code;  d0801b92 <[jbd]journal_try_to_free_buffers+62/a0>
00000000 <_EIP>:
Code;  d0801b92 <[jbd]journal_try_to_free_buffers+62/a0>   <=====
   0:   8b 5b 28                  mov    0x28(%ebx),%ebx   <=====
Code;  d0801b95 <[jbd]journal_try_to_free_buffers+65/a0>
   3:   f6 42 18 80               testb  $0x80,0x18(%edx)
Code;  d0801b99 <[jbd]journal_try_to_free_buffers+69/a0>
   7:   74 10                     je     19 <_EIP+0x19> d0801bab <[jbd]journal_try_to_free_buffers+7b/a0>
Code;  d0801b9b <[jbd]journal_try_to_free_buffers+6b/a0>
   9:   89 e0                     mov    %esp,%eax
Code;  d0801b9d <[jbd]journal_try_to_free_buffers+6d/a0>
   b:   50                        push   %eax
Code;  d0801b9e <[jbd]journal_try_to_free_buffers+6e/a0>
   c:   52                        push   %edx
Code;  d0801b9f <[jbd]journal_try_to_free_buffers+6f/a0>
   d:   e8 dc fe ff ff            call   fffffeee <_EIP+0xfffffeee> d0801a80 <[jbd]__journal_try_to_free_buffer+0/b0>
Code;  d0801ba4 <[jbd]journal_try_to_free_buffers+74/a0>
  12:   5a                        pop    %edx
Code;  d0801ba5 <[jbd]journal_try_to_free_buffers+75/a0>
  13:   85 00                     test   %eax,(%eax)


5 warnings and 2 errors issued.  Results may not be reliable.

