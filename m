Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275923AbTHOMjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275925AbTHOMjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:39:52 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:54159 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S275923AbTHOMjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:39:12 -0400
Date: Fri, 15 Aug 2003 15:39:11 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test3mm2oops in mm/filemap:1930
Message-ID: <Pine.LNX.4.56.0308151537300.20496@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.9 on i686 2.6.0-test3-mm2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test3-mm2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at mm/filemap.c:1930!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c013c65c>]    Tainted: P   VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: ce9a4720   ebx: 00000000   ecx: ce9bffe0   edx: c011fbe0
esi: 00000000   edi: cbb7df64   ebp: cbb7de60   esp: cbb7de34
ds: 007b   es: 007b   ss: 0068
Stack: 00000400 cbb7de5c c26f86c0 cac5f1c0 cbb7df30 c139f3c0 c139f450 c62659c0
       cbb7de78 c62659c0 c62659e0 cbb7df4c c013c7d4 cbb7de78 cbb7df64 00000001
       c62659e0 00000000 00000000 00000000 00000001 ffffffff c62659c0 cf47a128
Call Trace:
 [<c013c7d4>] generic_file_write_nolock+0xa4/0xc0
 [<c011fbe0>] autoremove_wake_function+0x0/0x50
 [<c011fbe0>] autoremove_wake_function+0x0/0x50
 [<c01ac2b0>] ext2_bmap+0x0/0x30
 [<c01ac1ce>] ext2_get_block+0x2e/0x30
 [<c0159c85>] generic_block_bmap+0x35/0x40
 [<c013c985>] generic_file_write+0x55/0xd0
 [<c01aa5c0>] ext2_release_file+0x0/0x20
 [<c015dcf0>] blkdev_file_write+0x0/0x40
 [<c015dd23>] blkdev_file_write+0x33/0x40
 [<c015547e>] vfs_write+0xce/0x140
 [<c0154f45>] sys_lseek+0x65/0xb0
 [<c015558f>] sys_write+0x3f/0x60
 [<c02d7993>] syscall_call+0x7/0xb
Code: 8b 4d 08 89 7c 24 04 c7 44 24 08 01 00 00 00 89 54 24 0c 89 0c 24 e8 d4 f3 ff ff 89 c7 8b 45 08 83 78 10 ff 75 c9 e9 6e ff ff ff <0f> 0b 8a 07 bf 03 2f c0 e9 4f ff ff ff 8d b4 26 00 00 00 00 55


>>EIP; c013c65c <generic_file_aio_write_nolock+ec/100>   <=====

>>eax; ce9a4720 <__crc_user_get_super+2923dc/2b901e>
>>ecx; ce9bffe0 <__crc_user_get_super+2adc9c/2b901e>
>>edx; c011fbe0 <autoremove_wake_function+0/50>
>>edi; cbb7df64 <__crc_get_user_pages+6ec1/41bae8>
>>ebp; cbb7de60 <__crc_get_user_pages+6dbd/41bae8>
>>esp; cbb7de34 <__crc_get_user_pages+6d91/41bae8>

Trace; c013c7d4 <generic_file_write_nolock+a4/c0>
Trace; c011fbe0 <autoremove_wake_function+0/50>
Trace; c011fbe0 <autoremove_wake_function+0/50>
Trace; c01ac2b0 <ext2_bmap+0/30>
Trace; c01ac1ce <ext2_get_block+2e/30>
Trace; c0159c85 <generic_block_bmap+35/40>
Trace; c013c985 <generic_file_write+55/d0>
Trace; c01aa5c0 <ext2_release_file+0/20>
Trace; c015dcf0 <blkdev_file_write+0/40>
Trace; c015dd23 <blkdev_file_write+33/40>
Trace; c015547e <vfs_write+ce/140>
Trace; c0154f45 <sys_lseek+65/b0>
Trace; c015558f <sys_write+3f/60>
Trace; c02d7993 <__xfrm_policy_check+4c3/5e0>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c013c631 <generic_file_aio_write_nolock+c1/100>
00000000 <_EIP>:
Code;  c013c631 <generic_file_aio_write_nolock+c1/100>
   0:   8b 4d 08                  mov    0x8(%ebp),%ecx
