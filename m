Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755487AbWKPWrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbWKPWrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485AbWKPWrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:47:20 -0500
Received: from mx.laposte.net ([81.255.54.11]:45386 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1755482AbWKPWrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:47:19 -0500
Message-ID: <34862.81.64.156.37.1163717151.squirrel@rousalka.dyndns.org>
Date: Thu, 16 Nov 2006 23:45:51 +0100 (CET)
Subject: 2.6.19-rc5-mm2: WARNING at drivers/ata/sata_nv.c:762 
     nv_adma_bmdma_setup()
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: linux-ide@vger.kernel.org
Cc: hancockr@shaw.ca, linux-kernel@vger.kernel.org, akpm@osdl.org
User-Agent: SquirrelMail/1.4.8-2.fc6
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When booting a fresh 2.6.19-rc5-mm2, I get a lof of traces like this:


WARNING at drivers/ata/sata_nv.c:762 nv_adma_bmdma_setup()

Call Trace:
 [<ffffffff802614eb>] show_trace+0x34/0x47
 [<ffffffff80261510>] dump_stack+0x12/0x17
 [<ffffffff8806e48b>] :libata:ata_qc_issue_prot+0x1ec/0x24c
 [<ffffffff8806bc0e>] :libata:ata_qc_issue+0x400/0x45d
 [<ffffffff8807075e>] :libata:ata_scsi_translate+0xcf/0x118
 [<ffffffff8807177a>] :libata:ata_scsi_queuecmd+0x103/0x122
 [<ffffffff8037a6bd>] scsi_dispatch_cmd+0x22d/0x2c0
 [<ffffffff8037f7af>] scsi_request_fn+0x2c4/0x38f
 [<ffffffff803113bf>] blk_execute_rq_nowait+0x7a/0x8b
 [<ffffffff80311489>] blk_execute_rq+0xb9/0xe1
 [<ffffffff8037f376>] scsi_execute+0xca/0xe6
 [<ffffffff8037f44b>] scsi_execute_req+0xb9/0xde
 [<ffffffff80380778>] scsi_probe_and_add_lun+0x231/0xa39
 [<ffffffff80381af7>] __scsi_add_device+0x6c/0x97
 [<ffffffff88070150>] :libata:ata_scsi_scan_host+0x46/0x6f
 [<ffffffff8806ec34>] :libata:ata_device_add+0x420/0x4e8
 [<ffffffff88096b35>] :sata_nv:nv_init_one+0x2df/0x333
 [<ffffffff803251ca>] pci_device_probe+0x4c/0x75
 [<ffffffff8037524a>] really_probe+0x87/0x10c
 [<ffffffff803754a1>] __driver_attach+0x90/0xcd
 [<ffffffff8037476f>] bus_for_each_dev+0x43/0x6e
 [<ffffffff80374a65>] bus_add_driver+0x6b/0x18d
 [<ffffffff8032538d>] __pci_register_driver+0x85/0xba
 [<ffffffff8029232b>] sys_init_module+0x1733/0x18b2
 [<ffffffff8025511e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:

The optical drive on the nvidia sata controler is dead (there is also two
pata drives hanging there, but I don't use them with Linux)

Full dmesg, kernel config, etc available there:

http://bugzilla.kernel.org/show_bug.cgi?id=7538

Regards,

-- 
Nicolas Mailhot


