Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTDMLcl (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 07:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTDMLcl (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 07:32:41 -0400
Received: from smtp.hccnet.nl ([62.251.0.13]:15576 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S263467AbTDMLcg (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 07:32:36 -0400
Message-ID: <3E994DEE.5000009@hccnet.nl>
Date: Sun, 13 Apr 2003 13:45:50 +0200
From: Gert Vervoort <gert.vervoort@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67: ppa driver & preempt == oops
References: <3E982AAC.3060606@hccnet.nl> <20030412141248.47a487b0.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>This patch should make the warnings go away.
>  
>
The warnings are still there:

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
 [<c0240315>] ppa_queuecommand+0x95/0xa0
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


>I've been sitting on it for a while, waiting for someone to tell me if the
>ppa driver actually works.  Perhaps that person is you?
>
>  
>
When trying to mount a zip disk, the mount process gets stuck:

[root@viper root]# mount -t ext2 /dev/sda1 /mnt/zip
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: cache data unavailable
sda: assuming drive cache: write through
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
sda: cache data unavailable
sda: assuming drive cache: write through

At this point the mount process is unkillable.
Also strange is that the messages are printed twice.
   
   Gert




