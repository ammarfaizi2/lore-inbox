Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbSLEMTN>; Thu, 5 Dec 2002 07:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267307AbSLEMTN>; Thu, 5 Dec 2002 07:19:13 -0500
Received: from mail47-s.fg.online.no ([148.122.161.47]:49603 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP
	id <S267306AbSLEMTK>; Thu, 5 Dec 2002 07:19:10 -0500
Date: Thu, 5 Dec 2002 13:26:49 +0100
From: Michael <soppscum@online.no>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.47-xfs[cvs] Oops when mounting ISO image.
Message-Id: <20021205132649.5be6fded.soppscum@online.no>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, this is truly a terrific kernel(for me), fixed alot of stability issues I had.
Have to wonder why keyboard/mouse support is so well "hidden" though =)
Anyway, my issue is a 'oops' whenever I mount a ISO image file.
(I have compiled the loop device as a module)

example :
spam michael # mount -o loop stuff/linux-cd/knoppix/orig/KNOPPIX_V3.1-08-11-2002-EN.iso /mnt/iso
Then It becomes a zombie.

ksymoops 2.4.8 on i586 2.5.47-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.47-xfs/ (default)
     -m /usr/src/linux/System.map (default)

Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210282
eax: c02b95c0   ebx: e4a4ec20   ecx: e4a4ec20   edx: cc192480
esi: e7faedc0   edi: e7faedc0   ebp: 00000000   esp: e073df24
ds: 0068   es: 0068   ss: 0068
Stack: c01cea8c cbf21348 e4a4ec20 e073df5c 00001000 ec9d4540 e073df64 00000000 
       ec9d46d2 e4a4ec20 e073df5c 00001000 ec9d4540 e073df64 00000000 00000000 
       cc226000 dfcb1000 00001000 c0116d8e 00000000 00000000 ec9d4722 cc226000 
Call Trace: [<c01cea8c>]  [<ec9d4540>]  [<ec9d46d2>]  [<ec9d4540>]  [<c0116d8e>]
  [<ec9d4722>]  [<ec9d479e>]  [<ec9d4d85>]  [<ec9d4ca0>]  [<c01070c1>] 
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; c02b95c0 <proc_root+23e0/2e80>
>>ebx; e4a4ec20 <xfrm_policy_list+2472ffbc/2858f3fc>
>>ecx; e4a4ec20 <xfrm_policy_list+2472ffbc/2858f3fc>
>>edx; cc192480 <xfrm_policy_list+be7381c/2858f3fc>
>>esi; e7faedc0 <xfrm_policy_list+27c9015c/2858f3fc>
>>edi; e7faedc0 <xfrm_policy_list+27c9015c/2858f3fc>
>>esp; e073df24 <xfrm_policy_list+2041f2c0/2858f3fc>

Trace; c01cea8c <pagebuf_offset+1f8c/eb00>
Trace; ec9d4540 <[loop]lo_read_actor+0/100>
Trace; ec9d46d2 <[loop]do_lo_receive+92/a0>
Trace; ec9d4540 <[loop]lo_read_actor+0/100>
Trace; c0116d8e <__wake_up+6e/80>
Trace; ec9d4722 <[loop]lo_receive+42/80>
Trace; ec9d479e <[loop]do_bio_filebacked+3e/80>
Trace; ec9d4d85 <[loop]loop_thread+e5/160>
Trace; ec9d4ca0 <[loop]loop_thread+0/160>
Trace; c01070c1 <enable_hlt+1e1/200>


1 warning and 1 error issued.  Results may not be reliable.


Thanks.
