Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVADSxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVADSxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVADSxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:53:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:64732 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261791AbVADSxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:53:08 -0500
Message-ID: <41DAE494.1020807@osdl.org>
Date: Tue, 04 Jan 2005 10:46:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Bain <prbain@essex.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.10 oops on startup
References: <1104605177.6137.92.camel@sofa.co.uk>
In-Reply-To: <1104605177.6137.92.camel@sofa.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Bain wrote:
> Hi,
> I upgraded the kernel on my Gericom Ego laptop from 2.6.7 to 2.6.10, and
> now on startup I get two oopses (see attachment, taken with
> CONFIG_FRAME_POINTER and CONFIG_DEBUG_SLAB enabled).
> 2.6.7 works fine with a similar configuration, I haven't tried 2.6.8 or
> 2.6.9 yet.
> 
> Can anyone help?

Hi,

Have you tested any 2.6.10-bk# versions to see if this has been
fixed by recent patches?
If not, please try that and let us know, then I'll look at it
more if needed.

Thanks,
~Randy

> ------------------------------------------------------------------------
> 
> Jan  1 17:04:05 portabrick kernel:     ACPI-0294: *** Error: Looking up [ACST] in namespace, AE_ALREADY_EXISTS
> Jan  1 17:04:05 portabrick kernel: slab error in cache_free_debugcheck(): cache `size-1024': double free, or memory outside object was overwritten
> Jan  1 17:04:05 portabrick kernel:  [<c0103dbe>] dump_stack+0x1e/0x20
> Jan  1 17:04:05 portabrick kernel:  [<c0141e54>] cache_free_debugcheck+0x1b4/0x2b0
> Jan  1 17:04:05 portabrick kernel:  [<c01429c5>] kfree+0x55/0xa0
> Jan  1 17:04:05 portabrick kernel:  [<c02150a9>] acpi_ex_load_op+0x1e4/0x1ef
> Jan  1 17:04:05 portabrick kernel:  [<c0216e69>] acpi_ex_opcode_1A_1T_0R+0x24/0x59
> Jan  1 17:04:05 portabrick kernel:  [<c021071a>] acpi_ds_exec_end_op+0xb4/0x2d6
> Jan  1 17:04:05 portabrick kernel:  [<c021e337>] acpi_ps_parse_loop+0x527/0x80f
> Jan  1 17:04:05 portabrick kernel:  [<c021e676>] acpi_ps_parse_aml+0x57/0x1cd
> Jan  1 17:04:05 portabrick kernel:  [<c021eea9>] acpi_psx_execute+0x15d/0x1c4
> Jan  1 17:04:05 portabrick kernel:  [<c021c20d>] acpi_ns_execute_control_method+0x41/0x51
> Jan  1 17:04:05 portabrick kernel:  [<c021c1b2>] acpi_ns_evaluate_by_handle+0x74/0x8e
> Jan  1 17:04:05 portabrick kernel:  [<c021c0ad>] acpi_ns_evaluate_relative+0xa9/0xc5
> Jan  1 17:04:05 portabrick kernel:  [<c021b95a>] acpi_evaluate_object+0xfe/0x1af
> Jan  1 17:04:05 portabrick kernel:  [<c022a58f>] acpi_processor_set_pdc+0x6e/0x78
> Jan  1 17:04:05 portabrick kernel:  [<c022a81d>] acpi_processor_get_performance_info+0x2e/0x74
> Jan  1 17:04:05 portabrick kernel:  [<c022aa41>] acpi_processor_register_performance+0x6e/0xa3
> Jan  1 17:04:05 portabrick kernel:  [<c010dcac>] centrino_cpu_init_acpi+0x6c/0x380
> Jan  1 17:04:05 portabrick kernel:  [<c010e036>] centrino_cpu_init+0x76/0x160
> Jan  1 17:04:05 portabrick kernel:  [<c0292d7c>] cpufreq_add_dev+0x11c/0x390
> Jan  1 17:04:05 portabrick kernel:  [<c025c569>] sysdev_driver_register+0xa9/0xc0
> Jan  1 17:04:05 portabrick kernel:  [<c0293b81>] cpufreq_register_driver+0x81/0x140
> Jan  1 17:04:05 portabrick kernel:  [<c03bbbd3>] centrino_init+0x23/0x30
> Jan  1 17:04:05 portabrick kernel:  [<c03b3906>] do_initcalls+0x56/0xd0
> Jan  1 17:04:05 portabrick kernel:  [<c0100462>] init+0x32/0x120
> Jan  1 17:04:05 portabrick kernel:  [<c01012c5>] kernel_thread_helper+0x5/0x10
> Jan  1 17:04:05 portabrick kernel: dfc0d058: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
> Jan  1 17:04:05 portabrick kernel:     ACPI-1138: *** Error: Method execution failed [\_PR_.CPU1._PDC] (Node c14da200), AE_ALREADY_EXISTS
> Jan  1 17:04:05 portabrick kernel: ACPI wakeup devices: 
> Jan  1 17:04:05 portabrick kernel: P0P2  LAN CBC0 CBC1 ILNK AUDI MODM USB1 USB2 USB3 
> Jan  1 17:04:05 portabrick kernel: ACPI: (supports S0 S3 S4 S4bios S5)
> Jan  1 17:04:05 portabrick kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Jan  1 17:04:05 portabrick kernel: VFS: Mounted root (ext3 filesystem) readonly.
> Jan  1 17:04:05 portabrick kernel: Freeing unused kernel memory: 160k freed
> Jan  1 17:04:05 portabrick kernel: kjournald starting.  Commit interval 5 seconds
> Jan  1 17:04:05 portabrick kernel: Slab corruption: start=dfc0d05c, len=1024
> Jan  1 17:04:05 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:05 portabrick kernel: Last user: [<c023693c>](tty_write+0x11c/0x270)
> Jan  1 17:04:05 portabrick kernel: 000: 0d 49 4e 49 54 3a 20 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:05 portabrick kernel: 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:05 portabrick kernel: 020: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:05 portabrick kernel: 030: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:05 portabrick kernel: 040: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:05 portabrick kernel: 050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:05 portabrick kernel: Prev obj: start=dfc0cc50, len=1024
> Jan  1 17:04:05 portabrick kernel: Redzone: 0x5a2cf071/0x5a2cf071.
> Jan  1 17:04:05 portabrick kernel: Last user: [<00000000>](0x0)
> Jan  1 17:04:05 portabrick kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Jan  1 17:04:05 portabrick kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Jan  1 17:04:05 portabrick kernel: Next obj: start=dfc0d468, len=1024
> Jan  1 17:04:05 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:05 portabrick kernel: Last user: [<c02833c7>](cdrom_read_toc+0x407/0x450)
> Jan  1 17:04:05 portabrick kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a ff ff 1f 00 5a 5a 5a 5a
> Jan  1 17:04:05 portabrick kernel: 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:05 portabrick kernel: slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten
> Jan  1 17:04:05 portabrick kernel:  [<c0103dbe>] dump_stack+0x1e/0x20
> Jan  1 17:04:05 portabrick kernel:  [<c01423bd>] cache_alloc_debugcheck_after+0xfd/0x180
> Jan  1 17:04:05 portabrick kernel:  [<c014273b>] kmem_cache_alloc+0x5b/0x80
> Jan  1 17:04:05 portabrick kernel:  [<c01e7a3b>] kobject_hotplug+0xab/0x2f0
> Jan  1 17:04:05 portabrick kernel:  [<c01e723b>] kobject_del+0x1b/0x30
> Jan  1 17:04:05 portabrick kernel:  [<c025e7c4>] class_device_del+0xa4/0xc0
> Jan  1 17:04:05 portabrick kernel:  [<c025e7f2>] class_device_unregister+0x12/0x20
> Jan  1 17:04:05 portabrick kernel:  [<c024078b>] vcs_remove_devfs+0x1b/0x33
> Jan  1 17:04:05 portabrick kernel:  [<c02484a0>] con_close+0x70/0x80
> Jan  1 17:04:05 portabrick kernel:  [<c0237a8f>] release_dev+0x6df/0x830
> Jan  1 17:04:05 portabrick kernel:  [<c0238096>] tty_release+0x16/0x20
> Jan  1 17:04:05 portabrick kernel:  [<c01592ad>] __fput+0x10d/0x150
> Jan  1 17:04:05 portabrick kernel:  [<c0157990>] filp_close+0x50/0x90
> Jan  1 17:04:05 portabrick kernel:  [<c0157a2a>] sys_close+0x5a/0xa0
> Jan  1 17:04:05 portabrick kernel:  [<c0102faf>] syscall_call+0x7/0xb
> Jan  1 17:04:05 portabrick kernel: dfc0d058: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.
> Jan  1 17:04:05 portabrick kernel: slab error in cache_free_debugcheck(): cache `size-1024': double free, or memory outside object was overwritten
> Jan  1 17:04:05 portabrick kernel:  [<c0103dbe>] dump_stack+0x1e/0x20
> Jan  1 17:04:05 portabrick kernel:  [<c0141e54>] cache_free_debugcheck+0x1b4/0x2b0
> Jan  1 17:04:05 portabrick kernel:  [<c01429c5>] kfree+0x55/0xa0
> Jan  1 17:04:05 portabrick kernel:  [<c0237361>] release_mem+0x1c1/0x210
> Jan  1 17:04:05 portabrick kernel:  [<c0237964>] release_dev+0x5b4/0x830
> Jan  1 17:04:05 portabrick kernel:  [<c0238096>] tty_release+0x16/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c01592ad>] __fput+0x10d/0x150
> Jan  1 17:04:06 portabrick kernel:  [<c0157990>] filp_close+0x50/0x90
> Jan  1 17:04:06 portabrick kernel:  [<c0157a2a>] sys_close+0x5a/0xa0
> Jan  1 17:04:06 portabrick kernel:  [<c0102faf>] syscall_call+0x7/0xb
> Jan  1 17:04:06 portabrick kernel: dfc0d058: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
> Jan  1 17:04:06 portabrick kernel: Slab corruption: start=dfc0d05c, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: Last user: [<c023693c>](tty_write+0x11c/0x270)
> Jan  1 17:04:06 portabrick kernel: 000: 76 65 72 73 69 6f 6e 20 32 2e 38 34 20 62 6f 6f
> Jan  1 17:04:06 portabrick kernel: 010: 74 69 6e 67 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 020: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 030: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 040: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: Prev obj: start=dfc0cc50, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x5a2cf071/0x5a2cf071.
> Jan  1 17:04:06 portabrick kernel: Last user: [<00000000>](0x0)
> Jan  1 17:04:06 portabrick kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Jan  1 17:04:06 portabrick kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Jan  1 17:04:06 portabrick kernel: Next obj: start=dfc0d468, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: Last user: [<c02833c7>](cdrom_read_toc+0x407/0x450)
> Jan  1 17:04:06 portabrick kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a ff ff 1f 00 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten
> Jan  1 17:04:06 portabrick kernel:  [<c0103dbe>] dump_stack+0x1e/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c01423bd>] cache_alloc_debugcheck_after+0xfd/0x180
> Jan  1 17:04:06 portabrick kernel:  [<c014273b>] kmem_cache_alloc+0x5b/0x80
> Jan  1 17:04:06 portabrick kernel:  [<c01e7a3b>] kobject_hotplug+0xab/0x2f0
> Jan  1 17:04:06 portabrick kernel:  [<c01e723b>] kobject_del+0x1b/0x30
> Jan  1 17:04:06 portabrick kernel:  [<c025e7c4>] class_device_del+0xa4/0xc0
> Jan  1 17:04:06 portabrick kernel:  [<c025e7f2>] class_device_unregister+0x12/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c024078b>] vcs_remove_devfs+0x1b/0x33
> Jan  1 17:04:06 portabrick kernel:  [<c02484a0>] con_close+0x70/0x80
> Jan  1 17:04:06 portabrick kernel:  [<c0237a8f>] release_dev+0x6df/0x830
> Jan  1 17:04:06 portabrick kernel:  [<c0238096>] tty_release+0x16/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c01592ad>] __fput+0x10d/0x150
> Jan  1 17:04:06 portabrick kernel:  [<c0157990>] filp_close+0x50/0x90
> Jan  1 17:04:06 portabrick kernel:  [<c0157a2a>] sys_close+0x5a/0xa0
> Jan  1 17:04:06 portabrick kernel:  [<c0102faf>] syscall_call+0x7/0xb
> Jan  1 17:04:06 portabrick kernel: dfc0d058: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: slab error in cache_free_debugcheck(): cache `size-1024': double free, or memory outside object was overwritten
> Jan  1 17:04:06 portabrick kernel:  [<c0103dbe>] dump_stack+0x1e/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c0141e54>] cache_free_debugcheck+0x1b4/0x2b0
> Jan  1 17:04:06 portabrick kernel:  [<c01429c5>] kfree+0x55/0xa0
> Jan  1 17:04:06 portabrick kernel:  [<c0237361>] release_mem+0x1c1/0x210
> Jan  1 17:04:06 portabrick kernel:  [<c0237964>] release_dev+0x5b4/0x830
> Jan  1 17:04:06 portabrick kernel:  [<c0238096>] tty_release+0x16/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c01592ad>] __fput+0x10d/0x150
> Jan  1 17:04:06 portabrick kernel:  [<c0157990>] filp_close+0x50/0x90
> Jan  1 17:04:06 portabrick kernel:  [<c0157a2a>] sys_close+0x5a/0xa0
> Jan  1 17:04:06 portabrick kernel:  [<c0102faf>] syscall_call+0x7/0xb
> Jan  1 17:04:06 portabrick kernel: dfc0d058: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
> Jan  1 17:04:06 portabrick kernel: Slab corruption: start=dfc0d05c, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: Last user: [<c023693c>](tty_write+0x11c/0x270)
> Jan  1 17:04:06 portabrick kernel: 000: 0d 0a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 020: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 030: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 040: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 050: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: Prev obj: start=dfc0cc50, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x5a2cf071/0x5a2cf071.
> Jan  1 17:04:06 portabrick kernel: Last user: [<00000000>](0x0)
> Jan  1 17:04:06 portabrick kernel: 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Jan  1 17:04:06 portabrick kernel: 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Jan  1 17:04:06 portabrick kernel: Next obj: start=dfc0d468, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: Last user: [<c02833c7>](cdrom_read_toc+0x407/0x450)
> Jan  1 17:04:06 portabrick kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a ff ff 1f 00 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten
> Jan  1 17:04:06 portabrick kernel:  [<c0103dbe>] dump_stack+0x1e/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c01423bd>] cache_alloc_debugcheck_after+0xfd/0x180
> Jan  1 17:04:06 portabrick kernel:  [<c014273b>] kmem_cache_alloc+0x5b/0x80
> Jan  1 17:04:06 portabrick kernel:  [<c01e7a3b>] kobject_hotplug+0xab/0x2f0
> Jan  1 17:04:06 portabrick kernel:  [<c01e723b>] kobject_del+0x1b/0x30
> Jan  1 17:04:06 portabrick kernel:  [<c025e7c4>] class_device_del+0xa4/0xc0
> Jan  1 17:04:06 portabrick kernel:  [<c025e7f2>] class_device_unregister+0x12/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c024078b>] vcs_remove_devfs+0x1b/0x33
> Jan  1 17:04:06 portabrick kernel:  [<c02484a0>] con_close+0x70/0x80
> Jan  1 17:04:06 portabrick kernel:  [<c0237a8f>] release_dev+0x6df/0x830
> Jan  1 17:04:06 portabrick kernel:  [<c0238096>] tty_release+0x16/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c01592ad>] __fput+0x10d/0x150
> Jan  1 17:04:06 portabrick kernel:  [<c0157990>] filp_close+0x50/0x90
> Jan  1 17:04:06 portabrick kernel:  [<c0157a2a>] sys_close+0x5a/0xa0
> Jan  1 17:04:06 portabrick kernel:  [<c0102faf>] syscall_call+0x7/0xb
> Jan  1 17:04:06 portabrick kernel: dfc0d058: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: slab error in cache_free_debugcheck(): cache `size-1024': double free, or memory outside object was overwritten
> Jan  1 17:04:06 portabrick kernel:  [<c0103dbe>] dump_stack+0x1e/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c0141e54>] cache_free_debugcheck+0x1b4/0x2b0
> Jan  1 17:04:06 portabrick kernel:  [<c01429c5>] kfree+0x55/0xa0
> Jan  1 17:04:06 portabrick kernel:  [<c0237361>] release_mem+0x1c1/0x210
> Jan  1 17:04:06 portabrick kernel:  [<c0237964>] release_dev+0x5b4/0x830
> Jan  1 17:04:06 portabrick kernel:  [<c0238096>] tty_release+0x16/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c01592ad>] __fput+0x10d/0x150
> Jan  1 17:04:06 portabrick kernel:  [<c0157990>] filp_close+0x50/0x90
> Jan  1 17:04:06 portabrick kernel:  [<c0157a2a>] sys_close+0x5a/0xa0
> Jan  1 17:04:06 portabrick kernel:  [<c0102faf>] syscall_call+0x7/0xb
> Jan  1 17:04:06 portabrick kernel: dfc0d058: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
> Jan  1 17:04:06 portabrick kernel: Slab corruption: start=dfc0d05c, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: Last user: [<c0173b34>](alloc_fd_array+0x24/0x30)
> Jan  1 17:04:06 portabrick kernel: 000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Jan  1 17:04:06 portabrick kernel: 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Jan  1 17:04:06 portabrick kernel: 020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Jan  1 17:04:06 portabrick kernel: 030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Jan  1 17:04:06 portabrick kernel: 040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Jan  1 17:04:06 portabrick kernel: 050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Jan  1 17:04:06 portabrick kernel: Prev obj: start=dfc0cc50, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: Last user: [<c0173b34>](alloc_fd_array+0x24/0x30)
> Jan  1 17:04:06 portabrick kernel: 000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Jan  1 17:04:06 portabrick kernel: 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Jan  1 17:04:06 portabrick kernel: Next obj: start=dfc0d468, len=1024
> Jan  1 17:04:06 portabrick kernel: Redzone: 0x170fc2a5/0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: Last user: [<c02833c7>](cdrom_read_toc+0x407/0x450)
> Jan  1 17:04:06 portabrick kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a ff ff 1f 00 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
> Jan  1 17:04:06 portabrick kernel: slab error in cache_alloc_debugcheck_after(): cache `size-1024': double free, or memory outside object was overwritten
> Jan  1 17:04:06 portabrick kernel:  [<c0103dbe>] dump_stack+0x1e/0x20
> Jan  1 17:04:06 portabrick kernel:  [<c01423bd>] cache_alloc_debugcheck_after+0xfd/0x180
> Jan  1 17:04:06 portabrick kernel:  [<c014284b>] __kmalloc+0x8b/0xc0
> Jan  1 17:04:06 portabrick kernel:  [<c0173b34>] alloc_fd_array+0x24/0x30
> Jan  1 17:04:06 portabrick kernel:  [<c0173c27>] expand_fd_array+0x97/0x1b0
> Jan  1 17:04:06 portabrick kernel:  [<c0169e21>] expand_files+0x41/0x60
> Jan  1 17:04:06 portabrick kernel:  [<c016a017>] sys_dup2+0x87/0x160
> Jan  1 17:04:06 portabrick kernel:  [<c0102faf>] syscall_call+0x7/0xb
> Jan  1 17:04:06 portabrick kernel: dfc0d058: redzone 1: 0x170fc2a5, redzone 2: 0x170fc2a5.
> Jan  1 17:04:06 portabrick kernel: Unable to handle kernel paging request at virtual address a56b6b8f
> Jan  1 17:04:06 portabrick kernel:  printing eip:
> Jan  1 17:04:06 portabrick kernel: c0158542
> Jan  1 17:04:06 portabrick kernel: *pde = 00000000
> Jan  1 17:04:06 portabrick kernel: Oops: 0000 [#1]
> Jan  1 17:04:06 portabrick kernel: PREEMPT 
> Jan  1 17:04:06 portabrick kernel: Modules linked in:
> Jan  1 17:04:06 portabrick kernel: CPU:    0
> Jan  1 17:04:06 portabrick kernel: EIP:    0060:[<c0158542>]    Not tainted VLI
> Jan  1 17:04:06 portabrick kernel: EFLAGS: 00010282   (2.6.10) 
> Jan  1 17:04:06 portabrick kernel: EIP is at sys_read+0x22/0x80
> Jan  1 17:04:06 portabrick kernel: eax: a56b6b6b   ebx: a56b6b6b   ecx: c1655c08   edx: c16c8000
> Jan  1 17:04:06 portabrick kernel: esi: fffffff7   edi: 080ed008   ebp: c16c8fbc   esp: c16c8f98
> Jan  1 17:04:06 portabrick kernel: ds: 007b   es: 007b   ss: 0068
> Jan  1 17:04:06 portabrick kernel: Process hotplug (pid: 341, threadinfo=c16c8000 task=c16c7a60)
> Jan  1 17:04:06 portabrick kernel: Stack: c16c8fa0 00000008 00000000 00000000 00000000 00000000 00000000 000000ff 
> Jan  1 17:04:06 portabrick kernel:        00000488 c16c8000 c0102faf 000000ff 080ed008 00000488 00000488 080ed008 
> Jan  1 17:04:06 portabrick kernel:        bffff4b8 00000003 0000007b 0000007b 00000003 b7f6bff8 00000073 00000246 
> Jan  1 17:04:06 portabrick kernel: Call Trace:
> Jan  1 17:04:06 portabrick kernel:  [<c0103d7f>] show_stack+0x7f/0xa0
> Jan  1 17:04:06 portabrick kernel:  [<c0103f16>] show_registers+0x156/0x1d0
> Jan  1 17:04:06 portabrick kernel:  [<c010413a>] die+0xea/0x180
> Jan  1 17:04:06 portabrick kernel:  [<c01162d2>] do_page_fault+0x482/0x6c0
> Jan  1 17:04:06 portabrick kernel:  [<c01039e7>] error_code+0x2b/0x30
> Jan  1 17:04:06 portabrick kernel:  [<c0102faf>] syscall_call+0x7/0xb
> Jan  1 17:04:06 portabrick kernel: Code: e9 26 ff ff ff 8d 74 26 00 55 89 e5 83 ec 24 89 5d f8 8b 45 08 8d 55 f4 89 75 fc be f7 ff ff ff e8 04 0e 00 00 85 c0 89 c3 74 3e <8b> 40 24 8b 53 28 89 1c 24 89 45 ec 8d 45 ec 89 44 24 0c 8b 45 
