Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSKZXwc>; Tue, 26 Nov 2002 18:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSKZXwc>; Tue, 26 Nov 2002 18:52:32 -0500
Received: from oe51.law11.hotmail.com ([64.4.16.40]:3086 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263228AbSKZXwa>;
	Tue, 26 Nov 2002 18:52:30 -0500
X-Originating-IP: [64.81.213.196]
From: "Dino Klein" <dinoklein@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: null TTY in tty_fasync (with 2.5.49)
Date: Tue, 26 Nov 2002 18:59:52 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <OE517yj47f51qEVADuD000102c2@hotmail.com>
X-OriginalArrivalTime: 26 Nov 2002 23:59:43.0286 (UTC) FILETIME=[E3BFA560:01C295A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recevied the following in my log, while I was running "make check" for
gcc. I was logged in to my machine through SSH. After the crash of xgcc (as
seen in the log), I was unable to log in to the machine, both localy or
remotely. I could open a TCP connection, but data transfer seemed to be
hung; I could also ping the machine and get replies.
I ended up pressing the reset button. If there is

The same thing happened with "make check" for binutils, only that it was
(88:00) instead. This time I was logged on the physical console. This time I
noticed the output, and stopped the check, so I won't end up rebooting the
machine.

If there is any more relevant information I can provide, please let me know.



Nov 26 08:47:39 gunther kernel: Warning: null TTY for (88:02) in tty_fasync
Nov 26 08:49:01 gunther last message repeated 20 times
Nov 26 08:51:08 gunther last message repeated 2 times
Nov 26 08:52:13 gunther last message repeated 20 times
Nov 26 08:54:40 gunther last message repeated 5 times
Nov 26 08:58:18 gunther last message repeated 4 times
Nov 26 08:59:19 gunther last message repeated 186 times
Nov 26 09:00:20 gunther last message repeated 119 times
Nov 26 09:02:48 gunther last message repeated 115 times
Nov 26 09:04:47 gunther kernel: Warning: null TTY for (88:02) in tty_fasync
Nov 26 09:05:53 gunther last message repeated 23 times
Nov 26 09:06:55 gunther last message repeated 106 times
Nov 26 09:07:58 gunther last message repeated 110 times
Nov 26 09:08:59 gunther last message repeated 127 times
Nov 26 09:10:00 gunther last message repeated 150 times
Nov 26 09:11:01 gunther last message repeated 57 times
Nov 26 09:12:02 gunther last message repeated 129 times
Nov 26 09:13:03 gunther last message repeated 139 times
Nov 26 09:13:26 gunther last message repeated 35 times
Nov 26 09:13:28 gunther kernel: Unable to handle kernel paging request at
virtual address 5a5a5ace
Nov 26 09:13:28 gunther kernel:  printing eip:
Nov 26 09:13:28 gunther kernel: c021a9f4
Nov 26 09:13:28 gunther kernel: *pde = 00000000
Nov 26 09:13:28 gunther kernel: Oops: 0000
Nov 26 09:13:28 gunther kernel: CPU:    0
Nov 26 09:13:28 gunther kernel: EIP:    0060:[check_tty_count+92/272]    Not
tainted
Nov 26 09:13:28 gunther kernel: EFLAGS: 00010207
Nov 26 09:13:28 gunther kernel: EIP is at check_tty_count+0x5c/0x110
Nov 26 09:13:28 gunther kernel: eax: 00000001   ebx: c0355174   ecx:
f71a7a04   edx: 5a5a5a5a
Nov 26 09:13:28 gunther kernel: esi: 00000000   edi: f71a7000   ebp:
00000001   esp: f7231f48
Nov 26 09:13:28 gunther kernel: ds: 0068   es: 0068   ss: 0068
Nov 26 09:13:28 gunther kernel: Process xgcc (pid: 10130,
threadinfo=f7230000 task=c3e779a0)
Nov 26 09:13:28 gunther kernel: Stack: f7230000 00000001 00000000 c021ae7a
f71a7000 c030f286 5a5a5a5a f71a7000
Nov 26 09:13:28 gunther kernel:        00000000 00000001 f71a7000 c3e779a0
00000000 00000000 c021b24a f71a7000
Nov 26 09:13:28 gunther kernel:        c021b2ee f71a7000 f7230000 f3bda884
c3e779a0 f7ffb194 c0120478 00000001
Nov 26 09:13:28 gunther kernel: Call Trace:
Nov 26 09:13:28 gunther kernel:  [do_tty_hangup+142/1092]
do_tty_hangup+0x8e/0x444
Nov 26 09:13:28 gunther kernel:  [tty_vhangup+10/16] tty_vhangup+0xa/0x10
Nov 26 09:13:28 gunther kernel:  [disassociate_ctty+138/616]
disassociate_ctty+0x8a/0x268
Nov 26 09:13:28 gunther kernel:  [do_exit+1356/1560] do_exit+0x54c/0x618
Nov 26 09:13:28 gunther kernel:  [sys_exit+14/16] sys_exit+0xe/0x10
Nov 26 09:13:28 gunther kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 26 09:13:28 gunther kernel:
Nov 26 09:13:28 gunther kernel: Code: 39 7a 74 0f 44 f0 8b 12 39 ca 75 f1 81
3d 78 51 35 c0 ad 4e
Nov 26 09:13:28 gunther kernel:  <6>note: xgcc[10130] exited with
preempt_count 2
