Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTDRRGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbTDRRGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:06:16 -0400
Received: from web41813.mail.yahoo.com ([66.218.93.147]:23144 "HELO
	web41813.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263161AbTDRRGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:06:14 -0400
Message-ID: <20030418171806.2042.qmail@web41813.mail.yahoo.com>
Date: Fri, 18 Apr 2003 10:18:06 -0700 (PDT)
From: Christian Staudenmayer <eggdropfan@yahoo.com>
Subject: kernel panic with 2.5.67-ac1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i recently compiled 2.5.67-ac1 on my machine which uses the
aic7xxx driver for an old adaptec 2940 scsi controller.
When booting, the kernel panics after loading the scsi driver
with the following message:

Process swapper (pid: 1, threadinfo=dbf8e000 task=dbf8c040)
Stack: c15259a8 c15259a8 00000001 00000002 dbf8fe48 c022cd1a c15259a8 000000ff
       dbf8fe3c dbf8fe40
Call Trace:
 [<c022cd1a>] ide_xlate_1024+0x106/0x18c
 [<c01654aa>] handle_ide_mess+0x14e/0x1e8
 [<c016557f>] msdos_partition+0x3b/0x3ec
 [<c01171fa>] release_console_sem+0x32/0x94
 [<c0117165>] printk+0xfd/0x114
 [<c016491d>] check_partition+0xa1/0xec
 [<c0164c13>] register_disk+0xa7/0x144
 [<c0164c28>] register_disk+0xbc/0x144
 [<c0218301>] add_disk+0x35/0x44
 [<c021829c>] exact_match+0x0/0xc
 [<c02182a8>] exact_lock+0x0/0x24
 [<c0273589>] sd_attach+0x1d/0x244
 [<c023d9c0>] scsi_register_device+0xb8/0xe4
 [<c010502c>] init+0x0/0x144
 [<c0105049>] init+0x1d/0x144
 [<c010502c>] init+0x0/0x144
 [<c01079c1>] kernel_thread_helper+0x5/0xc

Code: 8b 40 38 be 93 74 31 c0 ff d0 89 c1 c7 03 3f 00 00 00 85 ff
 <0>Kernel panic: Attempted to kill init!

Note: this does not happen with 2.4.20, 2.4.21-pre7, 2.4.21-pre7-ac1 or 2.5.67-bk8
It does, however happen with 2.5.67-ac2, but the error message is some lines longer
and some of the addresses have changed.

I'd be really grateful for any insight on this problem.

Greetings, Chris


__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
