Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWAUL3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWAUL3r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 06:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWAUL3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 06:29:46 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6340 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932144AbWAUL3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 06:29:45 -0500
Date: Sat, 21 Jan 2006 12:29:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpiphp: treat dck separate from dock bridge
Message-ID: <20060121112933.GB1555@elf.ucw.cz>
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy> <1137808506.16192.69.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137808506.16192.69.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So, this is likely a wrong assumption, so I will be thinking some more
> about how to tell which acpi device is the dock bridge.  But meanwhile,
> this patch could be tested/reviewed to see if it gets us a step further
> in the right direction.
> 
> I patched against 2.6.16-rc1-mm2 because I wasn't sure if it was safe to
> just drop my other patch (since actually trying to just revert the
> broken out patch didn't actually work).  So this patches the file with
> my original patch applied.

Oops, there were preceding warnings before that oops...:

								Pavel

acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp_glue: get_slot_from_id: no object for id 0
BUG: warning at drivers/pci/hotplug/acpiphp_glue.c:1757/get_slot_from_id()
 [<f9990ec3>] get_slot_from_id+0x83/0x90 [acpiphp]
 [<f887e12c>] acpiphp_init+0x12c/0x290 [acpiphp]
 [<c0135636>] sys_init_module+0x146/0x1630
 [<c010f1b0>] acpi_register_ioapic+0x0/0x10
 [<c013fd87>] generic_file_aio_read+0x47/0x70
 [<c0168b93>] open_namei+0x83/0x560
 [<c012e930>] autoremove_wake_function+0x0/0x50
 [<c014d544>] do_brk+0x204/0x210
 [<c016f4fa>] dput_recursive+0x2a/0x1d0
 [<c015a891>] __fput+0xe1/0x140
 [<c017304b>] mntput_no_expire+0x1b/0x70
 [<c0102d1d>] syscall_call+0x7/0xb
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000044
 printing eip:
f9990d20
*pde = 00000000
Oops: 0000 [#1]
last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_governor
Modules linked in: acpiphp
CPU:    0
EIP:    0060:[<f9990d20>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16-rc1-mm2 #2)
EIP is at acpiphp_get_power_status+0x0/0x10 [acpiphp]
eax: 00000000   ebx: f796bbe0   ecx: f9995384   edx: f7edc2c0
esi: f796bca0   edi: 00000014   ebp: f9992c35   esp: f7b35e14
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 1520, threadinfo=f7b34000 task=c1f36a50)
Stack: <0>f887e13a f9992e5c f9992c18 00000246 22222222 fffffff4 00000000 f784e000
       f784e4ac f784e4d0 f9995380 c0135636 f99953c8 c05be852 f999538c 00000008
       00000000 f999538c 0000001c 00000018 0000001c 00000018 f998bba8 f998ba90
Call Trace:
 [<f887e13a>] acpiphp_init+0x13a/0x290 [acpiphp]
 [<c0135636>] sys_init_module+0x146/0x1630
 [<c010f1b0>] acpi_register_ioapic+0x0/0x10
 [<c013fd87>] generic_file_aio_read+0x47/0x70
 [<c0168b93>] open_namei+0x83/0x560
 [<c012e930>] autoremove_wake_function+0x0/0x50
 [<c014d544>] do_brk+0x204/0x210
 [<c016f4fa>] dput_recursive+0x2a/0x1d0
 [<c015a891>] __fput+0xe1/0x140
 [<c017304b>] mntput_no_expire+0x1b/0x70
 [<c0102d1d>] syscall_call+0x7/0xb

-- 
Thanks, Sharp!
