Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbULCLhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbULCLhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 06:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbULCLhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 06:37:07 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:25848 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262160AbULCLgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 06:36:55 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Ingo Molnar <mingo@elte.hu>
Subject: Re:2.6.10-rc2-mm3-V0.7.31-19
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org
Date: Fri, 3 Dec 2004 06:37:09 -0500
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200412030637.09418.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.11.214] at Fri, 3 Dec 2004 05:36:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo;

This is a resend as I was trying to take a load off the mail server
at vger.

I was just scanning my log tail and found this, which I
believe occured when I disconnected my Olympus C3020 camera
from its usb cable.  I wasn't watching the computer as I was
getting ready to go out with the missus and celebrate our 15th
together with a fancy dinner.  The machine is still up with no apparent
ill effects that I've noticed so far.

>From the log:  I'd turned on the camera to check the batteries
------------
Dec  2 17:51:39 coyote kernel: usb 3-2.2: new full speed USB device using ohci_hcd and address 7
Dec  2 17:51:39 coyote kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Dec  2 17:51:44 coyote kernel:   Vendor: OLYMPUS   Model: C-3020ZOOM(U)     Rev: 1.00
Dec  2 17:51:44 coyote kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Dec  2 17:51:44 coyote kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Dec  2 17:51:44 coyote scsi.agent[28996]: disk at /devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2.2/3-2.2:1.0/host0/target0:0:0/0:0:0:0
Dec  2 17:51:44 coyote kernel: SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
Dec  2 17:51:44 coyote kernel: sda: assuming Write Enabled
Dec  2 17:51:44 coyote kernel: sda: assuming drive cache: write through
Dec  2 17:51:44 coyote kernel:  sda: sda1
Dec  2 17:51:44 coyote kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
---------
then I turned it off and unplugged the usb cable from it.
------------
Dec  2 17:51:56 coyote kernel: usb 3-2.2: USB disconnect, address 7
Dec  2 17:51:56 coyote kernel: slab error in kmem_cache_destroy(): cache `scsi_cmd_cache': Can't free all objects
Dec  2 17:51:56 coyote kernel:  [<c0142d63>] kmem_cache_destroy+0xf3/0x190 (8)
Dec  2 17:51:56 coyote kernel:  [<c0288679>] scsi_destroy_command_freelist+0x49/0x80 (24)
Dec  2 17:51:56 coyote kernel:  [<c028951a>] scsi_host_dev_release+0x3a/0x150 (24)
Dec  2 17:51:56 coyote kernel:  [<c032c6d6>] wait_for_completion+0x16/0x120 (108)
Dec  2 17:51:56 coyote kernel:  [<c0257af5>] device_release+0x75/0x80 (44)
Dec  2 17:51:56 coyote kernel:  [<c02b4381>] usb_stor_release_resources+0xc1/0xe0 (24)
Dec  2 17:51:56 coyote kernel:  [<c01e8c68>] kobject_cleanup+0x98/0xa0 (4)
Dec  2 17:51:56 coyote kernel:  [<c01e8c70>] kobject_release+0x0/0x10 (12)
Dec  2 17:51:56 coyote kernel:  [<c01e9745>] kref_put+0x45/0x100 (12)
Dec  2 17:51:56 coyote kernel:  [<c01e8c9e>] kobject_put+0x1e/0x30 (36)
Dec  2 17:51:56 coyote kernel:  [<c01e8c70>] kobject_release+0x0/0x10 (8)
Dec  2 17:51:56 coyote kernel:  [<c02b4327>] usb_stor_release_resources+0x67/0xe0 (4)
Dec  2 17:51:56 coyote kernel:  [<c02b4879>] storage_disconnect+0x89/0xd0 (12)
Dec  2 17:51:56 coyote kernel:  [<c0298678>] usb_unbind_interface+0x88/0x90 (12)
Dec  2 17:51:56 coyote kernel:  [<c0258d95>] device_release_driver+0x85/0x90 (24)
Dec  2 17:51:56 coyote kernel:  [<c0258fa1>] bus_remove_device+0x51/0x90 (24)
Dec  2 17:51:56 coyote kernel:  [<c0257f5a>] device_del+0x4a/0x90 (16)
Dec  2 17:51:56 coyote kernel:  [<c029fa58>] usb_disable_device+0xb8/0x100 (16)
Dec  2 17:51:56 coyote kernel:  [<c029abb8>] usb_disconnect+0xa8/0x140 (24)
Dec  2 17:51:56 coyote kernel:  [<c029be8f>] hub_port_connect_change+0x3cf/0x410 (36)
Dec  2 17:51:56 coyote kernel:  [<c0299738>] clear_port_feature+0x58/0x60 (12)
Dec  2 17:51:56 coyote kernel:  [<c029c127>] hub_events+0x257/0x380 (40)
Dec  2 17:51:56 coyote kernel:  [<c012ebaf>] finish_wait+0x4f/0x70 (28)
Dec  2 17:51:56 coyote kernel:  [<c029c285>] hub_thread+0x35/0x110 (24)
Dec  2 17:51:56 coyote kernel:  [<c012ebd0>] autoremove_wake_function+0x0/0x60 (24)
Dec  2 17:51:56 coyote kernel:  [<c010262e>] ret_from_fork+0x6/0x14 (20)
Dec  2 17:51:56 coyote kernel:  [<c012ebd0>] autoremove_wake_function+0x0/0x60 (12)
Dec  2 17:51:56 coyote kernel:  [<c029c250>] hub_thread+0x0/0x110 (24)
Dec  2 17:51:56 coyote kernel:  [<c01008b1>] kernel_thread_helper+0x5/0x14 (16)
Dec  2 17:52:05 coyote kernel: usb 3-2.2: new full speed USB device using ohci_hcd and address 8
Dec  2 17:52:05 coyote kernel: kmem_cache_create: duplicate cache scsi_cmd_cache
Dec  2 17:52:05 coyote kernel: BUG at mm/slab.c:1447!
Dec  2 17:52:05 coyote kernel: ------------[ cut here ]------------
Dec  2 17:52:05 coyote kernel: kernel BUG at mm/slab.c:1447!
Dec  2 17:52:05 coyote kernel: invalid operand: 0000 [#1]
Dec  2 17:52:05 coyote kernel: PREEMPT
Dec  2 17:52:05 coyote kernel: Modules linked in: sd_mod radeon drm agpgart eeprom snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc forcedeth sg
Dec  2 17:52:05 coyote kernel: CPU:    0
Dec  2 17:52:05 coyote kernel: EIP:    0060:[<c0142858>]    Not tainted VLI
Dec  2 17:52:05 coyote kernel: EFLAGS: 00010292   (2.6.10-rc2-mm3-V0.7.31-19)
Dec  2 17:52:05 coyote kernel: EIP is at kmem_cache_create+0x418/0x650
Dec  2 17:52:05 coyote kernel: eax: 00000017   ebx: f7d53320   ecx: 00000001   edx: c1b77000
Dec  2 17:52:05 coyote kernel: esi: c0358feb   edi: c0358feb   ebp: f7d53484   esp: c1b77ce4
Dec  2 17:52:05 coyote kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Dec  2 17:52:05 coyote kernel: Process khubd (pid: 160, threadinfo=c1b77000 task=c1b79870)
Dec  2 17:52:05 coyote kernel: Stack: c03416d3 c0345f8f 000005a7 00000565 c1b77d08 f7d5335c 00000009 ffffffff
Dec  2 17:52:05 coyote kernel:        ffffffe0 00000120 f3451000 c03dd6e0 f3451040 c03e0c20 c02885ad c0358fdc
Dec  2 17:52:05 coyote kernel:        0000018c 00000020 00002000 00000000 00000000 f34510d8 f3451000 f34512f4
Dec  2 17:52:05 coyote kernel: Call Trace:
Dec  2 17:52:05 coyote kernel:  [<c02885ad>] scsi_setup_command_freelist+0x8d/0x110 (60)
Dec  2 17:52:05 coyote kernel:  [<c02898f3>] scsi_host_alloc+0x2c3/0x3e0 (40)
Dec  2 17:52:05 coyote kernel:  [<c02b4219>] usb_stor_acquire_resources+0x69/0x110 (164)
Dec  2 17:52:05 coyote kernel:  [<c02b4746>] storage_probe+0x1b6/0x260 (24)
Dec  2 17:52:05 coyote kernel:  [<c02985cf>] usb_probe_interface+0x6f/0x90 (36)
Dec  2 17:52:05 coyote kernel:  [<c0258b92>] driver_probe_device+0x32/0x80 (24)
Dec  2 17:52:05 coyote kernel:  [<c0258c27>] device_attach+0x47/0xa0 (20)
Dec  2 17:52:05 coyote kernel:  [<c0258f0c>] bus_add_device+0x4c/0x90 (36)
Dec  2 17:52:05 coyote kernel:  [<c0257e13>] device_add+0xc3/0x140 (24)
Dec  2 17:52:05 coyote kernel:  [<c02a0131>] usb_set_configuration+0x301/0x490 (36)
Dec  2 17:52:05 coyote kernel:  [<c029adc4>] usb_new_device+0xb4/0x170 (80)
Dec  2 17:52:05 coyote kernel:  [<c029bc55>] hub_port_connect_change+0x195/0x410 (16)
Dec  2 17:52:05 coyote kernel:  [<c029bce6>] hub_port_connect_change+0x226/0x410 (24)
Dec  2 17:52:05 coyote kernel:  [<c029c127>] hub_events+0x257/0x380 (52)
Dec  2 17:52:05 coyote kernel:  [<c012ebaf>] finish_wait+0x4f/0x70 (28)
Dec  2 17:52:05 coyote kernel:  [<c029c285>] hub_thread+0x35/0x110 (24)
Dec  2 17:52:05 coyote kernel:  [<c012ebd0>] autoremove_wake_function+0x0/0x60 (24)
Dec  2 17:52:05 coyote kernel:  [<c010262e>] ret_from_fork+0x6/0x14 (20)
Dec  2 17:52:05 coyote kernel:  [<c012ebd0>] autoremove_wake_function+0x0/0x60 (12)
Dec  2 17:52:05 coyote kernel:  [<c029c250>] hub_thread+0x0/0x110 (24)
Dec  2 17:52:05 coyote kernel:  [<c01008b1>] kernel_thread_helper+0x5/0x14 (16)
Dec  2 17:52:05 coyote kernel: Code: e8 de 6b fd ff b8 40 d9 46 c0 e8 84 f0 fe ff c7 44 24 08 a7 05 00 00 c7 44 2404 8f 5f 34 c0 c7 04 24 d3 16 34 c0 e8 b8 6b fd ff <0f> 0b a7 05 8f 5f 34 c0 8b 4d 00 e9 4e ff ff ff 8b 47 34 c7 04
Dec  2 17:52:05 coyote kernel:  BUG: khubd/160, lock held at task exit time!
Dec  2 17:52:05 coyote kernel:  [c03df7a0] {usb_all_devices_rwsem.lock}
Dec  2 17:52:05 coyote kernel: .. held by:             khubd:  160 [c1b79870, 116]
Dec  2 17:52:05 coyote kernel: ... acquired at:  usb_lock_device+0xf/0x20
Dec  2 17:52:05 coyote kernel: BUG: khubd/160, lock held at task exit time!
Dec  2 17:52:05 coyote kernel:  [f7ce8c28] {&dev->serialize}
Dec  2 17:52:05 coyote kernel: .. held by:             khubd:  160 [c1b79870, 116]
Dec  2 17:52:05 coyote kernel: ... acquired at:  locktree+0x66/0x80
Dec  2 17:52:05 coyote kernel: BUG: khubd/160, lock held at task exit time!
Dec  2 17:52:05 coyote kernel:  [f6038428] {&dev->serialize}
Dec  2 17:52:05 coyote kernel: .. held by:             khubd:  160 [c1b79870, 116]
Dec  2 17:52:05 coyote kernel: ... acquired at:  hub_port_connect_change+0x16d/0x410
Dec  2 17:52:05 coyote kernel: BUG: khubd/160, lock held at task exit time!
Dec  2 17:52:05 coyote kernel:  [c03df8cc] {&s->rwsem}
Dec  2 17:52:05 coyote kernel: .. held by:             khubd:  160 [c1b79870, 116]
Dec  2 17:52:05 coyote kernel: ... acquired at:  bus_add_device+0x2b/0x90
Dec  2 17:52:05 coyote kernel: BUG: usb.agent/29112, lock held at task exit time!
Dec  2 17:52:05 coyote kernel:  [c03dd724] {host_cmd_pool_mutex.lock}
Dec  2 17:52:05 coyote kernel: .. held by:         usb.agent:29112 [c1b79870, 117]
Dec  2 17:52:05 coyote kernel: ... acquired at:  scsi_setup_command_freelist+0x45/0x110
---------------------------

As its now approaching midnight I'll just let it run and
see what sort of trouble it gets into when amanda fires up
in another hour.

And that was just fine, its now early morning here.

Is there anything I should do here?  This is with full preemption turned
on.

Also, I now noticing that my cron driven every 3 hour run of ntpdate
is now resetting the system clock backwards by about 10 minutes each
time, so the clock is losing its sanity with this patch, and
may have been doing it for a week or more.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
