Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKOFq7>; Wed, 15 Nov 2000 00:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKOFqj>; Wed, 15 Nov 2000 00:46:39 -0500
Received: from pluto.senet.com.au ([203.56.239.150]:17163 "EHLO
	pluto.senet.com.au") by vger.kernel.org with ESMTP
	id <S129061AbQKOFqd>; Wed, 15 Nov 2000 00:46:33 -0500
Date: Wed, 15 Nov 2000 15:46:47 +1030 (CST)
From: Kevin Shanahan <kms@wumi.org.au>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.2.17 Oops
Message-ID: <Pine.LNX.4.21.0011151505220.6044-100000@gateway.wumi.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Over the weekend sometime a Linux machine where I work oops'd. Nobody else
here really understands anything about this stuff so they rang me. I got
them to copy out what was on the screen and then reboot (this was
Monday). Today (Wednesday) I copied in the text and ran it through
ksymoops.

Note that the 6th number in the first row of the "Stack" output was copied
out as "0000aad". I just assumed that they missed a leading zero, which
is probably correct, but may not be.

The machine had been up for about 25 days, and has never crashed
before.

Umm, I'm not sure what other info you might need to pinpoint the
problem, but feel free to ask for whatever is necessary. I'm not
subscribed to the list, so please CC any replies to me.

Thanks,
Kevin Shanahan.


---- ksymoops output ----

ksymoops 0.7c on i686 2.2.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000011
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c0161804>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000059ad ebx: 00000001 ecx: 02206fc0 edx: 000019ad
esi: 0aad1400 edi: 00004000 ebp: 5400a8c0 esp: c01d7e80
ds: 0018 es: 0018 ss: 0018
Stack: 00000000 c01d7edc c014f0e7 c16c0028 c1780000 00000aad 00000003 14000ea4
       02206fc0 c16ced54 00000000 c0155c52 c02b7000 c0155cb0 c02b7000 c02b7000
       c16ced40 c16ced40 c01d7f00 08000000 c0154f50 c16ce820 5400a800 c01d7f00
Call Trace: [<c014f0e7>] [<c0155c52>] [<c0155cb0>] [<c0154f50>] [<c0154f84>]
            [<c0155255>] [<c01553d9>] [<c014aadd>] [<c01164d1>] [<c0108b6f>]
            [<c010883c>] [<c0106249>] [<c0106000>] [<c010626c>] [<c01079bc>]
            [<c0106000>] [<c010607b>] [<c0106000>] [<c0100175>]
Code: 39 4b 10 75 17 39 6b 14 75 12 39 73 18 75 0d 8b 43 1c 85 c0

>>EIP; c0161804 <tcp_chkaddr+140/1f0>   <=====
Trace; c014f0e7 <__ip_masq_set_expire+1f/34>
Trace; c0155c52 <ip_chksock+3a/50>
Trace; c0155cb0 <ip_forward+48/4d8>
Trace; c0154f50 <ip_local_deliver+dc/2a0>
Trace; c0154f84 <ip_local_deliver+110/2a0>
Trace; c0155255 <ip_rcv+141/2f4>
Trace; c01553d9 <ip_rcv+2c5/2f4>
Trace; c014aadd <net_bh+179/1d4>
Trace; c01164d1 <do_bottom_half+45/64>
Trace; c0108b6f <do_IRQ+3b/40>
Trace; c010883c <common_interrupt+18/20>
Trace; c0106249 <cpu_idle+5d/6c>
Trace; c0106000 <get_options+0/74>
Trace; c010626c <sys_idle+14/24>
Trace; c01079bc <system_call+34/38>
Trace; c0106000 <get_options+0/74>
Trace; c010607b <cpu_idle+7/18>
Trace; c0106000 <get_options+0/74>
Trace; c0100175 <L6+0/2>
Code;  c0161804 <tcp_chkaddr+140/1f0>
00000000 <_EIP>:
Code;  c0161804 <tcp_chkaddr+140/1f0>   <=====
   0:   39 4b 10                  cmp    %ecx,0x10(%ebx)   <=====
Code;  c0161807 <tcp_chkaddr+143/1f0>
   3:   75 17                     jne    1c <_EIP+0x1c> c0161820 <tcp_chkaddr+15c/1f0>
Code;  c0161809 <tcp_chkaddr+145/1f0>
   5:   39 6b 14                  cmp    %ebp,0x14(%ebx)
Code;  c016180c <tcp_chkaddr+148/1f0>
   8:   75 12                     jne    1c <_EIP+0x1c> c0161820 <tcp_chkaddr+15c/1f0>
Code;  c016180e <tcp_chkaddr+14a/1f0>
   a:   39 73 18                  cmp    %esi,0x18(%ebx)
Code;  c0161811 <tcp_chkaddr+14d/1f0>
   d:   75 0d                     jne    1c <_EIP+0x1c> c0161820 <tcp_chkaddr+15c/1f0>
Code;  c0161813 <tcp_chkaddr+14f/1f0>
   f:   8b 43 1c                  mov    0x1c(%ebx),%eax
Code;  c0161816 <tcp_chkaddr+152/1f0>
  12:   85 c0                     test   %eax,%eax

Aiee, killing interrupt handler
kernel panic: Attempted to kill the idle task!
In swapper task - not syncing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
