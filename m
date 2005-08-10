Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVHJNkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVHJNkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbVHJNkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:40:11 -0400
Received: from dvhart.com ([64.146.134.43]:7810 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965091AbVHJNkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:40:10 -0400
Date: Wed, 10 Aug 2005 06:40:03 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: sharyathi@in.ibm.com
Subject: [Bug 5041] New: Encountered this kernel Panic on system	boot up
Message-ID: <579120000.1123681203@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=5041

           Summary: Encountered this kernel Panic on system boot up
    Kernel Version: 2.6.13-rc5-mm1
            Status: NEW
          Severity: high
             Owner: akpm@osdl.org
         Submitter: sharyathi@in.ibm.com
                CC: bnpoorni@in.ibm.com,sglass@us.ibm.com


Distribution:
SLES 9 SP1
----------------------------------
Hardware Environment:
2 way, Intel(R) XEON(TM) CPU 2.00GHz, 4 GB RAM
Network driver Broadcom Corporation NetXtreme BCM5703X Gigabit Ethernet
SCSi Driver:
SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual
Ultra320 )
----------------------------------
Software Environment:
Linux Kernel: 2.6.13-rc5 + 2.6.13-rc5-mm1 
----------------------------------
Problem Description:

On building kernel 2.6.13-rc5-mm1 with the existing config file[worked with
earlier kernels]. Encountered this Kernel Panic with the message " Unable to
handle kernel paging request at virtual address 00000010.

I will attachi the Serial Console and Config file please have a look


[    8.872741] Unable to handle kernel NULL pointer dereference at virtual address 00000010
[    8.899431]  printing eip:
[    8.908347] c01a8535
[    8.915547] *pde = 00000000
[    8.924738] Oops: 0000 [#1]
[    8.933911] PREEMPT SMP DEBUG_PAGEALLOC
[    8.946604] last sysfs file:
[    8.956373] Modules linked in:
[    8.966446] CPU:    0
[    8.966448] EIP:    0060:[<c01a8535>]    Not tainted VLI
[    8.966449] EFLAGS: 00010282   (2.6.13-rc5-mm1-I)
[    9.007175] EIP is at create_dir+0x15/0x1f0
[    9.020929] eax: 00000000   ebx: c7177e1c   ecx: 00000000   edx: c7177e1c
[    9.043266] esi: c7177e18   edi: c716dc94   ebp: c71a1cc8   esp: c71a1ca8
[    9.065595] ds: 007b   es: 007b   ss: 0068
[    9.079068] Process swapper (pid: 1, threadinfo=c71a0000 task=c719f7b0)
[    9.100245] Stack: c71a1cc0 00000000 007f0800 00000001 00000002 c7177e18 c7177e18 c716dc94
[    9.127940]        c71a1ce8 c01a8778 c7177e18 00000000 c7177e1c c71a1ce0 00000000 00000000
[    9.155647]        c71a1cfc c0246daf c7177e18 c7177e18 c7177e1c c71a1d14 c024702d c7177e18
[    9.183353] Call Trace:
[    9.191992]  [<c01040db>] show_stack+0xab/0xc0
[    9.206683]  [<c0104276>] show_registers+0x166/0x1e0
[    9.223044]  [<c01044b2>] die+0x122/0x1c0
[    9.236286]  [<c0425ecc>] do_page_fault+0x3dc/0x61d
[    9.252386]  [<c0103d5b>] error_code+0x4f/0x54
[    9.267055]  [<c01a8778>] sysfs_create_dir+0x38/0x80
[    9.283415]  [<c0246daf>] create_dir+0x1f/0x50
[    9.298085]  [<c024702d>] kobject_add+0x9d/0xe0
[    9.313042]  [<c02c3c84>] device_add+0xa4/0x160
[    9.327997]  [<c0314519>] scsi_sysfs_add_sdev+0x49/0x1b0
[    9.345501]  [<c03127ab>] scsi_add_lun+0x32b/0x3c0
[    9.361314]  [<c0312928>] scsi_probe_and_add_lun+0xe8/0x1c0
[    9.379698]  [<c0313189>] scsi_scan_target+0xd9/0x160
[    9.396368]  [<c0313272>] scsi_scan_channel+0x62/0xb0
[    9.413039]  [<c031335f>] scsi_scan_host_selected+0x9f/0xf0
[    9.431424]  [<c03133e2>] scsi_scan_host+0x32/0x40
[    9.447236]  [<c0366b0c>] mptspi_probe+0x38c/0x420
[    9.463050]  [<c02512b9>] pci_call_probe+0x19/0x20
[    9.478865]  [<c0251319>] __pci_device_probe+0x59/0x70
[    9.495819]  [<c025135f>] pci_device_probe+0x2f/0x60
[    9.512204]  [<c02c5439>] driver_probe_device+0x39/0xc0
[    9.529447]  [<c02c5595>] __driver_attach+0x45/0x50
[    9.545547]  [<c02c49d4>] bus_for_each_dev+0x54/0x80
[    9.561931]  [<c02c55c7>] driver_attach+0x27/0x30
[    9.577459]  [<c02c4f35>] bus_add_driver+0x85/0xf0
[    9.593273]  [<c02c59ee>] driver_register+0x3e/0x50
[    9.609372]  [<c0251622>] pci_register_driver+0x82/0xa0
[    9.626613]  [<c0556bba>] mptspi_init+0xaa/0xb0
[    9.641568]  [<c053aaa6>] do_initcalls+0x26/0xc0
[    9.656812]  [<c053ab65>] do_basic_setup+0x25/0x30
[    9.672624]  [<c01003ba>] init+0x8a/0x220
[    9.685892]  [<c01012a9>] kernel_thread_helper+0x5/0xc
[    9.702822] ---------------------------
[    9.715424] | preempt count: 00000001 ]
[    9.728044] | 1 level deep critical section nesting:
[    9.744378] ----------------------------------------
[    9.760737] .. [<c0424f59>] .... _spin_lock_irqsave+0x19/0xa0
[    9.779662] .....[<c01043d3>] ..   ( <= die+0x43/0x1c0)
[    9.796875]
[    9.801783] Code: 08 89 88 a4 00 00 00 31 c0 5d c3 8d 74 26 00 8d bc 27 00 00 00 00 55 89 e5 83 ec 2
[    9.865530]  <0>Kernel panic - not syncing: Attempted to kill init!
[    9.886257]


