Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUJLRGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUJLRGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUJLRGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:06:16 -0400
Received: from mail3.utc.com ([192.249.46.192]:4326 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S266233AbUJLRAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:00:42 -0400
Message-ID: <416C0D00.3040805@cybsft.com>
Date: Tue, 12 Oct 2004 11:57:36 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <416BF44E.6080309@cybsft.com> <20041012152713.GA16393@elte.hu>
In-Reply-To: <20041012152713.GA16393@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090309040202010504090401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090309040202010504090401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>OK. This one builds just fine here. Again I tried booting preempt
>>realtime. We were going along fine and then all hell broke loose on
>>the console. Pressed Ctrl-s to stop the scrolling and it then bit the
>>dust.  It did manage to get into the logs this time and I am attaching
>>that.  This is a different SMP system that I use as a workstation at a
>>client site. Dual 2.6GHz Xeons (with HT) 512MB
> 
> 
> does the patch below make your system bootable? It should fix the two
> most common messages you got.
> 
> 	Ingo
No. Attached log from this boot. Also worth noting: I have no keyboard 
while trying to boot this. This doesn't really surprise me, but I am 
seeing hit or miss on the keyboard (more times than not the keyboard is 
dead) with the T3 patch also. Doesn't seem to be an issue on my 933 SMP 
system at home. Is this a regression? Ideas?

kr

--------------090309040202010504090401
Content-Type: text/plain;
 name="rtpreT7.dump2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtpreT7.dump2"

Oct 12 11:46:34 swdev14 syslogd 1.4.1: restart.
Oct 12 11:46:34 swdev14 syslog: syslogd startup succeeded
Oct 12 11:46:34 swdev14 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 12 11:46:34 swdev14 syslog: klogd startup succeeded
Oct 12 11:46:34 swdev14 kernel: 26/0x83>
Oct 12 11:46:34 swdev14 kernel:  => ended at:   <cond_resched+0x26/0x83>
Oct 12 11:46:34 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:34 swdev14 kernel:  [<c013484c>] check_preempt_timing+0x161/0x1f9
Oct 12 11:46:34 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:34 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:34 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:34 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:34 swdev14 kernel:  [<c0133816>] _mutex_lock+0x19/0x3f
Oct 12 11:46:34 swdev14 kernel:  [<c0133878>] _mutex_lock_irqsave+0x16/0x1c
Oct 12 11:46:34 swdev14 kernel:  [<c01cbe88>] tty_register_ldisc+0x37/0xa4
Oct 12 11:46:34 swdev14 kernel:  [<c036be3e>] console_init+0x27/0x4a
Oct 12 11:46:34 swdev14 kernel:  [<c035487a>] start_kernel+0xd7/0x1c6
Oct 12 11:46:34 swdev14 kernel:  [<c03543b0>] unknown_bootoption+0x0/0x15d
Oct 12 11:46:34 swdev14 irqbalance: irqbalance startup succeeded
Oct 12 11:46:34 swdev14 kernel: Console: colour VGA+ 80x25
Oct 12 11:46:34 swdev14 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Oct 12 11:46:34 swdev14 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct 12 11:46:34 swdev14 kernel: Memory: 513500k/523712k available (1645k kernel code, 9608k reserved, 726k data, 272k init, 0k highmem)
Oct 12 11:46:34 swdev14 kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct 12 11:46:34 swdev14 kernel: Security Scaffold v1.0.0 initialized
Oct 12 11:46:34 swdev14 kernel: Capability LSM initialized
Oct 12 11:46:34 swdev14 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct 12 11:46:34 swdev14 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Oct 12 11:46:34 swdev14 portmap: portmap startup succeeded
Oct 12 11:46:34 swdev14 kernel: CPU: L2 cache: 512K
Oct 12 11:46:34 swdev14 kernel: CPU: Physical Processor ID: 0
Oct 12 11:46:34 swdev14 kernel: Intel machine check architecture supported.
Oct 12 11:46:34 swdev14 kernel: Intel machine check reporting enabled on CPU#0.
Oct 12 11:46:34 swdev14 kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 12 11:46:34 swdev14 kernel: Enabling fast FPU save and restore... done.
Oct 12 11:46:34 swdev14 kernel: Enabling unmasked SIMD FPU exception support... done.
Oct 12 11:46:34 swdev14 kernel: Checking 'hlt' instruction... OK.
Oct 12 11:46:34 swdev14 kernel: CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Oct 12 11:46:34 swdev14 kernel: per-CPU timeslice cutoff: 1462.71 usecs.
Oct 12 11:46:34 swdev14 kernel: task migration cache decay timeout: 2 msecs.
Oct 12 11:46:34 swdev14 kernel: Booting processor 1/1 eip 2000
Oct 12 11:46:34 swdev14 kernel: Initializing CPU#1
Oct 12 11:46:34 swdev14 rpc.statd[2649]: Version 1.0.6 Starting
Oct 12 11:46:34 swdev14 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Oct 12 11:46:34 swdev14 kernel: CPU: L2 cache: 512K
Oct 12 11:46:34 swdev14 nfslock: rpc.statd startup succeeded
Oct 12 11:46:34 swdev14 kernel: CPU: Physical Processor ID: 0
Oct 12 11:46:34 swdev14 kernel: Intel machine check architecture supported.
Oct 12 11:46:34 swdev14 kernel: Intel machine check reporting enabled on CPU#1.
Oct 12 11:46:34 swdev14 kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 12 11:46:34 swdev14 kernel: CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Oct 12 11:46:34 swdev14 kernel: Booting processor 2/6 eip 2000
Oct 12 11:46:34 swdev14 kernel: Initializing CPU#2
Oct 12 11:46:34 swdev14 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Oct 12 11:46:34 swdev14 kernel: CPU: L2 cache: 512K
Oct 12 11:46:34 swdev14 kernel: CPU: Physical Processor ID: 3
Oct 12 11:46:35 swdev14 kernel: Intel machine check architecture supported.
Oct 12 11:46:35 swdev14 kernel: Intel machine check reporting enabled on CPU#2.
Oct 12 11:46:35 swdev14 kernel: CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 12 11:46:35 swdev14 kernel: CPU2: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Oct 12 11:46:35 swdev14 kernel: Booting processor 3/7 eip 2000
Oct 12 11:46:35 swdev14 kernel: Initializing CPU#3
Oct 12 11:46:35 swdev14 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Oct 12 11:46:35 swdev14 rpcidmapd: rpc.idmapd startup succeeded
Oct 12 11:46:35 swdev14 kernel: CPU: L2 cache: 512K
Oct 12 11:46:35 swdev14 kernel: CPU: Physical Processor ID: 3
Oct 12 11:46:35 swdev14 kernel: Intel machine check architecture supported.
Oct 12 11:46:35 swdev14 kernel: Intel machine check reporting enabled on CPU#3.
Oct 12 11:46:35 swdev14 kernel: CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
Oct 12 11:46:35 swdev14 kernel: CPU3: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Oct 12 11:46:35 swdev14 kernel: Total of 4 processors activated (20611.07 BogoMIPS).
Oct 12 11:46:35 swdev14 kernel: checking TSC synchronization across 4 CPUs: passed.
Oct 12 11:46:35 swdev14 kernel: ksoftirqd started up.
Oct 12 11:46:35 swdev14 last message repeated 2 times
Oct 12 11:46:35 swdev14 kernel: Brought up 4 CPUs
Oct 12 11:46:35 swdev14 random: Initializing random number generator:  succeeded
Oct 12 11:46:35 swdev14 kernel: ksoftirqd started up.
Oct 12 11:46:35 swdev14 rc: Starting pcmcia:  succeeded
Oct 12 11:46:35 swdev14 kernel: checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Oct 12 11:46:35 swdev14 kernel: Freeing initrd memory: 207k freed
Oct 12 11:46:35 swdev14 kernel: NET: Registered protocol family 16
Oct 12 11:46:35 swdev14 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd915, last bus=5
Oct 12 11:46:35 swdev14 kernel: PCI: Using configuration type 1
Oct 12 11:46:35 swdev14 kernel: mtrr: v2.0 (20020519)
Oct 12 11:46:35 swdev14 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Oct 12 11:46:35 swdev14 kernel: PCI: Probing PCI hardware
Oct 12 11:46:35 swdev14 kernel: PCI: Probing PCI hardware (bus 00)
Oct 12 11:46:35 swdev14 kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Oct 12 11:46:35 swdev14 kernel: PCI: Transparent bridge - 0000:00:1e.0
Oct 12 11:46:35 swdev14 kernel: Simple Boot Flag at 0x36 set to 0x1
Oct 12 11:46:35 swdev14 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Oct 12 11:46:35 swdev14 kernel: apm: disabled - APM is not SMP safe.
Oct 12 11:46:35 swdev14 kernel: VFS: Disk quotas dquot_6.5.1
Oct 12 11:46:35 swdev14 kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Oct 12 11:46:35 swdev14 kernel: Initializing Cryptographic API
Oct 12 11:46:35 swdev14 kernel: vesafb: probe of vesafb0 failed with error -6
Oct 12 11:46:35 swdev14 kernel: isapnp: Scanning for PnP cards...
Oct 12 11:46:35 swdev14 kernel: isapnp: No Plug & Play device found
Oct 12 11:46:35 swdev14 kernel: scheduling while atomic: swapper/0x04000001/1
Oct 12 11:46:35 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:35 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:35 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:35 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:35 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:36 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:36 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:36 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:36 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:36 swdev14 kernel:  [<c0133b82>] _rw_mutex_read_lock+0x24/0x39
Oct 12 11:46:36 swdev14 kernel:  [<c011f62c>] profile_handoff_task+0x1a/0x52
Oct 12 11:46:36 swdev14 netfs: Mounting NFS filesystems:  succeeded
Oct 12 11:46:36 swdev14 kernel:  [<c011c508>] __put_task_struct+0x66/0x119
Oct 12 11:46:36 swdev14 kernel:  [<c0298a0b>] schedule+0x35f/0xbe2
Oct 12 11:46:36 swdev14 kernel:  [<c029a392>] _spin_unlock_irq+0x1b/0x35
Oct 12 11:46:36 swdev14 netfs: Mounting other filesystems:  succeeded
Oct 12 11:46:36 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:36 swdev14 kernel:  [<c0134ae5>] sub_preempt_count+0x82/0x97
Oct 12 11:46:36 swdev14 kernel:  [<c029a392>] _spin_unlock_irq+0x1b/0x35
Oct 12 11:46:36 swdev14 kernel:  [<c029938c>] wait_for_completion+0x84/0xe3
Oct 12 11:46:36 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:36 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:36 swdev14 kernel:  [<c012eab2>] queue_work+0x72/0xa0
Oct 12 11:46:36 swdev14 kernel:  [<c012e9cd>] call_usermodehelper+0xc7/0xce
Oct 12 11:46:36 swdev14 kernel:  [<c012e89d>] __call_usermodehelper+0x0/0x69
Oct 12 11:46:36 swdev14 kernel:  [<c01e54d5>] class_hotplug+0x0/0x44
Oct 12 11:46:36 swdev14 kernel:  [<c01aeeb4>] kobject_hotplug+0x27e/0x2e2
Oct 12 11:46:36 swdev14 kernel:  [<c01ae0f0>] create_dir+0x3e/0x4e
Oct 12 11:46:36 swdev14 autofs: automount startup succeeded
Oct 12 11:46:36 swdev14 kernel:  [<c01ae34e>] kobject_add+0x8c/0xfa
Oct 12 11:46:36 swdev14 kernel:  [<c01e56b7>] class_device_add+0x8d/0x15e
Oct 12 11:46:36 swdev14 kernel:  [<c01e5d0b>] class_simple_device_add+0xa3/0x104
Oct 12 11:46:36 swdev14 kernel:  [<c01cfb4d>] tty_register_device+0x73/0xdd
Oct 12 11:46:36 swdev14 kernel:  [<c01e64a8>] kobj_map+0xa0/0x136
Oct 12 11:46:36 swdev14 kernel:  [<c0164ba4>] cdev_add+0x4b/0x4f
Oct 12 11:46:36 swdev14 kernel:  [<c01cfe6a>] tty_register_driver+0x14c/0x243
Oct 12 11:46:36 swdev14 smartd[2807]: smartd version 5.21 Copyright (C) 2002-3 Bruce Allen 
Oct 12 11:46:36 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 11:46:36 swdev14 smartd[2807]: Home page is http://smartmontools.sourceforge.net/  
Oct 12 11:46:36 swdev14 kernel:  [<c036c34d>] legacy_pty_init+0x28a/0x2c8
Oct 12 11:46:36 swdev14 smartd[2807]: Opened configuration file /etc/smartd.conf 
Oct 12 11:46:36 swdev14 kernel:  [<c036c657>] pty_init+0xd/0x16
Oct 12 11:46:36 swdev14 smartd[2807]: Configuration file /etc/smartd.conf parsed. 
Oct 12 11:46:36 swdev14 kernel:  [<c03549b2>] do_initcalls+0x30/0xbd
Oct 12 11:46:36 swdev14 smartd[2807]: Device: /dev/hda, opened 
Oct 12 11:46:36 swdev14 kernel:  [<c0100541>] init+0x87/0x19a
Oct 12 11:46:36 swdev14 kernel:  [<c01004ba>] init+0x0/0x19a
Oct 12 11:46:36 swdev14 smartd[2807]: Device: /dev/hda, not found in smartd database. 
Oct 12 11:46:36 swdev14 kernel:  [<c01042c9>] kernel_thread_helper+0x5/0xb
Oct 12 11:46:36 swdev14 smartd[2807]: Device: /dev/hda, is SMART capable. Adding to "monitor" list. 
Oct 12 11:46:36 swdev14 kernel: scheduling while atomic: swapper/0x04000001/1
Oct 12 11:46:36 swdev14 smartd[2807]: Monitoring 1 ATA and 0 SCSI devices 
Oct 12 11:46:36 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:37 swdev14 smartd[2809]: smartd has fork()ed into background mode. New PID=2809. 
Oct 12 11:46:37 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:37 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:37 swdev14 smartd: smartd startup succeeded
Oct 12 11:46:37 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:37 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:37 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:37 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:37 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:37 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:37 swdev14 kernel:  [<c0133b82>] _rw_mutex_read_lock+0x24/0x39
Oct 12 11:46:37 swdev14 kernel:  [<c011f62c>] profile_handoff_task+0x1a/0x52
Oct 12 11:46:37 swdev14 kernel:  [<c011c508>] __put_task_struct+0x66/0x119
Oct 12 11:46:37 swdev14 kernel:  [<c0298a0b>] schedule+0x35f/0xbe2
Oct 12 11:46:37 swdev14 kernel:  [<c029a392>] _spin_unlock_irq+0x1b/0x35
Oct 12 11:46:37 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:37 swdev14 sshd:  succeeded
Oct 12 11:46:37 swdev14 kernel:  [<c0134ae5>] sub_preempt_count+0x82/0x97
Oct 12 11:46:37 swdev14 kernel:  [<c029a392>] _spin_unlock_irq+0x1b/0x35
Oct 12 11:46:37 swdev14 kernel:  [<c029938c>] wait_for_completion+0x84/0xe3
Oct 12 11:46:37 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:37 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:37 swdev14 kernel:  [<c012eab2>] queue_work+0x72/0xa0
Oct 12 11:46:37 swdev14 kernel:  [<c012e9cd>] call_usermodehelper+0xc7/0xce
Oct 12 11:46:37 swdev14 kernel:  [<c012e89d>] __call_usermodehelper+0x0/0x69
Oct 12 11:46:37 swdev14 kernel:  [<c01e54d5>] class_hotplug+0x0/0x44
Oct 12 11:46:37 swdev14 kernel:  [<c01aeeb4>.20
Oct 12 11:46:37 swdev14 xinetd: xinetd startup succeeded
Oct 12 11:46:37 swdev14 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct 12 11:46:37 swdev14 kernel: NET: Registered protocol family 10
Oct 12 11:46:37 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:37 swdev14 kernel: caller is raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:37 swdev14 ntpdate[2873]: can't find host wizard 
Oct 12 11:46:37 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:37 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:37 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:37 swdev14 kernel:  [<e0b1d282>] inet6_create+0x26f/0x315 [ipv6]
Oct 12 11:46:37 swdev14 kernel:  [<c02284aa>] __sock_create+0xd5/0x19d
Oct 12 11:46:37 swdev14 kernel:  [<c02285dc>] sock_create_kern+0x33/0x37
Oct 12 11:46:37 swdev14 kernel:  [<e09bc824>] icmpv6_init+0xc4/0x110 [ipv6]
Oct 12 11:46:37 swdev14 kernel:  [<e09bc14b>] inet6_init+0xb9/0x20c [ipv6]
Oct 12 11:46:37 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:37 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc856>] icmpv6_init+0xf6/0x110 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc14b>] inet6_init+0xb9/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b1d282>] inet6_create+0x26f/0x315 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c02284aa>] __sock_create+0xd5/0x19d
Oct 12 11:46:38 swdev14 kernel:  [<c02285dc>] sock_create_kern+0x33/0x37
Oct 12 11:46:38 swdev14 kernel:  [<e09bc824>] icmpv6_init+0xc4/0x110 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc14b>] inet6_init+0xb9/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc856>] icmpv6_init+0xf6/0x110 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc14b>] inet6_init+0xb9/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b1d282>] inet6_create+0x26f/0x315 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c02284aa>] __sock_create+0xd5/0x19d
Oct 12 11:46:38 swdev14 kernel:  [<c02285dc>] sock_create_kern+0x33/0x37
Oct 12 11:46:38 swdev14 kernel:  [<e09bc824>] icmpv6_init+0xc4/0x110 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc14b>] inet6_init+0xb9/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc856>] icmpv6_init+0xf6/0x110 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc14b>] inet6_init+0xb9/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b1d282>] inet6_create+0x26f/0x315 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c02284aa>] __sock_create+0xd5/0x19d
Oct 12 11:46:38 swdev14 kernel:  [<c02285dc>] sock_create_kern+0x33/0x37
Oct 12 11:46:38 swdev14 kernel:  [<e09bc824>] icmpv6_init+0xc4/0x110 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc14b>] inet6_init+0xb9/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc856>] icmpv6_init+0xf6/0x110 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc14b>] inet6_init+0xb9/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32f56>] raw_v6_hash+0x62/0x85 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b1d282>] inet6_create+0x26f/0x315 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c02284aa>] __sock_create+0xd5/0x19d
Oct 12 11:46:38 swdev14 kernel:  [<c02285dc>] sock_create_kern+0x33/0x37
Oct 12 11:46:38 swdev14 kernel:  [<e09bc60d>] ndisc_init+0x32/0xe9 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc161>] inet6_init+0xcf/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: using smp_processor_id() in preemptible [00000001] code: modprobe/2819
Oct 12 11:46:38 swdev14 kernel: caller is raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c011a2aa>] smp_processor_id+0xa8/0xb9
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e0b32fda>] raw_v6_unhash+0x61/0xad [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc646>] ndisc_init+0x6b/0xe9 [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<e09bc161>] inet6_init+0xcf/0x20c [ipv6]
Oct 12 11:46:38 swdev14 kernel:  [<c0138c03>] sys_init_module+0x15c/0x1ce
Oct 12 11:46:38 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:38 swdev14 kernel: IPv6 over IPv4 tunneling driver
Oct 12 11:46:38 swdev14 kernel: ------------[ cut here ]------------
Oct 12 11:46:38 swdev14 kernel: kernel BUG at kernel/mutex.c:185!
Oct 12 11:46:38 swdev14 kernel: invalid operand: 0000 [#1]
Oct 12 11:46:38 swdev14 kernel: PREEMPT SMP 
Oct 12 11:46:38 swdev14 kernel: Modules linked in: ipv6 autofs4 nfs lockd sunrpc iptable_filter ip_tables ide_cd cdrom 3c59x mii tg3 floppy sg scsi_mod parport_pc parport microcode dm_mod evdev usbhid uhci_hcd usbcore ext3 jbd
Oct 12 11:46:38 swdev14 kernel: CPU:    2
Oct 12 11:46:38 swdev14 kernel: EIP:    0060:[<c0133bbc>]    Not tainted VLI
Oct 12 11:46:38 swdev14 kernel: EFLAGS: 00010246   (2.6.9-rc4-mm1-VP-T7) 
Oct 12 11:46:38 swdev14 kernel: EIP is at _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:38 swdev14 kernel: eax: 00000000   ebx: 00000000   ecx: c0350e00   edx: c1466b80
Oct 12 11:46:38 swdev14 kernel: esi: ddef3ac8   edi: dd878814   ebp: de5d7f18   esp: de5d7f18
Oct 12 11:46:38 swdev14 kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Oct 12 11:46:38 swdev14 kernel: Process sshd (pid: 2849, threadinfo=de5d6000 task=de4a7a80)
Oct 12 11:46:38 swdev14 kernel: Stack: de5d7f44 c02537ec c0350e00 00000016 c029a3c6 dfe12a80 ddef3c94 ddef3bfc 
Oct 12 11:46:38 swdev14 kernel:        dfe12a80 ddef3a80 ffffffea de5d7f5c c0275b18 ddef3a80 00000005 dfe12a80 
Oct 12 11:46:38 swdev14 kernel:        00000003 de5d7f78 c022889e dfe12a80 00000005 00000000 00000004 08090bf0 
Oct 12 11:46:38 swdev14 kernel: Call Trace:
Oct 12 11:46:38 swdev14 kernel:  [<c02537ec>] tcp_listen_start+0x175/0x1d1
Oct 12 11:46:38 swdev14 kernel:  [<c029a3c6>] _spin_unlock_bh+0x1a/0x34
Oct 12 11:46:38 swdev14 kernel:  [<c0275b18>] inet_listen+0x65/0x7a
Oct 12 11:46:39 swdev14 kernel:  [<c022889e>] sys_listen+0x5c/0x74
Oct 12 11:46:39 swdev14 kernel:  [<c0229558>] sys_socketcall+0xb1/0x239
Oct 12 11:46:39 swdev14 kernel:  [<c015aeb9>] sys_close+0x75/0x91
Oct 12 11:46:39 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:39 swdev14 kernel: Code: 75 fc 89 ec 5d c3 55 89 e5 e8 21 fb fd ff 8b 4d 08 8b 01 85 c0 74 14 8d 41 04 ba ff ff 00 00 f0 0f c1 10 0f 85 6e 03 00 00 5d c3 <0f> 0b b9 00 1a c7 2a c0 eb e2 55 89 e5 e8 f2 fa fd ff 8b 4d 08 
Oct 12 11:46:39 swdev14 kernel:  <3>scheduling while atomic: sshd/0x04000001/2849
Oct 12 11:46:39 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:39 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:39 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c011f5d4>] profile_task_exit+0x18/0x56
Oct 12 11:46:39 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 11:46:39 swdev14 kernel:  [<c01216f8>] do_exit+0x1f/0x3bd
Oct 12 11:46:39 swdev14 kernel:  [<c029929f>] preempt_schedule+0x11/0x7a
Oct 12 11:46:39 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 11:46:39 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 11:46:39 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 11:46:39 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 11:46:39 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:39 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:39 swdev14 kernel:  [<c029a1aa>] _write_lock+0x1b/0x76
Oct 12 11:46:39 swdev14 kernel:  [<c0264422>] tcp_listen_wlock+0x16/0xac
Oct 12 11:46:39 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 11:46:39 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 11:46:39 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:39 swdev14 kernel:  [<c02537ec>] tcp_listen_start+0x175/0x1d1
Oct 12 11:46:39 swdev14 kernel:  [<c029a3c6>] _spin_unlock_bh+0x1a/0x34
Oct 12 11:46:39 swdev14 kernel:  [<c0275b18>] inet_listen+0x65/0x7a
Oct 12 11:46:39 swdev14 kernel:  [<c022889e>] sys_listen+0x5c/0x74
Oct 12 11:46:39 swdev14 kernel:  [<c0229558>] sys_socketcall+0xb1/0x239
Oct 12 11:46:39 swdev14 kernel:  [<c015aeb9>] sys_close+0x75/0x91
Oct 12 11:46:39 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:39 swdev14 kernel: note: sshd[2849] exited with preempt_count 1
Oct 12 11:46:39 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2849
Oct 12 11:46:39 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:39 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:39 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c014b81d>] unmap_vmas+0x190/0x29b
Oct 12 11:46:39 swdev14 kernel:  [<c015006f>] exit_mmap+0xb2/0x1cc
Oct 12 11:46:39 swdev14 kernel:  [<c011c979>] mmput+0x3b/0xb9
Oct 12 11:46:39 swdev14 kernel:  [<c0121807>] do_exit+0x12e/0x3bd
Oct 12 11:46:39 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 11:46:39 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 11:46:39 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 11:46:39 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 11:46:39 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:39 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:39 swdev14 kernel:  [<c029a1aa>] _write_lock+0x1b/0x76
Oct 12 11:46:39 swdev14 kernel:  [<c0264422>] tcp_listen_wlock+0x16/0xac
Oct 12 11:46:39 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 11:46:39 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 11:46:39 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:39 swdev14 kernel:  [<c02537ec>] tcp_listen_start+0x175/0x1d1
Oct 12 11:46:39 swdev14 kernel:  [<c029a3c6>] _spin_unlock_bh+0x1a/0x34
Oct 12 11:46:39 swdev14 kernel:  [<c0275b18>] inet_listen+0x65/0x7a
Oct 12 11:46:39 swdev14 kernel:  [<c022889e>] sys_listen+0x5c/0x74
Oct 12 11:46:39 swdev14 kernel:  [<c0229558>] sys_socketcall+0xb1/0x239
Oct 12 11:46:39 swdev14 kernel:  [<c015aeb9>] sys_close+0x75/0x91
Oct 12 11:46:39 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:39 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2849
Oct 12 11:46:39 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:39 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:39 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c0133816>] _mutex_lock+0x19/0x3f
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c014dff0>] remove_vm_struct+0x34/0x9f
Oct 12 11:46:39 swdev14 kernel:  [<c015012f>] exit_mmap+0x172/0x1cc
Oct 12 11:46:39 swdev14 kernel:  [<c011c979>] mmput+0x3b/0xb9
Oct 12 11:46:39 swdev14 kernel:  [<c0121807>] do_exit+0x12e/0x3bd
Oct 12 11:46:39 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 11:46:39 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 11:46:39 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 11:46:39 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 11:46:39 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:39 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:39 swdev14 kernel:  [<c029a1aa>] _write_lock+0x1b/0x76
Oct 12 11:46:39 swdev14 kernel:  [<c0264422>] tcp_listen_wlock+0x16/0xac
Oct 12 11:46:39 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 11:46:39 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 11:46:39 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:39 swdev14 kernel:  [<c02537ec>] tcp_listen_start+0x175/0x1d1
Oct 12 11:46:39 swdev14 kernel:  [<c029a3c6>] _spin_unlock_bh+0x1a/0x34
Oct 12 11:46:39 swdev14 kernel:  [<c0275b18>] inet_listen+0x65/0x7a
Oct 12 11:46:39 swdev14 kernel:  [<c022889e>] sys_listen+0x5c/0x74
Oct 12 11:46:39 swdev14 kernel:  [<c0229558>] sys_socketcall+0xb1/0x239
Oct 12 11:46:39 swdev14 kernel:  [<c015aeb9>] sys_close+0x75/0x91
Oct 12 11:46:39 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:39 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2849
Oct 12 11:46:39 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:39 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:39 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:39 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:39 swdev14 kernel:  [<c0133816>] _mutex_lock+0x19/0x3f
Oct 12 11:46:39 swdev14 kernel:  [<c015197a>] anon_vma_unlink+0x23/0x90
Oct 12 11:46:39 swdev14 kernel:  [<c015c50e>] fput+0xe/0x1f
Oct 12 11:46:39 swdev14 kernel:  [<c014e032>] remove_vm_struct+0x76/0x9f
Oct 12 11:46:39 swdev14 kernel:  [<c015012f>] exit_mmap+0x172/0x1cc
Oct 12 11:46:39 swdev14 kernel:  [<c011c979>] mmput+0x3b/0xb9
Oct 12 11:46:39 swdev14 kernel:  [<c0121807>] do_exit+0x12e/0x3bd
Oct 12 11:46:39 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 11:46:39 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 11:46:39 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 11:46:40 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 11:46:40 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:40 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:40 swdev14 kernel:  [<c029a1aa>] _write_lock+0x1b/0x76
Oct 12 11:46:40 swdev14 kernel:  [<c0264422>] tcp_listen_wlock+0x16/0xac
Oct 12 11:46:40 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 11:46:40 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 11:46:40 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:40 swdev14 kernel:  [<c02537ec>] tcp_listen_start+0x175/0x1d1
Oct 12 11:46:40 swdev14 kernel:  [<c029a3c6>] _spin_unlock_bh+0x1a/0x34
Oct 12 11:46:40 swdev14 kernel:  [<c0275b18>] inet_listen+0x65/0x7a
Oct 12 11:46:40 swdev14 kernel:  [<c022889e>] sys_listen+0x5c/0x74
Oct 12 11:46:40 swdev14 kernel:  [<c0229558>] sys_socketcall+0xb1/0x239
Oct 12 11:46:40 swdev14 kernel:  [<c015aeb9>] sys_close+0x75/0x91
Oct 12 11:46:40 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:40 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2849
Oct 12 11:46:40 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:40 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:40 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:40 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:40 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c014dfdb>] remove_vm_struct+0x1f/0x9f
Oct 12 11:46:40 swdev14 kernel:  [<c015012f>] exit_mmap+0x172/0x1cc
Oct 12 11:46:40 swdev14 kernel:  [<c011c979>] mmput+0x3b/0xb9
Oct 12 11:46:40 swdev14 kernel:  [<c0121807>] do_exit+0x12e/0x3bd
Oct 12 11:46:40 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 11:46:40 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 11:46:40 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 11:46:40 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 11:46:40 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:40 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:40 swdev14 kernel:  [<c029a1aa>] _write_lock+0x1b/0x76
Oct 12 11:46:40 swdev14 kernel:  [<c0264422>] tcp_listen_wlock+0x16/0xac
Oct 12 11:46:40 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 11:46:40 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 11:46:40 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:40 swdev14 kernel:  [<c02537ec>] tcp_listen_start+0x175/0x1d1
Oct 12 11:46:40 swdev14 kernel:  [<c029a3c6>] _spin_unlock_bh+0x1a/0x34
Oct 12 11:46:40 swdev14 kernel:  [<c0275b18>] inet_listen+0x65/0x7a
Oct 12 11:46:40 swdev14 kernel:  [<c022889e>] sys_listen+0x5c/0x74
Oct 12 11:46:40 swdev14 kernel:  [<c0229558>] sys_socketcall+0xb1/0x239
Oct 12 11:46:40 swdev14 kernel:  [<c015aeb9>] sys_close+0x75/0x91
Oct 12 11:46:40 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:40 swdev14 kernel: scheduling while atomic: sshd/0x04000001/2849
Oct 12 11:46:40 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:40 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:40 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:40 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:40 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:40 swdev14 kernel:  [<c014dfdb>] remove_vm_struct+0x1f/0x9f
Oct 12 11:46:40 swdev14 kernel:  [<c015012f>] exit_mmap+0x172/0x1cc
Oct 12 11:46:40 swdev14 kernel:  [<c011c979>] mmput+0x3b/0xb9
Oct 12 11:46:40 swdev14 kernel:  [<c0121807>] do_exit+0x12e/0x3bd
Oct 12 11:46:40 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 11:46:40 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 11:46:40 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 11:46:40 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 11:46:40 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:40 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:40 swdev14 kernel:  [<c029a1aa>] _write_lock+0x1b/0x76
Oct 12 11:46:40 swdev14 kernel:  [<c0264422>] tcp_listen_wlock+0x16/0xac
Oct 12 11:46:40 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 11:46:40 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 11:46:40 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:40 swdev14 kernel:  [<c02537ec>] tcp_listen_start+0x175/0x1d1
Oct 12 11:46:40 swdev14 kernel:  [<c029a3c6>] _spin_unlock_bh+0x1a/0x34
Oct 12 11:46:40 swdev14 kernel:  [<c0275b18>] inet_listen+0x65/0x7a
Oct 12 11:46:40 swdev14 kernel:  [<c022889e>] sys_listen+0x5c/0x74
Oct 12 11:46:40 swdev14 kernel:  [<c0229558>] sys_socketcall+0xb1/0x239
Oct 12 11:46:40 swdev14 kernel:  [<c015aeb9>] sys_close+0x75/0x91
Oct 12 11:46:40 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:40 swdev14 kernel: scheduling while atomic: sshd/0x00000001/2849
Oct 12 11:46:40 swdev14 kernel: caller is __down+0x8a/0x107
Oct 12 11:46:40 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:40 swdev14 kernel:  [<c029848a>] __down+0x8a/0x107
Oct 12 11:46:40 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:40 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:40 swdev14 kernel:  [<c029a34c>] _spin_unlock_irqrestore+0xb/0x36
Oct 12 11:46:40 swdev14 kernel:  [<c0298485>] __down+0x85/0x107
Oct 12 11:46:40 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 11:46:40 swdev14 kernel:  [<c029848a>] __down+0x8a/0x107
Oct 12 11:46:40 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:40 swdev14 kernel:  [<c0298650>] __down_failed+0x8/0xc
Oct 12 11:46:40 swdev14 kernel:  [<c011c3d8>] .text.lock.sched+0x5/0x15
Oct 12 11:46:40 swdev14 kernel:  [<c01ccbc1>] disassociate_ctty+0x1d/0x16d
Oct 12 11:46:40 swdev14 kernel:  [<c01218f1>] do_exit+0x218/0x3bd
Oct 12 11:46:40 swdev14 kernel:  [<c0107780>] do_invalid_op+0x0/0x10b
Oct 12 11:46:40 swdev14 kernel:  [<c01073e2>] do_divide_error+0x0/0x131
Oct 12 11:46:40 swdev14 kernel:  [<c0117898>] fixup_exception+0x1c/0x38
Oct 12 11:46:40 swdev14 kernel:  [<c0107889>] do_invalid_op+0x109/0x10b
Oct 12 11:46:40 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:40 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:40 swdev14 kernel:  [<c029a1aa>] _write_lock+0x1b/0x76
Oct 12 11:46:40 swdev14 kernel:  [<c0264422>] tcp_listen_wlock+0x16/0xac
Oct 12 11:46:40 swdev14 kernel:  [<c0106c31>] error_code+0x2d/0x38
Oct 12 11:46:40 swdev14 kernel:  [<c011007b>] generic_set_mtrr+0x68/0x9c
Oct 12 11:46:40 swdev14 kernel:  [<c0133bbc>] _rw_mutex_write_unlock+0x25/0x2f
Oct 12 11:46:40 swdev14 kernel:  [<c02537ec>] tcp_listen_start+0x175/0x1d1
Oct 12 11:46:40 swdev14 kernel:  [<c029a3c6>] _spin_unlock_bh+0x1a/0x34
Oct 12 11:46:40 swdev14 kernel:  [<c0275b18>] inet_listen+0x65/0x7a
Oct 12 11:46:40 swdev14 kernel:  [<c022889e>] sys_listen+0x5c/0x74
Oct 12 11:46:40 swdev14 kernel:  [<c0229558>] sys_socketcall+0xb1/0x239
Oct 12 11:46:40 swdev14 kernel:  [<c015aeb9>] sys_close+0x75/0x91
Oct 12 11:46:40 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:46 swdev14 ntpdate[2873]: step time server 159.82.80.104 offset -0.498445 sec
Oct 12 11:46:46 swdev14 ntpd:  succeeded
Oct 12 11:46:46 swdev14 ntpd[2877]: ntpd 4.2.0@1.1161-r Thu Mar 11 11:46:39 EST 2004 (1)
Oct 12 11:46:46 swdev14 ntpd: ntpd startup succeeded
Oct 12 11:46:46 swdev14 ntpd[2877]: precision = 1.000 usec
Oct 12 11:46:46 swdev14 ntpd[2877]: kernel time sync status 0040
Oct 12 11:46:46 swdev14 ntpd[2877]: configure: keyword "opus" unknown, line ignored
Oct 12 11:46:46 swdev14 ntpd[2877]: configure: keyword "hal" unknown, line ignored
Oct 12 11:46:46 swdev14 ntpd[2877]: configure: keyword "wizard" unknown, line ignored
Oct 12 11:46:46 swdev14 ntpd[2877]: configure: keyword "time1.utc.com" unknown, line ignored
Oct 12 11:46:46 swdev14 ntpd[2877]: configure: keyword "time2.utc.com" unknown, line ignored
Oct 12 11:46:46 swdev14 ntpd[2877]: configure: keyword "time3.utc.com" unknown, line ignored
Oct 12 11:46:46 swdev14 vsftpd: vsftpd vsftpd succeeded
Oct 12 11:46:46 swdev14 ntpd[2877]: frequency initialized 124.193 PPM from /var/lib/ntp/drift
Oct 12 11:46:46 swdev14 ntpd[2877]: configure: keyword "authenticate" unknown, line ignored
Oct 12 11:46:46 swdev14 gpm[2896]: *** info [startup.c(95)]: 
Oct 12 11:46:46 swdev14 gpm[2896]: Started gpm successfully. Entered daemon mode.
Oct 12 11:46:46 swdev14 gpm[2896]: *** info [mice.c(1766)]: 
Oct 12 11:46:46 swdev14 gpm[2896]: imps2: Auto-detected intellimouse PS/2
Oct 12 11:46:47 swdev14 gpm: gpm startup succeeded
Oct 12 11:46:47 swdev14 crond: crond startup succeeded
Oct 12 11:46:49 swdev14 kernel: lp0: using parport0 (polling).
Oct 12 11:46:49 swdev14 kernel: lp0: console ready
Oct 12 11:46:49 swdev14 kernel: scheduling while atomic: serial/0x04000001/2947
Oct 12 11:46:49 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:49 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:49 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:49 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:49 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:49 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:49 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:49 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:49 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:49 swdev14 kernel:  [<c0133b82>] _rw_mutex_read_lock+0x24/0x39
Oct 12 11:46:49 swdev14 kernel:  [<c011f62c>] profile_handoff_task+0x1a/0x52
Oct 12 11:46:49 swdev14 kernel:  [<c011c508>] __put_task_struct+0x66/0x119
Oct 12 11:46:49 swdev14 kernel:  [<c0298a0b>] schedule+0x35f/0xbe2
Oct 12 11:46:49 swdev14 kernel:  [<c029a392>] _spin_unlock_irq+0x1b/0x35
Oct 12 11:46:49 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:49 swdev14 kernel:  [<c0134ae5>] sub_preempt_count+0x82/0x97
Oct 12 11:46:49 swdev14 kernel:  [<c029a392>] _spin_unlock_irq+0x1b/0x35
Oct 12 11:46:49 swdev14 kernel:  [<c029938c>] wait_for_completion+0x84/0xe3
Oct 12 11:46:49 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:49 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:49 swdev14 kernel:  [<c012ead4>] queue_work+0x94/0xa0
Oct 12 11:46:49 swdev14 kernel:  [<c012e9cd>] call_usermodehelper+0xc7/0xce
Oct 12 11:46:49 swdev14 kernel:  [<c012e89d>] __call_usermodehelper+0x0/0x69
Oct 12 11:46:49 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 11:46:49 swdev14 kernel:  [<c012e6e1>] request_module+0xa1/0xe5
Oct 12 11:46:49 swdev14 kernel:  [<c0134141>] __mcount+0x1d/0x21
Oct 12 11:46:49 swdev14 kernel:  [<c0164d2c>] base_probe+0xe/0x52
Oct 12 11:46:49 swdev14 kernel:  [<c01e672b>] kobj_lookup+0xf8/0x105
Oct 12 11:46:49 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 11:46:49 swdev14 kernel:  [<c0164d50>] base_probe+0x32/0x52
Oct 12 11:46:49 swdev14 kernel:  [<c01e672b>] kobj_lookup+0xf8/0x105
Oct 12 11:46:49 swdev14 kernel:  [<c0164d1e>] base_probe+0x0/0x52
Oct 12 11:46:49 swdev14 kernel:  [<c01649ff>] chrdev_open+0xf2/0x16f
Oct 12 11:46:49 swdev14 kernel:  [<c016490d>] chrdev_open+0x0/0x16f
Oct 12 11:46:49 swdev14 kernel:  [<c015aafa>] dentry_open+0x106/0x180
Oct 12 11:46:49 swdev14 kernel:  [<c015a9f2>] filp_open+0x62/0x64
Oct 12 11:46:49 swdev14 kernel:  [<c013388c>] _mutex_unlock+0xe/0x5e
Oct 12 11:46:49 swdev14 kernel:  [<c01b1bfa>] find_next_zero_bit+0x14/0xa6
Oct 12 11:46:49 swdev14 kernel:  [<c015ac04>] get_unused_fd+0x90/0xe4
Oct 12 11:46:49 swdev14 kernel:  [<c015ad58>] sys_open+0x4b/0x88
Oct 12 11:46:49 swdev14 kernel:  [<c0106175>] sysenter_past_esp+0x52/0x71
Oct 12 11:46:50 swdev14 kernel: scheduling while atomic: khelper/0x04000001/14
Oct 12 11:46:50 swdev14 kernel: caller is cond_resched+0x63/0x83
Oct 12 11:46:50 swdev14 kernel:  [<c029925b>] schedule+0xbaf/0xbe2
Oct 12 11:46:50 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:50 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:50 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:50 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:50 swdev14 kernel:  [<c013492a>] touch_preempt_timing+0x46/0x4a
Oct 12 11:46:50 swdev14 kernel:  [<c02996cd>] cond_resched+0x26/0x83
Oct 12 11:46:50 swdev14 kernel:  [<c029970a>] cond_resched+0x63/0x83
Oct 12 11:46:50 swdev14 kernel:  [<c0133b82>] _rw_mutex_read_lock+0x24/0x39
Oct 12 11:46:50 swdev14 kernel:  [<c011f62c>] profile_handoff_task+0x1a/0x52
Oct 12 11:46:50 swdev14 kernel:  [<c011c508>] __put_task_struct+0x66/0x119
Oct 12 11:46:50 swdev14 kernel:  [<c0298a0b>] schedule+0x35f/0xbe2
Oct 12 11:46:50 swdev14 kernel:  [<c029a35d>] _spin_unlock_irqrestore+0x1c/0x36
Oct 12 11:46:50 swdev14 kernel:  [<c013487c>] check_preempt_timing+0x191/0x1f9
Oct 12 11:46:50 swdev14 kernel:  [<c0134ae5>] sub_preempt_count+0x82/0x97
Oct 12 11:46:50 swdev14 kernel:  [<c029a35d>] _spin_unlock_irqrestore+0x1c/0x36
Oct 12 11:46:50 swdev14 kernel:  [<c012edbf>] worker_thread+0x20c/0x22a
Oct 12 11:46:50 swdev14 kernel:  [<c012e89d>] __call_usermodehelper+0x0/0x69
Oct 12 11:46:50 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:50 swdev14 kernel:  [<c011a368>] default_wake_function+0x0/0x1c
Oct 12 11:46:50 swdev14 kernel:  [<c01136d4>] mcount+0x14/0x18
Oct 12 11:46:50 swdev14 kernel:  [<c0132f2b>] kthread+0xbc/0xc1
Oct 12 11:46:50 swdev14 kernel:  [<c012ebb3>] worker_thread+0x0/0x22a
Oct 12 11:46:50 swdev14 kernel:  [<c0132e6f>] kthread+0x0/0xc1
Oct 12 11:46:50 swdev14 kernel:  [<c01042c9>] kernel_thread_helper+0x5/0xb
Oct 12 11:48:12 swdev14 syslogd 1.4.1: restart.

--------------090309040202010504090401--
