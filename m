Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSFENtB>; Wed, 5 Jun 2002 09:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSFENtB>; Wed, 5 Jun 2002 09:49:01 -0400
Received: from [168.210.128.30] ([168.210.128.30]:50957 "EHLO
	vodagpmail.vodacom.co.za") by vger.kernel.org with ESMTP
	id <S315424AbSFENs7>; Wed, 5 Jun 2002 09:48:59 -0400
Message-ID: <B9DBA43EAABED211BF140008C7FA5DF9015A9AD1@vodast.vodacom.co.za>
From: Jean Marais <jean.marais@vodacom.co.za>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Trying to vfree() nonexistent vm area (c38a5000) ....etc
Date: Wed, 5 Jun 2002 15:46:34 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

Just some info in case it helps. Not detailed, but I'm a busy guy... just in
case this helps.

This is with 2.4.18-3

I ran the Oracle installer and it failed for some reason. Nevermind - some
compat libs missing. It happened twice, that's mine to fix. When I exit it
it gives me the 
	Jun  5 09:05:55 rlpc kernel: Trying to vfree() nonexistent vm area
(c38a5000)
and a while later the rest. top doesn't work anymore after that and I
rebooted. The whole thing happened again.

I upgraded to 
	Jun  5 14:09:15 rlpc kernel: Linux version 2.4.18-4
(bhcompile@daffy.perf.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux
7.3 2.96-110)) #1 Thu May 2 18:10:25 EDT 2002
and then the only the
	Jun  5 15:39:36 rlpc kernel: Trying to vfree() nonexistent vm area
(c38a2000)
happened.

FUNNY CONFIGURATION ... MAYBE

	RAID0 OVER TWO IDE DISKS FOR SWAP + ANOTHER NORMAL SWAP ON 1 OF THE
DISKS


Jun  3 10:54:15 rlpc kernel: Linux version 2.4.18-3
(bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat
Linux 7.3 2.96-110)) #1 Thu Apr 18 07:31:07 EDT 2002
.
.
.

Jun  5 09:05:55 rlpc kernel: Trying to vfree() nonexistent vm area
(c38a5000)
Jun  5 09:12:58 rlpc login(pam_unix)[3492]: session opened for user oracle
by LOGIN(uid=0)
Jun  5 09:12:58 rlpc  -- oracle[3492]: LOGIN ON tty3 BY oracle
Jun  5 09:16:48 rlpc kernel: Unable to handle kernel paging request at
virtual address c38a5080
Jun  5 09:16:48 rlpc kernel:  printing eip:
Jun  5 09:16:48 rlpc kernel: c010c42d
Jun  5 09:16:48 rlpc kernel: *pde = 010b9067
Jun  5 09:16:48 rlpc kernel: *pte = 00000000
Jun  5 09:16:48 rlpc kernel: Oops: 0002
Jun  5 09:16:48 rlpc kernel: soundcore autofs ne 8390 ipchains ide-cd cdrom
usb-uhci usbcore ext3 jbd raid1
Jun  5 09:16:48 rlpc kernel: CPU:    0
Jun  5 09:16:48 rlpc kernel: EIP:    0010:[<c010c42d>]    Not tainted
Jun  5 09:16:48 rlpc kernel: EFLAGS: 00010202
Jun  5 09:16:48 rlpc kernel: 
Jun  5 09:16:48 rlpc kernel: EIP is at write_ldt [kernel] 0x201 (2.4.18-3)
Jun  5 09:16:48 rlpc kernel: eax: 00100000   ebx: 00000000   ecx: 00000001
edx: 0850f283
Jun  5 09:16:48 rlpc kernel: esi: f9d80004   edi: c38a5080   ebp: ffffffea
esp: c1f13f88
Jun  5 09:16:48 rlpc kernel: ds: 0018   es: 0018   ss: 0018
Jun  5 09:16:48 rlpc kernel: Process jre (pid: 3597, stackpage=c1f13000)
Jun  5 09:16:48 rlpc kernel: Stack: c1f66760 00000010 0883f9d8 00000004
00000041 bdbffaf4 00000010 bdbffb20 
Jun  5 09:16:48 rlpc kernel:        bdbffac8 c010c4a1 bdbffaf4 00000010
00000000 c1f12000 c01085f7 00000011 
Jun  5 09:16:48 rlpc kernel:        bdbffaf4 00000010 00000010 bdbffb20
bdbffac8 0000007b 0000002b 0000002b 
Jun  5 09:16:48 rlpc kernel: Call Trace: [<c010c4a1>] sys_modify_ldt
[kernel] 0x55 
Jun  5 09:16:48 rlpc kernel: [<c01085f7>] system_call [kernel] 0x33 
Jun  5 09:16:48 rlpc kernel: 
Jun  5 09:16:48 rlpc kernel: 
Jun  5 09:16:48 rlpc kernel: Code: 89 37 89 57 04 31 ed 8b 04 24 83 c0 1c e8
65 86 10 00 83 c4 
