Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTDLOt7 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 10:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263283AbTDLOt6 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 10:49:58 -0400
Received: from smtp.hccnet.nl ([62.251.0.13]:210 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S263279AbTDLOty (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 10:49:54 -0400
Message-ID: <3E982AAC.3060606@hccnet.nl>
Date: Sat, 12 Apr 2003 17:03:08 +0200
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.67: ppa driver & preempt == oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 16 bit
ppa: Communication established with ID 6 using EPP 16 bit
scsi0 : Iomega VPI0 (ppa) interface
bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cf5c>] scsi_probe_lun+0x6c/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cf5c>] scsi_probe_lun+0x6c/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cf5c>] scsi_probe_lun+0x6c/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cf5c>] scsi_probe_lun+0x6c/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cf5c>] scsi_probe_lun+0x6c/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cf5c>] scsi_probe_lun+0x6c/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cf5c>] scsi_probe_lun+0x6c/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023d074>] scsi_probe_lun+0x184/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

  Vendor: IOMEGA    Model: ZIP 100           Rev: D.13
  Type:   Direct-Access                      ANSI SCSI revision: 02
bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023c7ef>] scsi_get_evpd_page+0x7f/0x120
 [<c023ce2e>] scsi_load_identifier+0x2e/0xf0
 [<c023d248>] scsi_add_lun+0x158/0x220
 [<c023d3b9>] scsi_probe_and_add_lun+0xa9/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0128db4>] queue_work+0x84/0xa0
 [<c02402f5>] ppa_queuecommand+0x95/0xa0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023c002>] scsi_request_fn+0x172/0x230
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cc43>] scsi_get_serialnumber+0x93/0x1b0
 [<c023c852>] scsi_get_evpd_page+0xe2/0x120
 [<c023ceeb>] scsi_load_identifier+0xeb/0xf0
 [<c023d248>] scsi_add_lun+0x158/0x220
 [<c023d3b9>] scsi_probe_and_add_lun+0xa9/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

bad: scheduling while atomic!
Call Trace:
 [<c0117064>] schedule+0x3a4/0x3b0
 [<c0117349>] wait_for_completion+0x99/0xe0
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c01170c0>] default_wake_function+0x0/0x20
 [<c023b15e>] scsi_wait_req+0x7e/0xb0
 [<c023b050>] scsi_wait_done+0x0/0x90
 [<c023cf5c>] scsi_probe_lun+0x6c/0x200
 [<c023d38b>] scsi_probe_and_add_lun+0x7b/0x130
 [<c023d64c>] scsi_scan_target+0x5c/0x100
 [<c023d741>] scsi_scan_host+0x51/0x90
 [<c023798d>] scsi_add_host+0x4d/0x90
 [<c0237dac>] scsi_register_host+0x6c/0xc0
 [<c01295df>] init_workqueues+0xf/0x30
 [<c01050a3>] init+0x33/0x190
 [<c0105070>] init+0x0/0x190
 [<c01071dd>] kernel_thread_helper+0x5/0x18

error in initcall at 0xc0391ad0: returned with preemption imbalance
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0


