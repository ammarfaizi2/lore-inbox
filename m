Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWBTOHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWBTOHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWBTOHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:07:14 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:61868 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964821AbWBTOHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:07:13 -0500
Message-ID: <43F9DB1D.4090305@aitel.hist.no>
Date: Mon, 20 Feb 2006 16:07:09 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1 kernel crash at bootup. parport trouble?
References: <20060220042615.5af1bddc.akpm@osdl.org>
In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pentium IV single processor, gcc (GCC) 4.0.3 20060128

During boot, I normally get:
parport0: irq 7 detected
lp0: using parport0 (polling).

Instead, I got this, written by hand:
parport0:irq 7 detected
BUG unable to handle kernel NULL pointer dereference at 000000c8
eip c0234785
*pde=0
Oops: 0000[#1]
last sysfs file:
cpu 0
Eip: 0060:[<c0234785>] not tainted VLI
EFLAGS: 000010282 (2.6.16-rc4-mm1 #3)
EIP is at kref_get+0x6/0x3e
eax  000000c8 ebx 000000c8 ecx 00000000 edx affea000
esi c04d1df1 edi dff59927 ebp dff68394 esp dff59927
ds 0007b es 0007b ss 00068
process swapper
call trace
kobject_get                     sysfs_create_link
sysfs_add_file                 class_device_add
kobject_juif                     class_device_create
lp_register                      lp_attach
attach_driver_chain       parport_announce_port
parport_pc_probe_port parport_pc_init
init                                   init
kernel_thread_helper

kernel panic - not syncing attempted to kill init!
reboot in 300 seconds. (Now, if sysrq+B would work
while waiting for this...)


This oops is simplified. I can get the exact text if
that really matters.  It is much more to write down and
I don't usually have my camera at work.

Helge Hafting
