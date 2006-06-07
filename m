Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWFGWbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWFGWbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWFGWbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:31:35 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:34277 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932445AbWFGWbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:31:34 -0400
Message-ID: <039101c68a82$1ac6b710$1800a8c0@dcccs>
From: "Janos Haar" <djani22@netcenter.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Assertion failed! qc != NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Date: Thu, 8 Jun 2006 00:31:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I found this:

Assertion failed! qc !=
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
^Unable to handle kernel NULL pointer dereference at 00000000000000d0 RIP:
^<ffffffff80395a9b>{ata_pio_task+1484}
^PGD 7b0c0067 PUD 7a182067 PMD 0
^Oops: 0002 [1] SMP
^CPU 0
^Modules linked in: netconsole video
^Pid: 928, comm: ata/0 Not tainted 2.6.16.18-bitmapxif #3
^RIP: 0010:[<ffffffff80395a9b>] <ffffffff80395a9b>{ata_pio_task+1484}
^RSP: 0018:ffff81007f4dfdf8  EFLAGS: 00010293
^RAX: 000000010037df48 RBX: 0000000000000004 RCX: ffffffff80574c88
^RDX: ffffffff80574c88 RSI: 0000000000000292 RDI: ffff81007f8bb4b0
^RBP: 0000000000000002 R08: ffffffff80574c88 R09: ffff81007faf0d80
^R10: ffff81007f065500 R11: 0000000000000000 R12: ffff81007f8bb4b0
^R13: 0000000000000000 R14: ffff81007f8bb4b0 R15: ffffffff803954cf
^FS:  0000000000000000(0000) GS:ffffffff80710000(0000)
knlGS:0000000000000000
^CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
^CR2: 00000000000000d0 CR3: 000000007b0dc000 CR4: 00000000000006e0
^Process ata/0 (pid: 928, threadinfo ffff81007f4de000, task
ffff81007f44b180)
^Stack: 00000000006a6c16 00000000801237fa ffff81007f7b7790 ffff81007f8bbb60
^       ffff81007f8bbb68 ffff81007f7b7768 0000000000000296 ffff81007f8bb4b0
^       ffffffff803954cf ffffffff801380a2
^Call Trace: <ffffffff803954cf>{ata_pio_task+0}
<ffffffff801380a2>{run_workqueue+153}
^       <ffffffff801385a5>{worker_thread+0}
<ffffffff8013afde>{keventd_create_kthread+0}
^       <ffffffff801386ae>{worker_thread+265}
<ffffffff80121dab>{__wake_up_common+62}
^       <ffffffff801231b6>{default_wake_function+0}
<ffffffff8013afde>{keventd_create_kthread+0}
^       <ffffffff8013afde>{keventd_create_kthread+0}
<ffffffff8013b2aa>{kthread+212}
^       <ffffffff8010ba12>{child_rip+8}
<ffffffff8013afde>{keventd_create_kthread+0}
^       <ffffffff8013b1d6>{kthread+0} <ffffffff8010ba0a>{child_rip+0}
^
^Code: 41 83 8d d0 00 00 00 04 41 c7 84 24 10 07 00 00 03 00 00 00
^RIP <ffffffff80395a9b>{ata_pio_task+1484} RSP <ffff81007f4dfdf8>
^CR2: 00000000000000d0
^ <3>ata3: command timeout
^ATA: abnormal status 0xFF on port 0xFFFFC2000000821C
^ata3: translated ATA stat/err 0xff/00 to SCSI SK/ASC/ASCQ 0xb/47/00
^ata3: status=0xff { Busy }
^sd 2:0:0:0: SCSI error: return code = 0x8000002
^sde: Current: sense key=0xb
^    ASC=0x47 ASCQ=0x0
^end_request: I/O error, dev sde, sector 0
^printk: 7 messages suppressed.
^Buffer I/O error on device sde, logical block 0
^ata3: command timeout


The full log is here:

http://download.netcenter.hu/bughunt/20060607/st3.slog


Cheers,
Janos

