Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312564AbSCYUsc>; Mon, 25 Mar 2002 15:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312567AbSCYUsX>; Mon, 25 Mar 2002 15:48:23 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:58606 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S312564AbSCYUsQ>; Mon, 25 Mar 2002 15:48:16 -0500
Date: Mon, 25 Mar 2002 21:49:46 +0100 (CET)
From: root <root@schoen3.schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: INFO: decoded OOPS
Message-ID: <Pine.LNX.4.33.0203252146250.6095-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0203252148261.6095@schoen3.schoen.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My 2.4.17 kernel crashed recently with the following OOPS:

ksymoops 2.4.1 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.2417 (specified)

Error (regular_file): read_system_map stat /boot/System.2417 failed
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d0862574, /lib/modules/2.4.17/kernel/drivers/usb/usbcore.o says d0862074.  Ignoring /lib/modules/2.4.17/kernel/drivers/usb/usbcore.o entry
Mar 25 01:37:00 schoen3 kernel: invalid operand: 0000
Mar 25 01:37:00 schoen3 kernel: CPU:    0
Mar 25 01:37:00 schoen3 kernel: EIP:    0010:[<c012977e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 25 01:37:00 schoen3 kernel: EFLAGS: 00010206
Mar 25 01:37:00 schoen3 kernel: eax: c1bccb60   ebx: 00000000   ecx: 00000000   edx: 00000000
Mar 25 01:37:00 schoen3 kernel: esi: c1bccb60   edi: bfffb000   ebp: 00005000   esp: ceacfeec
Mar 25 01:37:00 schoen3 kernel: ds: 0018   es: 0018   ss: 0018
Mar 25 01:37:00 schoen3 kernel: Process cron (pid: 17952, stackpage=ceacf000)
Mar 25 01:37:00 schoen3 kernel: Stack: c1bccb60 ceace000 ceacffc4 0000000b 00000000 c01170b6 c1bccb60 c1bccb60
Mar 25 01:37:00 schoen3 kernel:        c011c066 c1bccb60 0000000b 0000000b ceacffc4 ceacff40 c0106dfa 0000000b
Mar 25 01:37:00 schoen3 kernel:        ceace000 00000007 c011452c bffff754 ceace660 0000000b 00000000 00030001
Mar 25 01:37:00 schoen3 kernel: Call Trace: [<c01170b6>] [<c011c066>] [<c0106dfa>] [<c011452c>] [<c011c229>]
Mar 25 01:37:00 schoen3 kernel:    [<c0107070>] [<c0106f84>]
Mar 25 01:37:00 schoen3 kernel: Code: 0f 0b 68 00 03 00 00 6a 00 56 e8 7b d0 ff ff 83 c4 0c 5b 5e

>>EIP; c012977e <do_brk+3aa/624>   <=====
Trace; c01170b6 <remove_wait_queue+38a/14c0>
Trace; c011c066 <exit_mm+4c6/690>
Trace; c0106dfa <__read_lock_failed+104e/2634>
Trace; c011452c <__verify_write+22c/914>
Trace; c011c229 <exit_mm+689/690>
Trace; c0107070 <__read_lock_failed+12c4/2634>
Trace; c0106f84 <__read_lock_failed+11d8/2634>
Code;  c012977e <do_brk+3aa/624>
00000000 <_EIP>:
Code;  c012977e <do_brk+3aa/624>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129780 <do_brk+3ac/624>
   2:   68 00 03 00 00            push   $0x300
Code;  c0129785 <do_brk+3b1/624>
   7:   6a 00                     push   $0x0
Code;  c0129787 <do_brk+3b3/624>
   9:   56                        push   %esi
Code;  c0129788 <do_brk+3b4/624>
   a:   e8 7b d0 ff ff            call   ffffd08a <_EIP+0xffffd08a> c0126808 <flush_scheduled_tasks+650/ebc>
Code;  c012978d <do_brk+3b9/624>
   f:   83 c4 0c                  add    $0xc,%esp
Code;  c0129790 <do_brk+3bc/624>
  12:   5b                        pop    %ebx
Code;  c0129791 <do_brk+3bd/624>
  13:   5e                        pop    %esi


1 warning and 1 error issued.  Results may not be reliable.

I hope it can be of help

Kees

