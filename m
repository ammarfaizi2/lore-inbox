Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbUCZJAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUCZJAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:00:31 -0500
Received: from main.gmane.org ([80.91.224.249]:20405 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263968AbUCZJA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:00:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Frederik Himpe <fhimpe@pandora.be>
Subject: acpi: Badness in remove_proc_entry at fs/proc/generic.c:660 (2.6.5-rc2-aa1)
Date: Fri, 26 Mar 2004 09:54:14 +0100
Message-ID: <pan.2004.03.26.08.54.12.739057@pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 194.78.190.194
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Chronos 2.6.5-rc2-aa1 #1 Sun Mar 21 18:09:10 CET 2004 i686 unknown unknown GNU/Linux
gcc (GCC) 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)

.config: http://users.telenet.be/fhimpe/kernel/config
lspci -v: http://users.telenet.be/fhimpe/kernel/lspci
dmesg: http://users.telenet.be/fhimpe/kernel/dmesg

This happened at system halt:

Mar 25 19:24:37 localhost kernel: Call Trace:
Mar 25 19:24:37 localhost kernel:  [<c01746da>] remove_proc_entry+0x19f/0x1b1
Mar 25 19:24:37 localhost kernel:  [<cf9710e8>] acpi_battery_remove_fs+0x1d/0x2c [battery]
Mar 25 19:24:37 localhost kernel:  [<cf97112b>] acpi_battery_remove+0x34/0x41 [battery]
Mar 25 19:24:37 localhost kernel:  [<c01d84e9>] acpi_bus_unregister_driver+0x3d/0x8d
Mar 25 19:24:37 localhost kernel:  [<cf971b75>] acpi_battery_exit+0xd/0x1e [battery]
Mar 25 19:24:37 localhost kernel:  [<c012fa7f>] sys_delete_module+0x130/0x1c2
Mar 25 19:24:37 localhost kernel:  [<c0141643>] sys_munmap+0x41/0x64
Mar 25 19:24:37 localhost kernel:  [<c0106de1>] sysenter_past_esp+0x52/0x71
Mar 25 19:24:37 localhost kernel:
Mar 25 19:24:37 localhost kernel: Badness in remove_proc_entry at fs/proc/generic.c:660
Mar 25 19:24:37 localhost kernel: Call Trace:
Mar 25 19:24:37 localhost kernel:  [<c01746da>] remove_proc_entry+0x19f/0x1b1
Mar 25 19:24:37 localhost kernel:  [<cf97501d>] acpi_ac_remove_fs+0x1d/0x2c [ac]
Mar 25 19:24:37 localhost kernel:  [<cf975060>] acpi_ac_remove+0x34/0x41 [ac]
Mar 25 19:24:37 localhost kernel:  [<c01d84e9>] acpi_bus_unregister_driver+0x3d/0x8d
Mar 25 19:24:37 localhost kernel:  [<cf97538d>] cleanup_module+0xd/0x1e [ac]
Mar 25 19:24:37 localhost kernel:  [<c012fa7f>] sys_delete_module+0x130/0x1c2
Mar 25 19:24:37 localhost kernel:  [<c0141643>] sys_munmap+0x41/0x64
Mar 25 19:24:37 localhost kernel:  [<c0106de1>] sysenter_past_esp+0x52/0x71
Mar 25 19:24:37 localhost kernel:
Mar 25 19:24:37 localhost kernel: Badness in remove_proc_entry at fs/proc/generic.c:660
Mar 25 19:24:37 localhost kernel: Call Trace:
Mar 25 19:24:37 localhost kernel:  [<c01746da>] remove_proc_entry+0x19f/0x1b1
Mar 25 19:24:37 localhost kernel:  [<cf9df01d>] acpi_thermal_remove_fs+0x1d/0x2c [thermal]
Mar 25 19:24:37 localhost kernel:  [<cf9df235>] acpi_thermal_remove+0x79/0x7f [thermal]
Mar 25 19:24:37 localhost kernel:  [<c01d84e9>] acpi_bus_unregister_driver+0x3d/0x8d
Mar 25 19:24:37 localhost kernel:  [<cf9e0351>] acpi_thermal_exit+0xd/0x1e [thermal]
Mar 25 19:24:37 localhost kernel:  [<c012fa7f>] sys_delete_module+0x130/0x1c2
Mar 25 19:24:37 localhost kernel:  [<c0141643>] sys_munmap+0x41/0x64
Mar 25 19:24:37 localhost kernel:  [<c0106de1>] sysenter_past_esp+0x52/0x71
Mar 25 19:24:37 localhost kernel:
Mar 25 19:24:37 localhost kernel: Badness in remove_proc_entry at fs/proc/generic.c:660
Mar 25 19:24:37 localhost kernel: Call Trace:
Mar 25 19:24:37 localhost kernel:  [<c01746da>] remove_proc_entry+0x19f/0x1b1
Mar 25 19:24:37 localhost kernel:  [<cf9df01d>] acpi_thermal_remove_fs+0x1d/0x2c [thermal]
Mar 25 19:24:37 localhost kernel:  [<cf9df235>] acpi_thermal_remove+0x79/0x7f [thermal]
Mar 25 19:24:37 localhost kernel:  [<c01d84e9>] acpi_bus_unregister_driver+0x3d/0x8d
Mar 25 19:24:37 localhost kernel:  [<cf9e0351>] acpi_thermal_exit+0xd/0x1e [thermal]
Mar 25 19:24:37 localhost kernel:  [<c012fa7f>] sys_delete_module+0x130/0x1c2
Mar 25 19:24:37 localhost kernel:  [<c0141643>] sys_munmap+0x41/0x64
Mar 25 19:24:37 localhost kernel:  [<c0106de1>] sysenter_past_esp+0x52/0x71
Mar 25 19:24:37 localhost kernel:
Mar 25 19:24:37 localhost kernel: Badness in remove_proc_entry at fs/proc/generic.c:660
Mar 25 19:24:37 localhost kernel: Call Trace:
Mar 25 19:24:37 localhost kernel:  [<c01746da>] remove_proc_entry+0x19f/0x1b1
Mar 25 19:24:37 localhost kernel:  [<cf9d943c>] acpi_processor_remove_fs+0x1d/0x2c [processor]
Mar 25 19:24:37 localhost kernel:  [<cf9d948f>] acpi_processor_remove+0x44/0x5f [processor]
Mar 25 19:24:37 localhost kernel:  [<c01d84e9>] acpi_bus_unregister_driver+0x3d/0x8d
Mar 25 19:24:37 localhost kernel:  [<cf9da929>] acpi_processor_exit+0x51/0x62 [processor]
Mar 25 19:24:37 localhost kernel:  [<c012fa7f>] sys_delete_module+0x130/0x1c2
Mar 25 19:24:37 localhost kernel:  [<c0141643>] sys_munmap+0x41/0x64
Mar 25 19:24:37 localhost kernel:  [<c0106de1>] sysenter_past_esp+0x52/0x71
Mar 25 19:24:37 localhost kernel:
Mar 25 19:24:37 localhost kernel: Badness in remove_proc_entry at fs/proc/generic.c:660
Mar 25 19:24:37 localhost kernel: Call Trace:
Mar 25 19:24:37 localhost kernel:  [<c01746da>] remove_proc_entry+0x19f/0x1b1
Mar 25 19:24:37 localhost kernel:  [<c012fa7f>] sys_delete_module+0x130/0x1c2
Mar 25 19:24:37 localhost kernel:  [<c0141643>] sys_munmap+0x41/0x64
Mar 25 19:24:37 localhost kernel:  [<c0106de1>] sysenter_past_esp+0x52/0x71


