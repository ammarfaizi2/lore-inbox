Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269227AbUJFMHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269227AbUJFMHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269231AbUJFMHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:07:30 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:57751 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S269227AbUJFMH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:07:27 -0400
Subject: 2.6.9-rc3-mm2-VP-T0: oprofile - using smp_processor_id() in
	preemptible code
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097064222.3172.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 14:03:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just making a note of some warnings. 
The running kernel is 
	2.6.9-rc3-mm2-VP-T0 
	+ a !4KSTACK build fix 
	+ Hugh Dickins's _raw_read_trylock fix
	+ Greg HK's pci_register_driver fix

Regards,

Peter Zijlstra

---- 

Oct  6 09:25:00 localhost kernel: using smp_processor_id() in preemptible code: modprobe/11004
Oct  6 09:25:00 localhost kernel:  [<c011bce4>] smp_processor_id+0x8f/0x95
Oct  6 09:25:00 localhost kernel:  [<f8d701a1>] nmi_init+0x12/0xd8 [oprofile]
Oct  6 09:25:00 localhost kernel:  [<f8d70095>] oprofile_arch_init+0x8/0x17 [oprofile]
Oct  6 09:25:00 localhost kernel:  [<f8d70011>] oprofile_init+0x11/0x6a [oprofile]
Oct  6 09:25:00 localhost kernel:  [<c0136dd5>] sys_init_module+0x1ae/0x275
Oct  6 09:25:00 localhost kernel:  [<c0103fc9>] sysenter_past_esp+0x52/0x71
Oct  6 09:25:00 localhost kernel: using smp_processor_id() in preemptible code: modprobe/11004
Oct  6 09:25:00 localhost kernel:  [<c011bce4>] smp_processor_id+0x8f/0x95
Oct  6 09:25:00 localhost kernel:  [<f8d701b0>] nmi_init+0x21/0xd8 [oprofile]
Oct  6 09:25:00 localhost kernel:  [<f8d70095>] oprofile_arch_init+0x8/0x17 [oprofile]
Oct  6 09:25:00 localhost kernel:  [<f8d70011>] oprofile_init+0x11/0x6a [oprofile]
Oct  6 09:25:00 localhost kernel:  [<c0136dd5>] sys_init_module+0x1ae/0x275
Oct  6 09:25:00 localhost kernel:  [<c0103fc9>] sysenter_past_esp+0x52/0x71
Oct  6 09:25:01 localhost kernel: using smp_processor_id() in preemptible code: modprobe/11004
Oct  6 09:25:01 localhost kernel:  [<c011bce4>] smp_processor_id+0x8f/0x95
Oct  6 09:25:01 localhost kernel:  [<f8d700c7>] p4_init+0x8/0x72 [oprofile]
Oct  6 09:25:01 localhost kernel:  [<f8d70255>] nmi_init+0xc6/0xd8 [oprofile]
Oct  6 09:25:01 localhost kernel:  [<f8d70095>] oprofile_arch_init+0x8/0x17 [oprofile]
Oct  6 09:25:01 localhost kernel:  [<f8d70011>] oprofile_init+0x11/0x6a [oprofile]
Oct  6 09:25:01 localhost kernel:  [<c0136dd5>] sys_init_module+0x1ae/0x275
Oct  6 09:25:01 localhost kernel:  [<c0103fc9>] sysenter_past_esp+0x52/0x71
Oct  6 09:25:01 localhost kernel: oprofile: using NMI interrupt.
Oct  6 09:45:24 localhost sshd(pam_unix)[13448]: session opened for user reinout by (uid=501)
Oct  6 09:45:35 localhost kernel: using smp_processor_id() in preemptible code: sleep/13533
Oct  6 09:45:35 localhost kernel:  [<c011bce4>] smp_processor_id+0x8f/0x95
Oct  6 09:45:35 localhost kernel:  [<f8da96a6>] task_exit_notify+0x5/0xd [oprofile]
Oct  6 09:45:35 localhost kernel:  [<c012c01e>] notifier_call_chain+0x17/0x2b
Oct  6 09:45:35 localhost kernel:  [<c0120902>] profile_task_exit+0x3e/0x5a
Oct  6 09:45:35 localhost kernel:  [<c01225b7>] do_exit+0x17/0x477
Oct  6 09:45:35 localhost kernel:  [<c01d5dd3>] copy_from_user+0x5e/0x8b
Oct  6 09:45:35 localhost kernel:  [<c0122ac0>] do_group_exit+0x3b/0xa4
Oct  6 09:45:35 localhost kernel:  [<c0103fc9>] sysenter_past_esp+0x52/0x71
Oct  6 09:45:35 localhost kernel: using smp_processor_id() in preemptible code: expr/13534
Oct  6 09:45:35 localhost kernel:  [<c011bce4>] smp_processor_id+0x8f/0x95
Oct  6 09:45:35 localhost kernel:  [<f8da96a6>] task_exit_notify+0x5/0xd [oprofile]
Oct  6 09:45:35 localhost kernel:  [<c012c01e>] notifier_call_chain+0x17/0x2b
Oct  6 09:45:35 localhost kernel:  [<c0120902>] profile_task_exit+0x3e/0x5a
Oct  6 09:45:35 localhost kernel:  [<c01225b7>] do_exit+0x17/0x477
Oct  6 09:45:35 localhost kernel:  [<c014e69c>] do_munmap+0x11c/0x15f
Oct  6 09:45:35 localhost kernel:  [<c0122ac0>] do_group_exit+0x3b/0xa4
Oct  6 09:45:35 localhost kernel:  [<c0103fc9>] sysenter_past_esp+0x52/0x71
Oct  6 09:45:35 localhost kernel: using smp_processor_id() in preemptible code: cat/13535
Oct  6 09:45:35 localhost kernel:  [<c011bce4>] smp_processor_id+0x8f/0x95
Oct  6 09:45:36 localhost kernel:  [<f8da96a6>] task_exit_notify+0x5/0xd [oprofile]
Oct  6 09:45:36 localhost kernel:  [<c012c01e>] notifier_call_chain+0x17/0x2b
Oct  6 09:45:36 localhost kernel:  [<c0120902>] profile_task_exit+0x3e/0x5a
Oct  6 09:45:36 localhost kernel:  [<c01225b7>] do_exit+0x17/0x477
Oct  6 09:45:36 localhost kernel:  [<c015a252>] __fput+0xeb/0x150
Oct  6 09:45:36 localhost kernel:  [<c0122ac0>] do_group_exit+0x3b/0xa4
Oct  6 09:45:36 localhost kernel:  [<c0103fc9>] sysenter_past_esp+0x52/0x71


