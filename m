Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbUKXQEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbUKXQEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbUKXQDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:03:32 -0500
Received: from vidconference.de ([212.227.158.183]:20402 "EHLO
	baldur.vidconference.de") by vger.kernel.org with ESMTP
	id S262719AbUKXQCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:02:15 -0500
Message-ID: <41A4B085.20109@vidsoft.de>
Date: Wed, 24 Nov 2004 17:02:13 +0100
From: Gregor Jasny <jasny@vidsoft.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in bttv (Linux 2.6.10-rc2-bk3)
Content-Type: multipart/mixed;
 boundary="------------060305030406060307060901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305030406060307060901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi list,

My machine oopsed during an VIDIOCMCAPTURE or an VIDIOCSYNC ioctl.

If you need more information please contact me.

Regards,
-G. Jasny


--------------060305030406060307060901
Content-Type: text/plain;
 name="v4loops.decoded.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4loops.decoded.txt"

ksymoops 2.4.9 on i686 2.6.10-rc2-bk3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10-rc2-bk3/ (default)
     -m /boot/System.map-2.6.10-rc2-bk3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00001e00
f08fe594
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<f08fe594>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010092   (2.6.10-rc2-bk3)
eax: d601e924   ebx: 00001e00   ecx: ed6d1080   edx: ed6d10e4
esi: d601e4c4   edi: ed6d1080   ebp: f0919520   esp: de1d1c58
ds: 007b   es: 007b   ss: 0068
Stack: 00000246 00000000 f08ffc12 d601e400 ed6d1080 f0909b34 00000160 00000120
       00000003 d601e400 ed6d1080 000191f0 ef394500 c03981a0 de1d1cb8 c0110d8f
       ef394500 00000000 724ff65c 0647ce17 a5d2c4b2 000230c2 00000001 df20e500
Call Trace:
 [<f08ffc12>] bttv_do_ioctl+0x49c/0x17c0 [bttv]
 [<c0110d8f>] recalc_task_prio+0x93/0x188
 [<c01114d9>] scheduler_tick+0x163/0x439
 [<c011bb3e>] update_process_times+0x46/0x52
 [<c0110d8f>] recalc_task_prio+0x93/0x188
 [<c0110d8f>] recalc_task_prio+0x93/0x188
 [<c0110ee8>] activate_task+0x64/0x77
 [<c01117f9>] __wake_up_common+0x38/0x57
 [<c01e746d>] n_tty_receive_buf+0x163/0xe41
 [<c012fad3>] buffered_rmqueue+0xbf/0x14e
 [<c012fd2b>] __alloc_pages+0x1c9/0x35b
 [<c01e9baf>] pty_write+0x67/0x6b
 [<c01e6237>] tty_default_put_char+0x2b/0x2f
 [<c01e6ad1>] opost+0x9a/0x1a4
 [<c01b9f3c>] copy_from_user+0x42/0x6e
 [<f0819328>] video_usercopy+0x7b/0x135 [videodev]
 [<c01e3b39>] tty_write+0x20e/0x260
 [<c01e8ba6>] write_chan+0x0/0x20d
 [<c0110d8f>] recalc_task_prio+0x93/0x188
 [<f0900f36>] bttv_ioctl+0x0/0x61 [bttv]
 [<f0900f74>] bttv_ioctl+0x3e/0x61 [bttv]
 [<f08ff776>] bttv_do_ioctl+0x0/0x17c0 [bttv]
 [<c0155fc0>] sys_ioctl+0xb7/0x203
 [<c0102deb>] syscall_call+0x7/0xb
Code: 24 04 8b 44 24 0c 8b 80 c8 00 00 00 8b 4c 24 10 8b 30 8d 51 64 c7 41 20 02 00 00 00 8d 86 60 04 00 00 8b 58 04 89 41 64 89 50 04 <89> 13 89 5a 04 8b8e 7c 04 00 00 85 c9 74 0b 8b 1c 24 8b 74 24


>>EIP; f08fe594 <pg0+3054b594/3fc4b400>   <=====

>>eax; d601e924 <pg0+15c6b924/3fc4b400>
>>ecx; ed6d1080 <pg0+2d31e080/3fc4b400>
>>edx; ed6d10e4 <pg0+2d31e0e4/3fc4b400>
>>esi; d601e4c4 <pg0+15c6b4c4/3fc4b400>
>>edi; ed6d1080 <pg0+2d31e080/3fc4b400>
>>ebp; f0919520 <pg0+30566520/3fc4b400>
>>esp; de1d1c58 <pg0+1de1ec58/3fc4b400>

Trace; f08ffc12 <pg0+3054cc12/3fc4b400>
Trace; c0110d8f <recalc_task_prio+93/188>
Trace; c01114d9 <scheduler_tick+163/439>
Trace; c011bb3e <update_process_times+46/52>
Trace; c0110d8f <recalc_task_prio+93/188>
Trace; c0110d8f <recalc_task_prio+93/188>
Trace; c0110ee8 <activate_task+64/77>
Trace; c01117f9 <__wake_up_common+38/57>
Trace; c01e746d <n_tty_receive_buf+163/e41>
Trace; c012fad3 <buffered_rmqueue+bf/14e>
Trace; c012fd2b <__alloc_pages+1c9/35b>
Trace; c01e9baf <pty_write+67/6b>
Trace; c01e6237 <tty_default_put_char+2b/2f>
Trace; c01e6ad1 <opost+9a/1a4>
Trace; c01b9f3c <copy_from_user+42/6e>
Trace; f0819328 <pg0+30466328/3fc4b400>
Trace; c01e3b39 <tty_write+20e/260>
Trace; c01e8ba6 <write_chan+0/20d>
Trace; c0110d8f <recalc_task_prio+93/188>
Trace; f0900f36 <pg0+3054df36/3fc4b400>
Trace; f0900f74 <pg0+3054df74/3fc4b400>
Trace; f08ff776 <pg0+3054c776/3fc4b400>
Trace; c0155fc0 <sys_ioctl+b7/203>
Trace; c0102deb <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  f08fe569 <pg0+3054b569/3fc4b400>
00000000 <_EIP>:
Code;  f08fe569 <pg0+3054b569/3fc4b400>
   0:   24 04                     and    $0x4,%al
Code;  f08fe56b <pg0+3054b56b/3fc4b400>
   2:   8b 44 24 0c               mov    0xc(%esp),%eax
Code;  f08fe56f <pg0+3054b56f/3fc4b400>
   6:   8b 80 c8 00 00 00         mov    0xc8(%eax),%eax
Code;  f08fe575 <pg0+3054b575/3fc4b400>
   c:   8b 4c 24 10               mov    0x10(%esp),%ecx
Code;  f08fe579 <pg0+3054b579/3fc4b400>
  10:   8b 30                     mov    (%eax),%esi
Code;  f08fe57b <pg0+3054b57b/3fc4b400>
  12:   8d 51 64                  lea    0x64(%ecx),%edx
Code;  f08fe57e <pg0+3054b57e/3fc4b400>
  15:   c7 41 20 02 00 00 00      movl   $0x2,0x20(%ecx)
Code;  f08fe585 <pg0+3054b585/3fc4b400>
  1c:   8d 86 60 04 00 00         lea    0x460(%esi),%eax
Code;  f08fe58b <pg0+3054b58b/3fc4b400>
  22:   8b 58 04                  mov    0x4(%eax),%ebx
Code;  f08fe58e <pg0+3054b58e/3fc4b400>
  25:   89 41 64                  mov    %eax,0x64(%ecx)
Code;  f08fe591 <pg0+3054b591/3fc4b400>
  28:   89 50 04                  mov    %edx,0x4(%eax)

This decode from eip onwards should be reliable

Code;  f08fe594 <pg0+3054b594/3fc4b400>
00000000 <_EIP>:
Code;  f08fe594 <pg0+3054b594/3fc4b400>   <=====
   0:   89 13                     mov    %edx,(%ebx)   <=====
Code;  f08fe596 <pg0+3054b596/3fc4b400>
   2:   89 5a 04                  mov    %ebx,0x4(%edx)
Code;  f08fe599 <pg0+3054b599/3fc4b400>
   5:   8e 8b 7c 04 00 00         movl   0x47c(%ebx),%cs
Code;  f08fe59f <pg0+3054b59f/3fc4b400>
   b:   85 c9                     test   %ecx,%ecx
Code;  f08fe5a1 <pg0+3054b5a1/3fc4b400>
   d:   74 0b                     je     1a <_EIP+0x1a>
Code;  f08fe5a3 <pg0+3054b5a3/3fc4b400>
   f:   8b 1c 24                  mov    (%esp),%ebx
Code;  f08fe5a6 <pg0+3054b5a6/3fc4b400>
  12:   8b                        .byte 0x8b
Code;  f08fe5a7 <pg0+3054b5a7/3fc4b400>
  13:   74 24                     je     39 <_EIP+0x39>


1 warning and 1 error issued.  Results may not be reliable.


--------------060305030406060307060901--
