Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTKVBjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 20:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTKVBjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 20:39:11 -0500
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:59375 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S261837AbTKVBjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 20:39:08 -0500
Date: Sat, 22 Nov 2003 02:39:05 +0100
From: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Linux IEEE 1394 Devel Mailing List 
	<linux1394-devel@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Bad sched. while atom. when rmmod'ing ohci1394 ( Rev 1079 ) on
 2.6.0-test5-mm2 + latest svn checkout
Message-Id: <20031122023905.2872d94c.philippe.gramoulle@mmania.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.9.5claws43 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

I was temporarily given an external (LA Cie) Fujitsu firewire hard drive (and below is the message i got while rmmoding the 
ohci1394 module ( 

Host is a Dell 530MT SMP running vanilla 2.6.0-test5-mm2 + latest ieee1394 svn checkout at the time of writing).

Sorry if this is a known issue that is being worked on but i haven't been able to follow ieee1394 development closely
in the recent weeks.

Let me know if you'd like me to try again with the latest linus/-mm tree

Thanks,

Philippe


ohci1394: $Rev: 1079 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fbeff800-fbefffff]  Max Packet=                                                                                            
[2048]
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[00d04b251e0508bd]
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[805b0600c5468700]
sbp2: $Rev: 1067 $ Ben Collins <bcollins@debian.org>
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io = 1)
scsi2 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: FUJITSU   Model: MHR2020AT         Rev: 30B8
  Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sdb: 39070080 512-byte hdwr sectors (20004 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
ieee1394: sbp2: Logged out of SBP-2 device
bad: scheduling while atomic!
Call Trace:
 [<c011ef9c>] schedule+0x6ec/0x700
 [<c011f35c>] wait_for_completion+0x8c/0x110
 [<c011f000>] default_wake_function+0x0/0x30
 [<c011f000>] default_wake_function+0x0/0x30
 [<c012e8df>] kill_proc_info+0x4f/0x80
 [<e2f187a1>] nodemgr_remove_host+0x51/0x90 [ieee1394]
 [<e2f14076>] highlevel_remove_host+0xa6/0xc0 [ieee1394]
 [<e2edda4e>] ohci1394_pci_remove+0x3e/0x230 [ohci1394]
 [<c023060b>] pci_device_remove+0x3b/0x40
 [<c0259e96>] device_release_driver+0x66/0x70
 [<c0259ecb>] driver_detach+0x2b/0x40
 [<c025a10c>] bus_remove_driver+0x3c/0x80
 [<c025a524>] driver_unregister+0x14/0x2a
 [<c02308c7>] pci_unregister_driver+0x17/0x30
 [<e2eddff2>] ohci1394_cleanup+0x12/0x16 [ohci1394]
 [<c013ac33>] sys_delete_module+0x133/0x160
 [<c0152274>] sys_munmap+0x44/0x70
 [<c0386e13>] syscall_call+0x7/0xb