Code;  c013c634 <generic_file_aio_write_nolock+c4/100>
   3:   89 7c 24 04               mov    %edi,0x4(%esp,1)
Code;  c013c638 <generic_file_aio_write_nolock+c8/100>
   7:   c7 44 24 08 01 00 00      movl   $0x1,0x8(%esp,1)
Code;  c013c63f <generic_file_aio_write_nolock+cf/100>
   e:   00
Code;  c013c640 <generic_file_aio_write_nolock+d0/100>
   f:   89 54 24 0c               mov    %edx,0xc(%esp,1)
Code;  c013c644 <generic_file_aio_write_nolock+d4/100>
  13:   89 0c 24                  mov    %ecx,(%esp,1)
Code;  c013c647 <generic_file_aio_write_nolock+d7/100>
  16:   e8 d4 f3 ff ff            call   fffff3ef <_EIP+0xfffff3ef>
Code;  c013c64c <generic_file_aio_write_nolock+dc/100>
  1b:   89 c7                     mov    %eax,%edi
Code;  c013c64e <generic_file_aio_write_nolock+de/100>
  1d:   8b 45 08                  mov    0x8(%ebp),%eax
Code;  c013c651 <generic_file_aio_write_nolock+e1/100>
  20:   83 78 10 ff               cmpl   $0xffffffff,0x10(%eax)
Code;  c013c655 <generic_file_aio_write_nolock+e5/100>
  24:   75 c9                     jne    ffffffef <_EIP+0xffffffef>
Code;  c013c657 <generic_file_aio_write_nolock+e7/100>
  26:   e9 6e ff ff ff            jmp    ffffff99 <_EIP+0xffffff99>

This decode from eip onwards should be reliable

Code;  c013c65c <generic_file_aio_write_nolock+ec/100>
00000000 <_EIP>:
Code;  c013c65c <generic_file_aio_write_nolock+ec/100>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013c65e <generic_file_aio_write_nolock+ee/100>
   2:   8a 07                     mov    (%edi),%al
Code;  c013c660 <generic_file_aio_write_nolock+f0/100>
   4:   bf 03 2f c0 e9            mov    $0xe9c02f03,%edi
Code;  c013c665 <generic_file_aio_write_nolock+f5/100>
   9:   4f                        dec    %edi
Code;  c013c666 <generic_file_aio_write_nolock+f6/100>
   a:   ff                        (bad)
Code;  c013c667 <generic_file_aio_write_nolock+f7/100>
   b:   ff                        (bad)
Code;  c013c668 <generic_file_aio_write_nolock+f8/100>
   c:   ff 8d b4 26 00 00         decl   0x26b4(%ebp)
Code;  c013c66e <generic_file_aio_write_nolock+fe/100>
  12:   00 00                     add    %al,(%eax)
Code;  c013c670 <__generic_file_write_nolock+0/c0>
  14:   55                        push   %ebp


1 warning and 1 error issued.  Results may not be reliable.


Linux Dino 2.6.0-test3-mm2 #18 Wed Aug 13 12:03:33 EEST 2003 i686 unknown
unknown GNU/Linux

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.33
jfsutils               1.1.2
xfsprogs               2.3.9
quota-tools            3.08.
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.4
Procps                 2.0.13
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         evdev nfs af_packet videodev nvidia nls_cp437 isofs
zlib_inflate ide_cd cdrom usb_storage scsi_mod uhci_hcd usbcore via_agp
agpgart tun snd_pcm_oss snd_mixer_oss snd_via82xx snd_mpu401_uart
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_event
snd_seq_midi_emul snd_seq snd_emu10k1 snd_rawmidi snd_pcm snd_timer
snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd
soundcore autofs4 nfsd exportfs lockd sunrpc ip6table_filter ip6_tables
ipt_LOG ipt_limit ipt_state ipt_REJECT ipt_MARK iptable_mangle ip_nat_ftp
iptable_nat ip_conntrack_ftp ip_conntrack ip_queue iptable_filter
ip_tables dummy ip6_tunnel md5 ipv6


Please let me know if you want more info.

Thank you!

---
Catalin(ux) BOIE
catab@deuroconsult.ro
