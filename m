Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132622AbQLJCFG>; Sat, 9 Dec 2000 21:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132657AbQLJCE4>; Sat, 9 Dec 2000 21:04:56 -0500
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:33828 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S132622AbQLJCEm>; Sat, 9 Dec 2000 21:04:42 -0500
Message-ID: <3A32DCC1.EB8C6778@hadess.net>
Date: Sun, 10 Dec 2000 01:30:41 +0000
From: Bastien Nocera <hadess@hadess.net>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0-test11 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in the ov511 driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried mailing Mark McClelland about this, but his e-mail bounces. I
just had a oops in the ov511 driver (webcam) while trying to run my
(dodgy and broken) code for a Gnome webcam software.

I run kernel 2.4.0-test11 from Paulus' pmac tree, and the ov511 driver
version 1.28
The code is at
http://hadess.net/files/vanity-0.0-oops-not-for-use.tar.gz

Here is the kernel log:
Dec 10 01:10:47 kara kernel: Oops: kernel access of bad area, sig: 11
Dec 10 01:10:47 kara kernel: NIP: C001148C XER: 00000000 LR: C986F41C
SP: C3AADC90 REGS: c3aadbe0 TRAP: 0300
Dec 10 01:10:47 kara kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1
IR/DR: 11
Dec 10 01:10:47 kara kernel: DAR: 00000000, DSISR: 42000000
Dec 10 01:10:47 kara kernel: TASK = c3aac000[316] 'vanity' Last syscall:
54 
Dec 10 01:10:47 kara kernel: last math c3aac000 last altivec 00000000
Dec 10 01:10:47 kara kernel: GPR00: 00000001 C3AADC90 C3AAC000 00000024
C3AADC94 0000001C FFFFFFFC 00000001 
Dec 10 01:10:47 kara kernel: GPR08: 00000078 00000001 000000A0 00000004
02000000 1001C6C8 00000000 100C8230 
Dec 10 01:10:47 kara kernel: GPR16: 00000000 7FFFFB38 00000000 00000000
00009032 03AADE80 00000000 C0004CA4 
Dec 10 01:10:47 kara kernel: GPR24: C00049D4 10003C04 3002676C 00000005
C3AADC98 403C7601 C6343000 00000000 
Dec 10 01:10:47 kara kernel: Call backtrace: 
Dec 10 01:10:47 kara kernel: C7281D80 C98682E4 C0049A54 C0004A30
3000BC54 10003308 10002EC8 
Dec 10 01:10:47 kara kernel: 10001B34 0F76175C 00000000 

Cheers

PS: Please CC me, as I'm not subscribed to the ML, thanks
-- 
/Bastien Nocera
http://hadess.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
