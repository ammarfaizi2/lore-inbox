Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbTEJNax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 09:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTEJNax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 09:30:53 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:17617 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S264101AbTEJNau
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 09:30:50 -0400
Date: Sat, 10 May 2003 15:43:26 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-bk4 usb flash memory error:
Message-ID: <Pine.LNX.4.51.0305101533450.1943@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here's the log i got when just inserting the usb device into the port.

Regards,
Maciej

kernel: drivers/usb/host/uhci-hcd.c: d000: wakeup_hc
kernel: hub 1-0:0: port 1, status 101, change 1, 12 Mb/s
kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
kernel: drivers/usb/host/uhci-hcd.c: d000: suspend_hc
kernel: drivers/usb/host/uhci-hcd.c: d000: wakeup_hc
kernel: hub 1-0:0: new USB device on port 1, assigned address 3
kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=3
kernel: usb 1-1: Product: USB MP3
kernel: usb 1-1: Manufacturer:
kernel: usb 1-1: SerialNumber: 14331C050414
kernel: usb 1-1: usb_new_device - registering interface 1-1:0
kernel: usb-storage 1-1:0: usb_device_probe
kernel: usb-storage 1-1:0: usb_device_probe - got id
kernel: scsi0 : SCSI emulation for USB Mass Storage devices
kernel:   Vendor:           Model: USB MP3           Rev: 1.04
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
kernel: SCSI device sda: 243712 512-byte hdwr sectors (125 MB)
kernel: sda: Write Protect is off
kernel: sda: Mode Sense: 43 00 00 00
kernel: sda: cache data unavailable
kernel: sda: assuming drive cache: write through
kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
kernel:  printing eip:
kernel: c02282db
kernel: *pde = 00000000
kernel: Oops: 0000 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[scsi_device_get+9/52]    Tainted: P
kernel: EFLAGS: 00010293
kernel: EIP is at scsi_device_get+0x9/0x34
kernel: eax: 00000000   ebx: c1518500   ecx: 00000001   edx: 00000000
kernel: esi: 00000000   edi: c151b5e0   ebp: db89b980   esp: c15bdb00
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process khubd (pid: 4, threadinfo=c15bc000 task=dbf8c680)
kernel: Stack: c0230135 00000000 00000008 c1518500 c02300f0 00000000 db89b980 c014b2e6
kernel:        db89b980 c15bdc64 c12acd80 c0356aac c0130416 c12acd80 00000000 c1518518
kernel:        00000000 c1518500 00000001 c15bdc64 da231800 c014b38e c1518500 db89b980
kernel: Call Trace:
kernel:  [sd_open+69/284] sd_open+0x45/0x11c
kernel:  [sd_open+0/284] sd_open+0x0/0x11c
kernel:  [do_open+721/764] do_open+0x2d1/0x2fc
kernel:  [buffered_rmqueue+146/251] buffered_rmqueue+0x92/0xfb
kernel:  [blkdev_get+125/146] blkdev_get+0x7d/0x92
kernel:  [register_disk+193/319] register_disk+0xc1/0x13f
kernel:  [blk_register_region+72/209] blk_register_region+0x48/0xd1
kernel:  [add_disk+78/94] add_disk+0x4e/0x5e
kernel:  [exact_match+0/5] exact_match+0x0/0x5
kernel:  [exact_lock+0/30] exact_lock+0x0/0x1e
kernel:  [sd_attach+486/716] sd_attach+0x1e6/0x2cc
kernel:  [scsi_attach_device+118/154] scsi_attach_device+0x76/0x9a
kernel:  [scsi_add_host+95/129] scsi_add_host+0x5f/0x81
kernel:  [storage_probe+1331/1879] storage_probe+0x533/0x757
kernel:  [buffered_rmqueue+146/251] buffered_rmqueue+0x92/0xfb
kernel:  [usb_device_probe+210/249] usb_device_probe+0xd2/0xf9
kernel:  [bus_match+69/115] bus_match+0x45/0x73
kernel:  [device_attach+76/127] device_attach+0x4c/0x7f
kernel:  [bus_add_device+100/174] bus_add_device+0x64/0xae
kernel:  [device_add+208/254] device_add+0xd0/0xfe
kernel:  [usb_new_device+1136/1501] usb_new_device+0x470/0x5dd
kernel:  [usb_hub_port_connect_change+564/919] usb_hub_port_connect_change+0x234/0x397
kernel:  [usb_hub_events+1037/1144] usb_hub_events+0x40d/0x478
kernel:  [usb_hub_thread+49/242] usb_hub_thread+0x31/0xf2
kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
kernel:  [usb_hub_thread+0/242] usb_hub_thread+0x0/0xf2
kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
kernel:
kernel: Code: 8b 42 18 8b 40 4c 8b 00 85 c0 74 0b 83 38 02 74 16 ff 80 00



