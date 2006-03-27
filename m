Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWC0IbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWC0IbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWC0IbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:31:10 -0500
Received: from [213.20.50.130] ([213.20.50.130]:6951 "EHLO [213.20.50.130]")
	by vger.kernel.org with ESMTP id S1750798AbWC0IbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:31:09 -0500
Date: Mon, 27 Mar 2006 10:31:20 +0200
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: [GIT] BUG: soft lockup detected on CPU#0!
Message-ID: <20060327083120.GA10230@stiffy.osknowledge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-marc-g5d5d7727
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.

This is what showed up this morning with the latest -git. When I remove the
pcmcia card (3com Wireless Bluetooth PC Card V3.0), the system continues to
boot.

Hope this helps.
Marc

Mar 27 10:24:25 stiffy exim[9138]: 2006-03-27 10:24:25 IPv6 socket creation failed: Address family not supported by protocol
Mar 27 10:24:25 stiffy exim[9138]: 2006-03-27 10:24:25 Failed to create IPv6 socket for wildcard listening (Address family not supported by protocol): will use IPv4
Mar 27 10:24:25 stiffy exim[9138]: 2006-03-27 10:24:25 exim 4.60 daemon started: pid=9138, -q15m, listening for SMTP on port 25 (IPv4)
Mar 27 10:24:25 stiffy exim[9142]: 2006-03-27 10:24:25 Start queue run: pid=9142
Mar 27 10:24:25 stiffy exim[9142]: 2006-03-27 10:24:25 End queue run: pid=9142
Mar 27 10:24:40 stiffy [4294742.153000] BUG: soft lockup detected on CPU#0!
Mar 27 10:24:40 stiffy [4294742.153000]  [<c013fdc1>] softlockup_tick+0x91/0xc0
Mar 27 10:24:40 stiffy [4294742.153000]  [<c01247a3>] update_process_times+0x82/0xb7
Mar 27 10:24:40 stiffy [4294742.153000]  [<c010677e>] timer_interrupt+0x43/0xda
Mar 27 10:24:40 stiffy [4294742.153000]  [<c013ff3c>] handle_IRQ_event+0x39/0x6d
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0140003>] __do_IRQ+0x93/0x124
Mar 27 10:24:40 stiffy [4294742.153000]  [<c010524e>] do_IRQ+0x8a/0xa6
Mar 27 10:24:40 stiffy [4294742.153000]  [<c011683a>] scheduler_tick+0x25/0x339
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0103a62>] common_interrupt+0x1a/0x20
Mar 27 10:24:40 stiffy [4294742.153000]  [<e084007b>] acpi_thermal_set_cooling_mode+0x3/0x97 [thermal]
Mar 27 10:24:40 stiffy [4294742.153000]  [<c013ff2c>] handle_IRQ_event+0x29/0x6d
Mar 27 10:24:40 stiffy [4294742.153000]  [<c01078df>] mask_and_ack_8259A+0x67/0x116
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0140003>] __do_IRQ+0x93/0x124
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0105225>] do_IRQ+0x61/0xa6
Mar 27 10:24:40 stiffy [4294742.153000]  =======================
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0103a62>] common_interrupt+0x1a/0x20
Mar 27 10:24:40 stiffy [4294742.153000]  [<c01203b2>] __do_softirq+0x3a/0x9c
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0105386>] do_softirq+0x70/0x74
Mar 27 10:24:40 stiffy [4294742.153000]  =======================
Mar 27 10:24:40 stiffy [4294742.153000]  [<c01204d4>] irq_exit+0x38/0x3a
Mar 27 10:24:40 stiffy [4294742.153000]  [<c010522c>] do_IRQ+0x68/0xa6
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0103a62>] common_interrupt+0x1a/0x20
Mar 27 10:24:40 stiffy [4294742.153000]  [<c02600a5>] serial_out+0x27/0x55
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0262170>] serial8250_startup+0x1e4/0x482
Mar 27 10:24:40 stiffy [4294742.153000]  [<c025cfab>] uart_startup+0xba/0x19c
Mar 27 10:24:40 stiffy [4294742.153000]  [<c025f094>] uart_open+0xb7/0x143
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0247715>] tty_open+0x1e3/0x32e
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0247532>] tty_open+0x0/0x32e
Mar 27 10:24:40 stiffy [4294742.153000]  [<c016d713>] chrdev_open+0x113/0x218
Mar 27 10:24:40 stiffy [4294742.153000]  [<c016d600>] chrdev_open+0x0/0x218
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0162977>] __dentry_open+0x19b/0x28c
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0162b99>] nameidata_to_filp+0x37/0x4f
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0162ab8>] do_filp_open+0x50/0x56
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0162e70>] do_sys_open+0x63/0xfe
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0162f32>] sys_open+0x27/0x2b
Mar 27 10:24:40 stiffy [4294742.153000]  [<c0102fd3>] sysenter_past_esp+0x54/0x75
Mar 27 10:24:40 stiffy [4294746.319000] pccard: card ejected from slot 0
Mar 27 10:24:40 stiffy [4294746.319000] DEV: Unregistering device. ID = '0.0'
Mar 27 10:24:40 stiffy [4294746.319000] bus pcmcia: remove device 0.0
Mar 27 10:24:40 stiffy [4294746.320000] CLASS: Unregistering class device. ID = 'ttyS2'
Mar 27 10:24:40 stiffy [4294746.320000] class_uevent - name = ttyS2
Mar 27 10:24:40 stiffy [4294746.320000] class_device_create_uevent called for ttyS2
Mar 27 10:24:40 stiffy [4294746.320000] device class 'ttyS2': release.
Mar 27 10:24:40 stiffy [4294746.320000] class_device_create_release called for ttyS2
Mar 27 10:24:40 stiffy [4294746.320000] CLASS: registering class device: ID = 'ttyS2'
Mar 27 10:24:40 stiffy [4294746.320000] class_uevent - name = ttyS2
Mar 27 10:24:40 stiffy [4294746.320000] class_device_create_uevent called for ttyS2
Mar 27 10:24:40 stiffy [4294746.320000] CLASS: Unregistering class device. ID = 'ttyS3'
Mar 27 10:24:40 stiffy [4294746.320000] class_uevent - name = ttyS3
Mar 27 10:24:40 stiffy [4294746.320000] class_device_create_uevent called for ttyS3
Mar 27 10:24:40 stiffy [4294746.320000] device class 'ttyS3': release.
Mar 27 10:24:40 stiffy [4294746.320000] class_device_create_release called for ttyS3
Mar 27 10:24:40 stiffy [4294746.323000] CLASS: registering class device: ID = 'ttyS3'
Mar 27 10:24:40 stiffy [4294746.324000] class_uevent - name = ttyS3
Mar 27 10:24:40 stiffy [4294746.324000] class_device_create_uevent called for ttyS3
Mar 27 10:24:40 stiffy [4294746.324000] PM: Removing info for pcmcia:0.0
