Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbSJUW7b>; Mon, 21 Oct 2002 18:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261803AbSJUW7b>; Mon, 21 Oct 2002 18:59:31 -0400
Received: from attila.bofh.it ([213.92.8.2]:20425 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S261802AbSJUW72>;
	Mon, 21 Oct 2002 18:59:28 -0400
Date: Tue, 22 Oct 2002 01:05:25 +0200
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: oops 2.5.44: drivers/base/driver.c:54
Message-ID: <20021021230525.GA1458@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux wonderland 2.5.44 #1 Tue Oct 22 00:22:06 CEST 2002 i686 AMD Athlon(tm) XP 1700+ AuthenticAMD GNU/Linux

gcc version 2.95.4 20011002 (Debian prerelease)

I'm not sure about what triggers it but looks like it happens every time
at boot time.


ksymoops 2.4.5 on i686 2.5.44.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44/ (default)
     -m /boot/System.map-2.5.44 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_ksyms_lsmod): module parport_pc is in lsmod but not in ksyms, probably no symbols exported
Oct 22 00:58:02 wonderland kernel: kernel BUG at drivers/base/driver.c:54!
Oct 22 00:58:02 wonderland kernel: invalid operand: 0000
Oct 22 00:58:02 wonderland kernel: CPU:    0
Oct 22 00:58:02 wonderland kernel: EIP:    0060:[<c01cbeb0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 22 00:58:02 wonderland kernel: EFLAGS: 00010286
Oct 22 00:58:02 wonderland kernel: eax: e11234c0   ebx: 00000000   ecx: dda79000   edx: 0000001c
Oct 22 00:58:02 wonderland kernel: esi: 00000000   edi: d6669000   ebp: e111c000   esp: d7767f78
Oct 22 00:58:02 wonderland kernel: ds: 0068   es: 0068   ss: 0068
Oct 22 00:58:02 wonderland kernel: Stack: c01f96dd e11234c0 e111fbf3 e11234a0 fffffff0 e111c000 c01188e7 fffffff0 
Oct 22 00:58:02 wonderland kernel:        e111c000 d6669000 bfffe67c c0117b40 e111c000 00000000 d7766000 00000000 
Oct 22 00:58:02 wonderland kernel:        bffffa23 bfffe67c c010708b bffffa23 bffffa23 00000000 00000000 bffffa23 
Oct 22 00:58:02 wonderland kernel:  [<c01f96dd>] pnp_unregister_driver+0xd/0x20
Oct 22 00:58:02 wonderland kernel:  [<e11234c0>] parport_pc_pnp_driver+0x20/0x80 [parport_pc]
Oct 22 00:58:02 wonderland kernel:  [<e111fbf3>] cleanup_module+0x43/0x50 [parport_pc]
Oct 22 00:58:02 wonderland kernel:  [<e11234a0>] parport_pc_pnp_driver+0x0/0x80 [parport_pc]
Oct 22 00:58:02 wonderland kernel:  [<c01188e7>] free_module+0x17/0xc0
Oct 22 00:58:02 wonderland kernel:  [<c0117b40>] sys_delete_module+0x120/0x280
Oct 22 00:58:02 wonderland kernel:  [<c010708b>] syscall_call+0x7/0xb
Oct 22 00:58:02 wonderland kernel: Code: 0f 0b 36 00 74 96 29 c0 c3 8d b4 26 00 00 00 00 56 53 8b 5c 


>>EIP; c01cbeb0 <remove_driver+0/10>   <=====

>>eax; e11234c0 <[parport].bss.end+9401/10fa1>
>>ecx; dda79000 <_end+1d66d688/2043d6e8>
>>edi; d6669000 <_end+1625d688/2043d6e8>
>>ebp; e111c000 <[parport].bss.end+1f41/10fa1>
>>esp; d7767f78 <_end+1735c600/2043d6e8>

Code;  c01cbeb0 <remove_driver+0/10>
00000000 <_EIP>:
Code;  c01cbeb0 <remove_driver+0/10>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01cbeb2 <remove_driver+2/10>
   2:   36 00 74 96 29            add    %dh,%ss:0x29(%esi,%edx,4)
Code;  c01cbeb7 <remove_driver+7/10>
   7:   c0 c3 8d                  rol    $0x8d,%bl
Code;  c01cbeba <remove_driver+a/10>
   a:   b4 26                     mov    $0x26,%ah
Code;  c01cbebc <remove_driver+c/10>
   c:   00 00                     add    %al,(%eax)
Code;  c01cbebe <remove_driver+e/10>
   e:   00 00                     add    %al,(%eax)
Code;  c01cbec0 <put_driver+0/70>
  10:   56                        push   %esi
Code;  c01cbec1 <put_driver+1/70>
  11:   53                        push   %ebx
Code;  c01cbec2 <put_driver+2/70>
  12:   8b 5c 00 00               mov    0x0(%eax,%eax,1),%ebx


2 warnings issued.  Results may not be reliable.

-- 
ciao,
Marco
