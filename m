Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUCFIXi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 03:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUCFIXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 03:23:38 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:60361 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261405AbUCFIXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 03:23:35 -0500
Message-ID: <40498A7F.5070306@uni-paderborn.de>
Date: Sat, 06 Mar 2004 09:23:27 +0100
From: Bjoern Schmidt <lucky21@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Badness in pci_find_subsys at drivers/pci/search.c:167
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=1.594,
	required 4, FROM_ENDS_IN_NUMS 0.87, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-UNI-PB_FAK-EIM-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a possibility to find out which device caused this error?
It's the first time that it has been arisen...
The kernels version is v2.6.3, do you need more "input"?

Mar  6 08:58:21 gigabyte kernel: Badness in pci_find_subsys at 
drivers/pci/search.c:167
Mar  6 08:58:21 gigabyte kernel: Call Trace:
Mar  6 08:58:21 gigabyte kernel: [<c02385c9>] pci_find_subsys+0xf9/0x110
Mar  6 08:58:21 gigabyte kernel: [<c0238611>] pci_find_device+0x31/0x40
Mar  6 08:58:21 gigabyte kernel: [<c02383e9>] pci_find_slot+0x29/0x50
Mar  6 08:58:21 gigabyte kernel: [<c046220d>] os_pci_init_handle+0x39/0x68
Mar  6 08:58:21 gigabyte kernel: [<c02f6f5f>] _nv001243rm+0x1f/0x24
Mar  6 08:58:21 gigabyte kernel: [<c043d815>] _nv000816rm+0x2f5/0x384
Mar  6 08:58:21 gigabyte kernel: [<c03a602c>] _nv003801rm+0xd8/0x100
Mar  6 08:58:21 gigabyte kernel: [<c043d34f>] _nv000809rm+0x2f/0x34
Mar  6 08:58:21 gigabyte kernel: [<c03a6e50>] _nv003816rm+0xf0/0x104
Mar  6 08:58:21 gigabyte kernel: [<c03a570e>] _nv003795rm+0x6ea/0xaec
Mar  6 08:58:21 gigabyte kernel: [<c030f967>] _nv004046rm+0x3a3/0x3b0
Mar  6 08:58:21 gigabyte kernel: [<c04112a7>] _nv001476rm+0x277/0x45c
Mar  6 08:58:21 gigabyte kernel: [<c02f9a9a>] _nv000896rm+0x4a/0x64
Mar  6 08:58:21 gigabyte kernel: [<c02fb2b4>] rm_isr_bh+0xc/0x10
Mar  6 08:58:21 gigabyte kernel: [<c04601bd>] nv_kern_isr_bh+0xf/0x13
Mar  6 08:58:21 gigabyte kernel: [<c01245e6>] tasklet_action+0x46/0x70
Mar  6 08:58:21 gigabyte kernel: [<c01243f5>] do_softirq+0x95/0xa0
Mar  6 08:58:21 gigabyte kernel: [<c010bb0b>] do_IRQ+0xfb/0x130
Mar  6 08:58:21 gigabyte kernel: [<c0109de0>] common_interrupt+0x18/0x20
Mar  6 08:58:21 gigabyte kernel: [<c011428a>] speedstep_set_state+0xfa/0x160
Mar  6 08:58:21 gigabyte kernel: [<c0114514>] speedstep_target+0x54/0x60
Mar  6 08:58:21 gigabyte kernel: [<c04979a2>] __cpufreq_driver_target+0x22/0x30
Mar  6 08:58:21 gigabyte kernel: [<c0498418>] cpufreq_governor_performance+0x38/0x40
Mar  6 08:58:21 gigabyte kernel: [<c0497a92>] __cpufreq_governor+0x62/0x120
Mar  6 08:58:21 gigabyte kernel: [<c0497e73>] __cpufreq_set_policy+0x113/0x180
Mar  6 08:58:21 gigabyte kernel: [<c0497f2b>] cpufreq_set_policy+0x4b/0x90
Mar  6 08:58:21 gigabyte kernel: [<c0497234>] store_scaling_governor+0xa4/0xc0
Mar  6 08:58:21 gigabyte kernel: [<c04973fd>] store+0x5d/0x70
Mar  6 08:58:21 gigabyte kernel: [<c018b45b>] flush_write_buffer+0x3b/0x50
Mar  6 08:58:21 gigabyte kernel: [<c018b4d0>] sysfs_write_file+0x60/0x70
Mar  6 08:58:21 gigabyte kernel: [<c0153c98>] vfs_write+0xb8/0x130
Mar  6 08:58:21 gigabyte kernel: [<c0153dc2>] sys_write+0x42/0x70
Mar  6 08:58:21 gigabyte kernel: [<c01093fb>] syscall_call+0x7/0xb
Mar  6 08:58:21 gigabyte kernel:
Mar  6 08:58:21 gigabyte kernel: Badness in pci_find_subsys at 
drivers/pci/search.c:167
Mar  6 08:58:21 gigabyte kernel: Call Trace:
Mar  6 08:58:21 gigabyte kernel: [<c02385c9>] pci_find_subsys+0xf9/0x110
Mar  6 08:58:21 gigabyte kernel: [<c0238611>] pci_find_device+0x31/0x40
Mar  6 08:58:21 gigabyte kernel: [<c02383e9>] pci_find_slot+0x29/0x50
Mar  6 08:58:21 gigabyte kernel: [<c046220d>] os_pci_init_handle+0x39/0x68
Mar  6 08:58:21 gigabyte kernel: [<c02f6f5f>] _nv001243rm+0x1f/0x24
Mar  6 08:58:21 gigabyte kernel: [<c03a815d>] _nv003797rm+0xa9/0x128
Mar  6 08:58:21 gigabyte kernel: [<c0414ba1>] _nv001490rm+0x55/0xe4
Mar  6 08:58:21 gigabyte kernel: [<c043d854>] _nv000816rm+0x334/0x384
Mar  6 08:58:21 gigabyte kernel: [<c03a602c>] _nv003801rm+0xd8/0x100
Mar  6 08:58:21 gigabyte kernel: [<c043d34f>] _nv000809rm+0x2f/0x34
Mar  6 08:58:21 gigabyte kernel: [<c03a6e50>] _nv003816rm+0xf0/0x104
Mar  6 08:58:21 gigabyte kernel: [<c03a570e>] _nv003795rm+0x6ea/0xaec
Mar  6 08:58:21 gigabyte kernel: [<c030f967>] _nv004046rm+0x3a3/0x3b0
Mar  6 08:58:21 gigabyte kernel: [<c04112a7>] _nv001476rm+0x277/0x45c
Mar  6 08:58:21 gigabyte kernel: [<c02f9a9a>] _nv000896rm+0x4a/0x64
Mar  6 08:58:21 gigabyte kernel: [<c02fb2b4>] rm_isr_bh+0xc/0x10
Mar  6 08:58:21 gigabyte kernel: [<c04601bd>] nv_kern_isr_bh+0xf/0x13
Mar  6 08:58:21 gigabyte kernel: [<c01245e6>] tasklet_action+0x46/0x70
Mar  6 08:58:21 gigabyte kernel: [<c01243f5>] do_softirq+0x95/0xa0
Mar  6 08:58:21 gigabyte kernel: [<c010bb0b>] do_IRQ+0xfb/0x130
Mar  6 08:58:21 gigabyte kernel: [<c0109de0>] common_interrupt+0x18/0x20
Mar  6 08:58:21 gigabyte kernel: [<c011428a>] speedstep_set_state+0xfa/0x160
Mar  6 08:58:21 gigabyte kernel: [<c0114514>] speedstep_target+0x54/0x60
Mar  6 08:58:21 gigabyte kernel: [<c04979a2>] __cpufreq_driver_target+0x22/0x30
Mar  6 08:58:21 gigabyte kernel: [<c0498418>] cpufreq_governor_performance+0x38/0x40
Mar  6 08:58:21 gigabyte kernel: [<c0497a92>] __cpufreq_governor+0x62/0x120
Mar  6 08:58:21 gigabyte kernel: [<c0497e73>] __cpufreq_set_policy+0x113/0x180
Mar  6 08:58:21 gigabyte kernel: [<c0497f2b>] cpufreq_set_policy+0x4b/0x90
Mar  6 08:58:21 gigabyte kernel: [<c0497234>] store_scaling_governor+0xa4/0xc0
Mar  6 08:58:21 gigabyte kernel: [<c04973fd>] store+0x5d/0x70
Mar  6 08:58:21 gigabyte kernel: [<c018b45b>] flush_write_buffer+0x3b/0x50
Mar  6 08:58:21 gigabyte kernel: [<c018b4d0>] sysfs_write_file+0x60/0x70
Mar  6 08:58:21 gigabyte kernel: [<c0153c98>] vfs_write+0xb8/0x130
Mar  6 08:58:21 gigabyte kernel: [<c0153dc2>] sys_write+0x42/0x70
Mar  6 08:58:21 gigabyte kernel: [<c01093fb>] syscall_call+0x7/0xb

-- 
Greetings
Bjoern Schmidt


