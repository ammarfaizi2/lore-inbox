Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbUK0CCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUK0CCy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUKZThz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:37:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262378AbUKZTWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:22:01 -0500
Message-ID: <41A67D11.90507@treshna.com>
Date: Fri, 26 Nov 2004 13:47:13 +1300
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel error while backing up to tape.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the message i get when trying to backup to a tape device. This 
backup procedure normally works fine, it just did this on a once off. 
The kernel is 2.6.8.1.
Could this be related to a tape running out of capacity but not giving a 
nice error message?



------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:276!
invalid operand: 0000 [#1]
SMP
Modules linked in: st usb_storage nfsd exportfs snd_intel8x0 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart 
snd_rawmidi snd_seq_device snd soundcore ehci_hcd usbcore intel_agp 
agpgart evdev reiserfs initio i2c_i801 i2c_isa i2c_nforce2 it87 
w83l785ts w83781d i2c_i810 i2c_algo_bit i2c_sensor i2c_core 8250 
serial_core ac asus_acpi fan sk98lin
CPU:    0
EIP:    0060:[<c016b93e>]    Not tainted
EFLAGS: 00010246   (2.6.8.1)
EIP is at d_alloc+0x149/0x194
eax: 00000000   ebx: ddadaef0   ecx: 00000000   edx: f750c0e0
esi: e8c8b020   edi: ddadaf6a   ebp: f59f5eb4   esp: f59f5e1c
ds: 007b   es: 007b   ss: 0068
Process tar (pid: 15544, threadinfo=f59f4000 task=f7dcb390)
Stack: f7fd5580 000000d0 f59f5eb4 fffffff4 f52cd5f0 f52cd584 f750c0e0 
c016162a
       f750c0e0 f59f5eb4 0000000e 00000000 f59f5f18 f7fc2580 f59f5eac 
c01618d3
       f750c0e0 f59f5eb4 f59f5f18 f59f5eac e8c8b012 f52cd584 f59f5f18 
c0161f5a
Call Trace:
 [<c016162a>] real_lookup+0xaf/0xf0
 [<c01618d3>] do_lookup+0x96/0xa1
 [<c0161f5a>] link_path_walk+0x67c/0xce9
 [<c02704c6>] opost+0x9a/0x1ac
 [<c0162859>] path_lookup+0x94/0x157
 [<c0162ad2>] __user_walk+0x49/0x5e
 [<c015d969>] vfs_lstat+0x1c/0x58
 [<c026d1ed>] tty_write+0x185/0x279
 [<c027284d>] write_chan+0x0/0x21a
 [<c015e01d>] sys_lstat64+0x1b/0x39
 [<c0154898>] vfs_write+0xc9/0x119
 [<c01549b9>] sys_write+0x51/0x80
 [<c0105ed9>] sysenter_past_esp+0x52/0x71
Code: 0f 0b 14 01 98 1b 36 c0 eb 9c 8d 43 2c 89 43 2c 89 43 30 eb

ksymoops output:

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at include/linux/dcache.h:276!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c016b93e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.8.1)
eax: 00000000   ebx: ddadaef0   ecx: 00000000   edx: f750c0e0
esi: e8c8b020   edi: ddadaf6a   ebp: f59f5eb4   esp: f59f5e1c
ds: 007b   es: 007b   ss: 0068
Stack: f7fd5580 000000d0 f59f5eb4 fffffff4 f52cd5f0 f52cd584 f750c0e0
c016162a
       f750c0e0 f59f5eb4 0000000e 00000000 f59f5f18 f7fc2580 f59f5eac
c01618d3
       f750c0e0 f59f5eb4 f59f5f18 f59f5eac e8c8b012 f52cd584 f59f5f18
c0161f5a
 [<c016162a>] real_lookup+0xaf/0xf0
 [<c01618d3>] do_lookup+0x96/0xa1
 [<c0161f5a>] link_path_walk+0x67c/0xce9
 [<c02704c6>] opost+0x9a/0x1ac
 [<c0162859>] path_lookup+0x94/0x157
 [<c0162ad2>] __user_walk+0x49/0x5e
 [<c015d969>] vfs_lstat+0x1c/0x58
 [<c026d1ed>] tty_write+0x185/0x279
 [<c027284d>] write_chan+0x0/0x21a
 [<c015e01d>] sys_lstat64+0x1b/0x39
 [<c0154898>] vfs_write+0xc9/0x119
 [<c01549b9>] sys_write+0x51/0x80
 [<c0105ed9>] sysenter_past_esp+0x52/0x71
Code: 0f 0b 14 01 98 1b 36 c0 eb 9c 8d 43 2c 89 43 2c 89 43 30 eb


 >>EIP; c016b93e <d_alloc+149/194>   <=====

 >>ebx; ddadaef0 <pg0+1d639ef0/3fb5d000>
 >>edx; f750c0e0 <pg0+3706b0e0/3fb5d000>
 >>esi; e8c8b020 <pg0+287ea020/3fb5d000>
 >>edi; ddadaf6a <pg0+1d639f6a/3fb5d000>
 >>ebp; f59f5eb4 <pg0+35554eb4/3fb5d000>
 >>esp; f59f5e1c <pg0+35554e1c/3fb5d000>

Code;  c016b93e <d_alloc+149/194>
00000000 <_EIP>:
Code;  c016b93e <d_alloc+149/194>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c016b940 <d_alloc+14b/194>
   2:   14 01                     adc    $0x1,%al
Code;  c016b942 <d_alloc+14d/194>
   4:   98                        cwtl
Code;  c016b943 <d_alloc+14e/194>
   5:   1b 36                     sbb    (%esi),%esi
Code;  c016b945 <d_alloc+150/194>
   7:   c0 eb 9c                  shr    $0x9c,%bl
Code;  c016b948 <d_alloc+153/194>
   a:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  c016b94b <d_alloc+156/194>
   d:   89 43 2c                  mov    %eax,0x2c(%ebx)
Code;  c016b94e <d_alloc+159/194>
  10:   89 43 30                  mov    %eax,0x30(%ebx)
Code;  c016b951 <d_alloc+15c/194>
  13:   eb 00                     jmp    15 <_EIP+0x15>


1 warning and 1 error issued.  Results may not be reliable.



