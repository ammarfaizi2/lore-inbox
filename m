Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUCXPyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUCXPyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:54:53 -0500
Received: from dns2.rocler.qc.ca ([204.101.179.31]:26579 "EHLO
	chekov.rocler.qc.ca") by vger.kernel.org with ESMTP id S263750AbUCXPyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:54:51 -0500
From: "M. de Bellefeuille" <mdb@rocler.com>
To: <linux-kernel@vger.kernel.org>
Cc: <rodrigue@rocler.com>
Subject: Journal_commit_transaction bugs
Date: Wed, 24 Mar 2004 10:54:48 -0500
Message-ID: <005a01c411b8$55ed82a0$7902a8c0@securebinary.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.24.0.7; VDF 6.24.0.69
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I've got this error on my webserver:

Mar 24 09:28:11 troi kernel: Assertion failure in
journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
Mar 24 09:28:11 troi kernel: ------------[ cut here ]------------
Mar 24 09:28:11 troi kernel: kernel BUG at commit.c:535!
Mar 24 09:28:11 troi kernel: invalid operand: 0000
Mar 24 09:28:11 troi kernel: binfmt_misc e1000 usb-ohci usbcore ext3 jbd
ips sd_mod scsi_mod
Mar 24 09:28:11 troi kernel: CPU:    3
Mar 24 09:28:11 troi kernel: EIP:    0010:[<f88400e4>]    Not tainted
Mar 24 09:28:11 troi kernel: EFLAGS: 00010286
Mar 24 09:28:11 troi kernel:
Mar 24 09:28:11 troi kernel: EIP is at journal_commit_transaction [jbd]
0xb04 (2.4.18-3smp)
Mar 24 09:28:11 troi kernel: eax: 0000001c   ebx: 0000000a   ecx:
c02eee60   edx: 0000476d
Mar 24 09:28:11 troi kernel: esi: ea8c6430   edi: f67c4440   ebp:
f75a8000   esp: f75a9e78
Mar 24 09:28:11 troi kernel: ds: 0018   es: 0018   ss: 0018
Mar 24 09:28:11 troi kernel: Process kjournald (pid: 191,
stackpage=f75a9000)
Mar 24 09:28:11 troi kernel: Stack: f8846eee 00000217 f6ca3020 00000000
00000f9c ec56f064 00000000 e2aa4460
Mar 24 09:28:11 troi kernel:        d8679190 00001e56 db9b33e0 00000001
f729f000 f729f1f0 ec5a9e40 ea32d8c0
Mar 24 09:28:11 troi kernel:        ea6173c0 ea32dce0 ea32d200 eca5b6c0
d90d61a0 d90d6ec0 ec3e43e0 ec3e4f80
Mar 24 09:28:11 troi kernel: Call Trace: [<f8846eee>] .rodata.str1.1
[jbd] 0x26e
Mar 24 09:28:11 troi kernel: [<c0124eb5>] update_process_times [kernel]
0x25
Mar 24 09:28:11 troi kernel: [<c0116049>] smp_apic_timer_interrupt
[kernel] 0xa9
Mar 24 09:28:11 troi kernel: [<c0119048>] schedule [kernel] 0x348
Mar 24 09:28:11 troi kernel: [<f88427d6>] kjournald [jbd] 0x136
Mar 24 09:28:11 troi kernel: [<f8842680>] commit_timeout [jbd] 0x0
Mar 24 09:28:11 troi kernel: [<c0107286>] kernel_thread [kernel] 0x26
Mar 24 09:28:11 troi kernel: [<f88426a0>] kjournald [jbd] 0x0


Some application wasn't working, and I was not able to reboot the server
normaly...I'm not the best one with this kind of problem, I'm not a
coder. That's why I'm mailling it.


Have a nice day


Regards,


Mathieu de Bellefeuille
Network administrator
Rocler inc. - www.rocler.com
mdb@rocler.com

