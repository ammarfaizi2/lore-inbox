Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbSKLVqR>; Tue, 12 Nov 2002 16:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbSKLVqR>; Tue, 12 Nov 2002 16:46:17 -0500
Received: from web12306.mail.yahoo.com ([216.136.173.104]:26238 "HELO
	web12306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266977AbSKLVqN>; Tue, 12 Nov 2002 16:46:13 -0500
Message-ID: <20021112215303.29126.qmail@web12306.mail.yahoo.com>
Date: Tue, 12 Nov 2002 13:53:03 -0800 (PST)
From: Mike Keehan <mike_keehan@yahoo.com>
Subject: [Oops] 2.5.46 & 2.5.47 crash at shutdown
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both .46 and .47 crash at shutdown on my HP 6000
laptop, just after unmounting all disks,
with the following output (copied by hand):-

Unable to handle kernel paging request at virtual
address cd066ae8
 printing eip:
c019ecfd
*pde = 0bd88067
*pte = 00000000
Oops: 0000
nls_cp437 vfat fat usbcore
CPU: 0
EIP: 0060:[<c019ecfd>]   Not tainted
EFLAGS: 00010286
EIP is at device_shutdown+0x69/0x9a
eax: cd066a88  ebx: cbee8c50  ecx: 00000001  edx:
00000001
esi: 4321fedc  edi: fee1dead  ebp: bffffd0c  esp:
ca517ea4
ds: 0068  es: 0068  ss:0068
Process halt(pid: 1633, threadinfo=ca516000 
task=caaa06e0)
Stack: ca516000 c01236a4 c0362a48 00000003 00000000
ca516000 08049604 00000282
       080495fe bffffd5c cb9ee400 40059a44 00000000
c0121e30 00000014 ca517f40
       00000282 ca516000 fffffffd 080495fe c0121fbe
00000014 ca517f40 c11f4040
Call Trace:
 [<c01236a4>]  sys_reboot+0x168/0x2a4
 [<c0121e30>]  send_sig_info+0x24/0x40
 [<c0121fbe>]  kill_proc_info+0x32/0x4c
 [<c01220b0>]  kill_something_info+0xd8/0xe0
 [<c0122b05>]  sys_kill+0x51/0x5c
 [<c0115b1c>]  schedule+0x268/0x2c8
 [<c0120bee>]  schedule_timeout+0x82/0x9c
 [<c0120b60>]  process_timeout+0x0/0xc
 [<c0120cbb>]  sys_nanosleep+0xa3/0xf8
 [<c010a30f>]  syscall_call+0x7/0xb
Code: 83 78 60 00 74 0d 53 8b 40 60 ff d0 83 c4 04 8d
74 26 00 8b
Segmentation fault

It is quite repeatable. I can try building the kernel
with serial console if it would help.
Versions prior to 2.5.46 used to shutdown OK.

Regards,

   Mike.



__________________________________________________
Do you Yahoo!?
U2 on LAUNCH - Exclusive greatest hits videos
http://launch.yahoo.com/u2
