Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSLZT2n>; Thu, 26 Dec 2002 14:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbSLZT2n>; Thu, 26 Dec 2002 14:28:43 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:57506 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id <S263491AbSLZT2l>;
	Thu, 26 Dec 2002 14:28:41 -0500
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Subject: alsa oops with 2.5.53
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Thu, 26 Dec 2002 11:36:48 -0800
Message-ID: <871y44wp0v.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i386-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i got the following oops running 2.5.53 on a sony vaio pcg-xg19
(pentium iii 650 MHz). the soundcard is ymfpci.

ksymoops 2.4.6 on i686 2.5.53.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.53/ (default)
     -m /boot/System.map-2.5.53 (default)
     -x

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
Dec 26 11:23:23 trinculo kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000014
Dec 26 11:23:23 trinculo kernel: d1211e2a
Dec 26 11:23:23 trinculo kernel: *pde = 00000000
Dec 26 11:23:23 trinculo kernel: Oops: 0000
Dec 26 11:23:23 trinculo kernel: CPU:    0
Dec 26 11:23:23 trinculo kernel: EIP:    0060:[<d1211e2a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 26 11:23:23 trinculo kernel: EFLAGS: 00010002
Dec 26 11:23:23 trinculo kernel: eax: c463a000   ebx: 00000286   ecx: c811f000   edx: 00000000
Dec 26 11:23:23 trinculo kernel: esi: cc627234   edi: 00000000   ebp: c463be18   esp: c463be10
Dec 26 11:23:23 trinculo kernel: ds: 0068   es: 0068   ss: 0068
Dec 26 11:23:23 trinculo kernel: Stack: cc627234 c463a000 c463be30 d11cb0ff cc627234 fffffff5 c87a267c 00000003 
Dec 26 11:23:23 trinculo kernel:        c463be50 d11cb2d4 c87a267c c463bea0 cd321520 00000000 00000000 cc627234 
Dec 26 11:23:23 trinculo kernel:        c463bed4 d11cb573 c199614c cd321400 c463be9c 00000003 00000000 00000000 
Dec 26 11:23:23 trinculo kernel: Call Trace:
Dec 26 11:23:23 trinculo kernel:  [<d11cb0ff>] snd_pcm_oss_release_file+0x7f/0xb4 [snd_pcm_oss]
Dec 26 11:23:23 trinculo kernel:  [<d11cb2d4>] snd_pcm_oss_open_file+0x1a0/0x1d8 [snd_pcm_oss]
Dec 26 11:23:23 trinculo kernel:  [<d11cb573>] snd_pcm_oss_open+0x267/0x310 [snd_pcm_oss]
Dec 26 11:23:23 trinculo kernel:  [<d110ae00>] soundcore_fops+0x0/0x60 [soundcore]
Dec 26 11:23:23 trinculo kernel:  [<c01177f0>] default_wake_function+0x0/0x34
Dec 26 11:23:23 trinculo kernel:  [<c014d24d>] link_path_walk+0x801/0x8c0
Dec 26 11:23:23 trinculo kernel:  [<c01248fe>] in_group_p+0x22/0x2c
Dec 26 11:23:23 trinculo kernel:  [<d110a61a>] soundcore_open+0x1b2/0x2b8 [soundcore]
Dec 26 11:23:23 trinculo kernel:  [<d11d11c0>] snd_pcm_oss_f_reg+0x0/0x58 [snd_pcm_oss]
Dec 26 11:23:23 trinculo kernel:  [<c0149168>] chrdev_open+0x5c/0xa0
Dec 26 11:23:23 trinculo kernel:  [<c0140ee6>] dentry_open+0xf6/0x1e4
Dec 26 11:23:23 trinculo kernel:  [<c0140de3>] filp_open+0x4f/0x5c
Dec 26 11:23:23 trinculo kernel:  [<c01411ff>] sys_open+0x37/0x74
Dec 26 11:23:23 trinculo kernel:  [<c0108c27>] syscall_call+0x7/0xb
Dec 26 11:23:23 trinculo kernel: Code: f6 42 14 04 74 20 8b 81 fc 09 00 00 85 c0 7e 16 48 89 81 fc 


>>EIP; d1211e2a <END_OF_CODE+283701966/????>   <=====

Trace; d11cb0ff <END_OF_CODE+283411875/????>
Trace; d11cb2d4 <END_OF_CODE+283412344/????>
Trace; d11cb573 <END_OF_CODE+283413015/????>
Trace; d110ae00 <END_OF_CODE+282624676/????>
Trace; c01177f0 <default_wake_function+0/52>
Trace; c014d24d <link_path_walk+2049/2240>
Trace; c01248fe <in_group_p+34/44>
Trace; d110a61a <END_OF_CODE+282622654/????>
Trace; d11d11c0 <END_OF_CODE+283436644/????>
Trace; c0149168 <chrdev_open+92/160>
Trace; c0140ee6 <dentry_open+246/484>
Trace; c0140de3 <filp_open+79/92>
Trace; c01411ff <sys_open+55/116>
Trace; c0108c27 <syscall_call+7/11>

Code;  d1211e2a <END_OF_CODE+283701966/????>
00000000 <_EIP>:
Code;  d1211e2a <END_OF_CODE+283701966/????>   <=====
   0:   f6 42 14 04               testb  $0x4,0x14(%edx)   <=====
Code;  d1211e2e <END_OF_CODE+283701970/????>
   4:   74 20                     je     26 <_EIP+0x26>
Code;  d1211e30 <END_OF_CODE+283701972/????>
   6:   8b 81 fc 09 00 00         mov    0x9fc(%ecx),%eax
Code;  d1211e36 <END_OF_CODE+283701978/????>
   c:   85 c0                     test   %eax,%eax
Code;  d1211e38 <END_OF_CODE+283701980/????>
   e:   7e 16                     jle    26 <_EIP+0x26>
Code;  d1211e3a <END_OF_CODE+283701982/????>
  10:   48                        dec    %eax
Code;  d1211e3b <END_OF_CODE+283701983/????>
  11:   89 81 fc 00 00 00         mov    %eax,0xfc(%ecx)


1 warning and 1 error issued.  Results may not be reliable.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
