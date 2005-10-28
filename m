Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbVJ1HLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbVJ1HLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVJ1HLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:11:39 -0400
Received: from www.efkon.com ([81.223.206.242]:33160 "EHLO mail.efkon.com")
	by vger.kernel.org with ESMTP id S965108AbVJ1HLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:11:38 -0400
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops in gdth_get_info
From: Thomas Kemmer <tkemmer@computer.org>
Date: 28 Oct 2005 09:11:20 +0200
Message-ID: <m3vezi9kvb.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the following happened a few weeks ago and couldn't be reproduced
since then.  Kernel version is 2.6.6; customer is reluctant to upgrade
kernel unless we can assure that this has actually been fixed.

Kind regards
- Thomas

Oct 6 16:18:18 primary kernel: Adapter 0: Host Drive 0: resetted locally
Oct 6 16:18:28 primary kernel: Adapter 0: Host Drive 0: resetted locally
Oct 6 16:18:28 primary kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id -1 lun 0
Oct 6 16:18:28 primary kernel: scsi0 (-1:0): rejecting I/O to offline device
Oct 6 16:18:28 primary kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000138
Oct 6 16:18:28 primary kernel: printing eip:
Oct 6 16:18:28 primary kernel: c02b784a
Oct 6 16:18:28 primary kernel: *pde = 00000000
Oct 6 16:18:28 primary kernel: Oops: 0000 [#1]
Oct 6 16:18:28 primary kernel: PREEMPT SMP
Oct 6 16:18:28 primary kernel: CPU: 1
Oct 6 16:18:28 primary kernel: EIP: 0060:[gdth_get_info+5319/5778] Not tainted
Oct 6 16:18:28 primary kernel: EFLAGS: 00010282 (2.6.6)
Oct 6 16:18:28 primary kernel: EIP is at gdth_get_info+0x14c7/0x1692
Oct 6 16:18:28 primary kernel: eax: 00000000 ebx: c00981e4 ecx: f2e13188 edx: f369f400
Oct 6 16:18:28 primary kernel: esi: 000002d3 edi: f418be00 ebp: f4239f08 esp: f4239b3c
Oct 6 16:18:28 primary kernel: ds: 007b es: 007b ss: 0068
Oct 6 16:18:28 primary kernel: Process foobar (pid: 6063, threadinfo=f4238000 task=f41aa230)
Oct 6 16:18:28 primary kernel: Stack: f418be00 f4239dac f4239bbc 0000001e 00000000 f4239bcc 0000006d c035da3e
Oct 6 16:18:28 primary kernel: c00986ec 00000508 c0099d24 c0099a0c 00000c00 f7d8a400 00000000 f4239bb4
Oct 6 16:18:28 primary kernel: c035502f f7d8a000 f2e13000 f418be00 00000000 00000000 00000000 00000000
Oct 6 16:18:28 primary kernel: Call Trace:
Oct 6 16:18:28 primary kernel: [ip_local_deliver_finish+131/418] ip_local_deliver_finish+0x83/0x1a2
Oct 6 16:18:28 primary kernel: [nf_hook_slow+302/323] nf_hook_slow+0x12e/0x143
Oct 6 16:18:28 primary kernel: [ip_rcv_finish+433/647] ip_rcv_finish+0x1b1/0x287
Oct 6 16:18:28 primary kernel: [ip_rcv_finish+0/647] ip_rcv_finish+0x0/0x287
Oct 6 16:18:28 primary kernel: [nf_hook_slow+302/323] nf_hook_slow+0x12e/0x143
Oct 6 16:18:28 primary kernel: [ip_rcv_finish+0/647] ip_rcv_finish+0x0/0x287
Oct 6 16:18:28 primary kernel: [recalc_task_prio+347/460] recalc_task_prio+0x15b/0x1cc
Oct 6 16:18:28 primary kernel: [recalc_task_prio+225/460] recalc_task_prio+0xe1/0x1cc
Oct 6 16:18:28 primary kernel: [__wake_up_common+56/87] __wake_up_common+0x38/0x57
Oct 6 16:18:28 primary kernel: [unix_write_space+133/172] unix_write_space+0x85/0xac
Oct 6 16:18:28 primary kernel: [kfree_skbmem+35/41] kfree_skbmem+0x23/0x29
Oct 6 16:18:28 primary kernel: [do_page_cache_readahead+213/475] do_page_cache_readahead+0xd5/0x1db
Oct 6 16:18:28 primary kernel: [proc_alloc_inode+75/105] proc_alloc_inode+0x4b/0x69
Oct 6 16:18:28 primary kernel: [proc_alloc_inode+75/105] proc_alloc_inode+0x4b/0x69
Oct 6 16:18:28 primary kernel: [proc_scsi_read+55/73] proc_scsi_read+0x37/0x49
Oct 6 16:18:28 primary kernel: [proc_file_read+190/587] proc_file_read+0xbe/0x24b
Oct 6 16:18:28 primary kernel: [proc_file_read+0/587] proc_file_read+0x0/0x24b
Oct 6 16:18:28 primary kernel: [vfs_read+224/286] vfs_read+0xe0/0x11e
Oct 6 16:18:28 primary kernel: [sys_read+63/93] sys_read+0x3f/0x5d
Oct 6 16:18:28 primary kernel: [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Oct 6 16:18:28 primary kernel:
Oct 6 16:18:28 primary kernel: Code: 8b 80 38 01 00 00 83 f8 01 74 1a 0f b6 85 98 fc ff ff c6 43


# cat /proc/scsi/gdth/0
Driver Parameters:
 reserve_mode:  1               reserve_list:   --
 max_ids:       127             hdr_channel:    0

Disk Array Controller Information:
 Number:        0               Name:           GDT8114RZ
 Driver Ver.:   2.08            Firmware Ver.:  1.44.02-RC7B
 Serial No.:    0x39C0CBF1      Cache RAM size: 131072 KB

Physical Devices:
 Chn/ID/LUN:    B/00/0          Name:           MAXTOR  ATLAS10K4_36SCA DFV0
 Capacity [MB]: 35042           To Log. Drive:  0
 Retries:       0               Reassigns:      0
 Grown Defects: 30

 Chn/ID/LUN:    B/01/0          Name:           MAXTOR  ATLAS10K4_36SCA DFV0
 Capacity [MB]: 35042           To Log. Drive:  0
 Retries:       0               Reassigns:      0
 Grown Defects: 0

Logical Drives:
 Number:        0               Status:         ok
 Capacity [MB]: 34750           Type:           RAID-1
 Slave Number:  10              Status:         ok
 Missing Drv.:  0               Invalid Drv.:   0
 To Array Drv.: --

Array Drives:
 --

Host Drives:
 Number:        0               Arr/Log. Drive: 0
 Capacity [MB]: 34742           Start Sector:   0


