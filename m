Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWBHK3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWBHK3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 05:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWBHK3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 05:29:13 -0500
Received: from mail.gmx.de ([213.165.64.21]:5087 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932482AbWBHK3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 05:29:10 -0500
X-Authenticated: #6053682
Message-ID: <43E9C859.6070402@gmx.net>
Date: Wed, 08 Feb 2006 11:30:49 +0100
From: Jan Christoph Uhde <UhdeJC@gmx.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM]: usb-mass-storage - amd64
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------090905090901000208090908"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090905090901000208090908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
i am not able to mount any UMS device. Enduring this Bug for more than a moth
i think it is time to ask for Your help because i am not able to resolve this
myself:(

oberon@obi:~$ gcc --version
gcc (GCC) 4.0.3 20060128 (prerelease) (Debian 4.0.2-8)

oberon@obi:~$ ld -v
GNU ld version 2.16.91 20060118 Debian GNU/Linux

oberon@obi:~$ uname -a
Linux obi 2.6.15.3obi-amd64 #2 Tue Feb 7 17:40:41 CET 2006 x86_64 GNU/Linux

controller:
0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
        Memory at d5001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
(prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 19
        Memory at feb00000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

- CPU: AMD Athlon(tm) 64 Processor 3200+
- MemTotal:      3089104 kB (4gb on board)
- The motherboard is an asus A8N-SLI
- Hardware works fine (tested with win2k)

I'll append SysLog messages created when running different kernel versions
(2.6.15.3, 2.6.16-rc1-mm5, 2.6.16-rc2)

Please tell me if You need more information and how to obtain it:)

your Jan

--------------090905090901000208090908
Content-Type: text/plain;
 name="syslog-15.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog-15.3"

==> /var/log/messages <==
Feb  7 17:49:08 obi kernel:     duplex mode:     full
Feb  7 17:49:08 obi kernel:     flowctrl:        symmetric
Feb  7 17:49:08 obi kernel:     irq moderation:  disabled
Feb  7 17:49:08 obi kernel:     scatter-gather:  enabled
Feb  7 17:49:08 obi hpiod: 0.9.7 accepting connections at 40909... 
Feb  7 17:49:12 obi lpd[4404]: restarted
Feb  7 17:49:13 obi kernel: NET: Registered protocol family 10
Feb  7 17:49:13 obi kernel: lo: Disabled Privacy Extensions
Feb  7 17:49:13 obi kernel: IPv6 over IPv4 tunneling driver
Feb  7 17:49:13 obi Xprt_64: cat: /var/run/Xprt_0.pid: No such file or directory

==> /var/log/syslog <==
Feb  7 17:49:13 obi /usr/sbin/cron[4606]: (CRON) STARTUP (fork ok)
Feb  7 17:49:14 obi /usr/sbin/cron[4606]: (CRON) INFO (Running @reboot jobs)
Feb  7 17:49:14 obi gdm[4641]: gdm_config_parse: Chooser not found or it can't be executed by the GDM user
Feb  7 17:49:16 obi gdm[4647]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 17:49:20 obi gdm[4694]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 17:49:23 obi kernel: DMA write timed out
Feb  7 17:49:23 obi kernel: eth0: no IPv6 routers present
Feb  7 17:49:24 obi gdm[4701]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 17:49:24 obi gdm[4643]: deal_with_x_crashes: Running the XKeepsCrashing script
Feb  7 17:49:35 obi gdm[4643]: Failed to start X server several times in a short time period; disabling display :0
Feb  7 17:50:33 obi kernel: parport0: FIFO is stuck
Feb  7 17:50:33 obi kernel: parport0: BUSY timeout (1) in compat_write_block_pio

==> /var/log/messages <==
Feb  7 17:50:34 obi kernel: usb 1-1: new high speed USB device using ehci_hcd and address 6

==> /var/log/syslog <==
Feb  7 17:50:34 obi kernel: usb 1-1: new high speed USB device using ehci_hcd and address 6

==> /var/log/messages <==
Feb  7 17:50:41 obi kernel: scsi2 : SCSI emulation for USB Mass Storage devices

==> /var/log/syslog <==
Feb  7 17:50:41 obi kernel: usb-storage: USB Mass Storage device detected
Feb  7 17:50:41 obi kernel: usb-storage: -- associate_dev
Feb  7 17:50:41 obi kernel: usb-storage: Vendor: 0x0781, Product: 0x5150, Revision: 0x0020
Feb  7 17:50:41 obi kernel: usb-storage: Interface Subclass: 0x06, Protocol: 0x50
Feb  7 17:50:41 obi kernel: usb-storage: Transport: Bulk
Feb  7 17:50:41 obi kernel: usb-storage: Protocol: Transparent SCSI
Feb  7 17:50:41 obi kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Feb  7 17:50:41 obi kernel: usb-storage: *** thread sleeping.
Feb  7 17:50:41 obi kernel: usb-storage: device found at 6
Feb  7 17:50:41 obi kernel: usb-storage: waiting for device to settle before scanning
Feb  7 17:50:43 obi kernel: DMA write timed out

==> /var/log/messages <==
Feb  7 17:50:46 obi kernel:   Vendor: SanDisk   Model: Cruzer Mini       Rev: 0.2 
Feb  7 17:50:46 obi kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02

==> /var/log/syslog <==
Feb  7 17:50:46 obi kernel: usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
Feb  7 17:50:46 obi kernel: usb-storage: GetMaxLUN command result is 1, data is 0
Feb  7 17:50:46 obi kernel: usb-storage: queuecommand called
Feb  7 17:50:46 obi kernel: usb-storage: *** thread awakened.
Feb  7 17:50:46 obi kernel: usb-storage: Command INQUIRY (6 bytes)
Feb  7 17:50:46 obi kernel: usb-storage:  12 00 00 00 24 00
Feb  7 17:50:46 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
Feb  7 17:50:46 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 17:50:46 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 17:50:46 obi kernel: usb-storage: -- transfer complete
Feb  7 17:50:46 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 17:50:46 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 36 bytes, 1 entries
Feb  7 17:50:46 obi kernel: usb-storage: Status code 0; transferred 36/36
Feb  7 17:50:46 obi kernel: usb-storage: -- transfer complete
Feb  7 17:50:46 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 17:50:46 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 17:50:46 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 17:50:46 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 17:50:46 obi kernel: usb-storage: -- transfer complete
Feb  7 17:50:46 obi kernel: usb-storage: Bulk status result = 0
Feb  7 17:50:46 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat 0x0
Feb  7 17:50:46 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 17:50:46 obi kernel: usb-storage: *** thread sleeping.
Feb  7 17:50:46 obi kernel:   Vendor: SanDisk   Model: Cruzer Mini       Rev: 0.2 
Feb  7 17:50:46 obi kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb  7 17:50:46 obi kernel: usb-storage: queuecommand called
Feb  7 17:50:46 obi kernel: usb-storage: *** thread awakened.
Feb  7 17:50:46 obi kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Feb  7 17:50:46 obi kernel: usb-storage:  00 00 00 00 00 00
Feb  7 17:50:46 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 6
Feb  7 17:50:46 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 17:50:46 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 17:50:46 obi kernel: usb-storage: -- transfer complete
Feb  7 17:50:46 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 17:50:46 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 17:50:46 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 17:50:49 obi udevd-event[4778]: wait_for_sysfs: waiting for '/sys/devices/pci0000:00/0000:00:02.1/usb1/1-1/1-1:1.0/host2/target2:0:0/2:0:0:0/bus' failed
Feb  7 17:50:53 obi udevd-event[4778]: wait_for_sysfs: waiting for '/sys/devices/pci0000:00/0000:00:02.1/usb1/1-1/1-1:1.0/host2/target2:0:0/2:0:0:0/ioerr_cnt' failed

==> /var/log/messages <==
Feb  7 17:51:16 obi kernel: usb 1-1: reset high speed USB device using ehci_hcd and address 6

==> /var/log/syslog <==
Feb  7 17:51:16 obi kernel: usb-storage: command_abort called
Feb  7 17:51:16 obi kernel: usb-storage: usb_stor_stop_transport called
Feb  7 17:51:16 obi kernel: usb-storage: -- cancelling URB
Feb  7 17:51:16 obi kernel: usb-storage: Status code -104; transferred 0/13
Feb  7 17:51:16 obi kernel: usb-storage: -- transfer cancelled
Feb  7 17:51:16 obi kernel: usb-storage: Bulk status result = 4
Feb  7 17:51:16 obi kernel: usb-storage: -- command was aborted
Feb  7 17:51:16 obi kernel: usb 1-1: reset high speed USB device using ehci_hcd and address 6

==> /var/log/messages <==
Feb  7 17:51:32 obi kernel: usb 1-1: device firmware changed
Feb  7 17:51:32 obi kernel: usb 1-1: USB disconnect, address 6
Feb  7 17:51:32 obi kernel: sd 2:0:0:0: scsi: Device offlined - not ready after error recovery
Feb  7 17:51:32 obi kernel: sdc : READ CAPACITY failed.
Feb  7 17:51:32 obi kernel: sdc : status=0, message=00, host=1, driver=00 
Feb  7 17:51:32 obi kernel: sdc : sense not available. 
Feb  7 17:51:32 obi kernel: sdc: Write Protect is off
Feb  7 17:51:32 obi kernel: sd 2:0:0:0: Attached scsi removable disk sdc
Feb  7 17:51:32 obi kernel: sd 2:0:0:0: Attached scsi generic sg2 type 0
Feb  7 17:51:32 obi kernel: usb 1-1: new high speed USB device using ehci_hcd and address 7

==> /var/log/syslog <==
Feb  7 17:51:32 obi kernel: usb 1-1: device firmware changed
Feb  7 17:51:32 obi kernel: usb-storage: usb_reset_device returns -19
Feb  7 17:51:32 obi kernel: usb-storage: usb_stor_Bulk_reset called
Feb  7 17:51:32 obi kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Feb  7 17:51:32 obi kernel: usb-storage: Soft reset failed: -19
Feb  7 17:51:32 obi kernel: usb-storage: scsi command aborted
Feb  7 17:51:32 obi kernel: usb-storage: *** thread sleeping.
Feb  7 17:51:32 obi kernel: usb 1-1: USB disconnect, address 6
Feb  7 17:51:32 obi kernel: usb-storage: storage_disconnect() called
Feb  7 17:51:32 obi kernel: usb-storage: usb_stor_stop_transport called
Feb  7 17:51:32 obi kernel: usb-storage: queuecommand called
Feb  7 17:51:32 obi kernel: usb-storage: Fail command during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: device_reset called
Feb  7 17:51:32 obi kernel: usb-storage: usb_stor_Bulk_reset called
Feb  7 17:51:32 obi kernel: usb-storage: No reset during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: bus_reset called
Feb  7 17:51:32 obi kernel: usb-storage: No reset during disconnect
Feb  7 17:51:32 obi kernel: sd 2:0:0:0: scsi: Device offlined - not ready after error recovery
Feb  7 17:51:32 obi kernel: sd 2:0:0:0: rejecting I/O to offline device
Feb  7 17:51:32 obi last message repeated 2 times
Feb  7 17:51:32 obi kernel: sdc : READ CAPACITY failed.
Feb  7 17:51:32 obi kernel: sdc : status=0, message=00, host=1, driver=00 
Feb  7 17:51:32 obi kernel: sdc : sense not available. 
Feb  7 17:51:32 obi kernel: sd 2:0:0:0: rejecting I/O to offline device
Feb  7 17:51:32 obi kernel: sdc: Write Protect is off
Feb  7 17:51:32 obi kernel: sdc: Mode Sense: 00 00 00 00
Feb  7 17:51:32 obi kernel: sdc: assuming drive cache: write through
Feb  7 17:51:32 obi kernel: sd 2:0:0:0: Attached scsi removable disk sdc
Feb  7 17:51:32 obi kernel: sd 2:0:0:0: Attached scsi generic sg2 type 0
Feb  7 17:51:32 obi kernel: usb-storage: queuecommand called
Feb  7 17:51:32 obi kernel: usb-storage: Fail command during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: queuecommand called
Feb  7 17:51:32 obi kernel: usb-storage: Fail command during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: queuecommand called
Feb  7 17:51:32 obi kernel: usb-storage: Fail command during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: queuecommand called
Feb  7 17:51:32 obi kernel: usb-storage: Fail command during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: queuecommand called
Feb  7 17:51:32 obi kernel: usb-storage: Fail command during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: queuecommand called
Feb  7 17:51:32 obi kernel: usb-storage: Fail command during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: queuecommand called
Feb  7 17:51:32 obi kernel: usb-storage: Fail command during disconnect
Feb  7 17:51:32 obi kernel: usb-storage: device scan complete
Feb  7 17:51:32 obi kernel: usb-storage: -- usb_stor_release_resources
Feb  7 17:51:32 obi kernel: usb-storage: -- sending exit command to thread
Feb  7 17:51:32 obi kernel: usb-storage: -- dissociate_dev
Feb  7 17:51:32 obi kernel: usb-storage: *** thread awakened.
Feb  7 17:51:32 obi kernel: usb-storage: -- exiting
Feb  7 17:51:32 obi kernel: usb 1-1: new high speed USB device using ehci_hcd and address 7
Feb  7 17:51:53 obi kernel: parport0: FIFO is stuck
Feb  7 17:51:53 obi kernel: parport0: BUSY timeout (1) in compat_write_block_pio
Feb  7 17:52:03 obi kernel: DMA write timed out




--------------090905090901000208090908
Content-Type: text/plain;
 name="syslog-16-rc1-mm5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog-16-rc1-mm5"

==> /var/log/messages <==
Feb  7 19:11:31 obi kernel:     flowctrl:        symmetric
Feb  7 19:11:31 obi kernel:     irq moderation:  disabled
Feb  7 19:11:31 obi kernel:     scatter-gather:  disabled
Feb  7 19:11:31 obi kernel:     tx-checksum:     disabled
Feb  7 19:11:31 obi kernel:     rx-checksum:     disabled
Feb  7 19:11:32 obi hpiod: 0.9.7 accepting connections at 36598... 
Feb  7 19:11:35 obi lpd[4120]: restarted
Feb  7 19:11:36 obi kernel: NET: Registered protocol family 10
Feb  7 19:11:36 obi kernel: lo: Disabled Privacy Extensions
Feb  7 19:11:36 obi kernel: IPv6 over IPv4 tunneling driver

==> /var/log/syslog <==
Feb  7 19:11:36 obi /usr/sbin/cron[4308]: (CRON) STARTUP (fork ok)
Feb  7 19:11:37 obi /usr/sbin/cron[4308]: (CRON) INFO (Running @reboot jobs)
Feb  7 19:11:37 obi gdm[4330]: gdm_config_parse: Chooser not found or it can't be executed by the GDM user
Feb  7 19:11:39 obi gdm[4360]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 19:11:43 obi gdm[4407]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 19:11:46 obi kernel: DMA write timed out
Feb  7 19:11:46 obi kernel: eth0: no IPv6 routers present
Feb  7 19:11:48 obi gdm[4414]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 19:11:48 obi gdm[4356]: deal_with_x_crashes: Running the XKeepsCrashing script
Feb  7 19:11:50 obi gdm[4356]: Failed to start X server several times in a short time period; disabling display :0
Feb  7 19:12:56 obi kernel: parport0: FIFO is stuck
Feb  7 19:12:56 obi kernel: parport0: BUSY timeout (1) in compat_write_block_pio

==> /var/log/messages <==
Feb  7 19:13:01 obi kernel: usb 1-1: new high speed USB device using ehci_hcd and address 6

==> /var/log/syslog <==
Feb  7 19:13:01 obi kernel: usb 1-1: new high speed USB device using ehci_hcd and address 6
Feb  7 19:13:06 obi kernel: DMA write timed out

==> /var/log/messages <==
Feb  7 19:13:07 obi kernel: usb 1-1: new device found, idVendor=0781, idProduct=5150
Feb  7 19:13:07 obi kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=3
Feb  7 19:13:07 obi kernel: usb 1-1: Product: Cruzer Mini
Feb  7 19:13:07 obi kernel: usb 1-1: Manufacturer: SanDisk Corporation
Feb  7 19:13:07 obi kernel: usb 1-1: SerialNumber: SNDK9B84841265A06501
Feb  7 19:13:07 obi kernel: usb 1-1: configuration #1 chosen from 1 choice
Feb  7 19:13:07 obi kernel: scsi2 : SCSI emulation for USB Mass Storage devices

==> /var/log/syslog <==
Feb  7 19:13:07 obi kernel: usb 1-1: new device found, idVendor=0781, idProduct=5150
Feb  7 19:13:07 obi kernel: usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=3
Feb  7 19:13:07 obi kernel: usb 1-1: Product: Cruzer Mini
Feb  7 19:13:07 obi kernel: usb 1-1: Manufacturer: SanDisk Corporation
Feb  7 19:13:07 obi kernel: usb 1-1: SerialNumber: SNDK9B84841265A06501
Feb  7 19:13:07 obi kernel: usb 1-1: configuration #1 chosen from 1 choice
Feb  7 19:13:07 obi kernel: usb-storage: USB Mass Storage device detected
Feb  7 19:13:07 obi kernel: usb-storage: -- associate_dev
Feb  7 19:13:07 obi kernel: usb-storage: Vendor: 0x0781, Product: 0x5150, Revision: 0x0020
Feb  7 19:13:07 obi kernel: usb-storage: Interface Subclass: 0x06, Protocol: 0x50
Feb  7 19:13:07 obi kernel: usb-storage: Transport: Bulk
Feb  7 19:13:07 obi kernel: usb-storage: Protocol: Transparent SCSI
Feb  7 19:13:07 obi kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Feb  7 19:13:07 obi kernel: usb-storage: *** thread sleeping.
Feb  7 19:13:07 obi kernel: usb-storage: device found at 6
Feb  7 19:13:07 obi kernel: usb-storage: waiting for device to settle before scanning

==> /var/log/messages <==
Feb  7 19:13:12 obi kernel:   Vendor: SanDisk   Model: Cruzer Mini       Rev: 0.2 
Feb  7 19:13:12 obi kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02

==> /var/log/syslog <==
Feb  7 19:13:12 obi kernel: usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
Feb  7 19:13:12 obi kernel: usb-storage: GetMaxLUN command result is 1, data is 0
Feb  7 19:13:12 obi kernel: usb-storage: queuecommand called
Feb  7 19:13:12 obi kernel: usb-storage: *** thread awakened.
Feb  7 19:13:12 obi kernel: usb-storage: Command INQUIRY (6 bytes)
Feb  7 19:13:12 obi kernel: usb-storage:  12 00 00 00 24 00
Feb  7 19:13:12 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
Feb  7 19:13:12 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 19:13:12 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 19:13:12 obi kernel: usb-storage: -- transfer complete
Feb  7 19:13:12 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 19:13:12 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 36 bytes, 1 entries
Feb  7 19:13:12 obi kernel: usb-storage: Status code 0; transferred 36/36
Feb  7 19:13:12 obi kernel: usb-storage: -- transfer complete
Feb  7 19:13:12 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 19:13:12 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 19:13:12 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 19:13:12 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 19:13:12 obi kernel: usb-storage: -- transfer complete
Feb  7 19:13:12 obi kernel: usb-storage: Bulk status result = 0
Feb  7 19:13:12 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat 0x0
Feb  7 19:13:12 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 19:13:12 obi kernel: usb-storage: *** thread sleeping.
Feb  7 19:13:12 obi kernel:   Vendor: SanDisk   Model: Cruzer Mini       Rev: 0.2 
Feb  7 19:13:12 obi kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb  7 19:13:12 obi kernel: usb-storage: queuecommand called
Feb  7 19:13:12 obi kernel: usb-storage: *** thread awakened.
Feb  7 19:13:12 obi kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Feb  7 19:13:12 obi kernel: usb-storage:  00 00 00 00 00 00
Feb  7 19:13:12 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 6
Feb  7 19:13:12 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 19:13:12 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 19:13:12 obi kernel: usb-storage: -- transfer complete
Feb  7 19:13:12 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 19:13:12 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 19:13:12 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 19:13:16 obi udevd-event[4505]: wait_for_sysfs: waiting for '/sys/devices/pci0000:00/0000:00:02.1/usb1/1-1/1-1:1.0/host2/target2:0:0/2:0:0:0/bus' failed
Feb  7 19:13:19 obi udevd-event[4505]: wait_for_sysfs: waiting for '/sys/devices/pci0000:00/0000:00:02.1/usb1/1-1/1-1:1.0/host2/target2:0:0/2:0:0:0/ioerr_cnt' failed

==> /var/log/messages <==
Feb  7 19:13:42 obi kernel: usb 1-1: reset high speed USB device using ehci_hcd and address 6

==> /var/log/syslog <==
Feb  7 19:13:42 obi kernel: usb-storage: command_abort called
Feb  7 19:13:42 obi kernel: usb-storage: usb_stor_stop_transport called
Feb  7 19:13:42 obi kernel: usb-storage: -- cancelling URB
Feb  7 19:13:42 obi kernel: usb-storage: Status code -104; transferred 0/13
Feb  7 19:13:42 obi kernel: usb-storage: -- transfer cancelled
Feb  7 19:13:42 obi kernel: usb-storage: Bulk status result = 4
Feb  7 19:13:42 obi kernel: usb-storage: -- command was aborted
Feb  7 19:13:42 obi kernel: usb 1-1: reset high speed USB device using ehci_hcd and address 6




--------------090905090901000208090908
Content-Type: text/plain;
 name="syslog-16-rc2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog-16-rc2"

==> /var/log/messages <==
Feb  7 18:13:13 obi kernel:     flowctrl:        symmetric
Feb  7 18:13:13 obi kernel:     irq moderation:  disabled
Feb  7 18:13:13 obi kernel:     scatter-gather:  disabled
Feb  7 18:13:13 obi kernel:     tx-checksum:     disabled
Feb  7 18:13:13 obi kernel:     rx-checksum:     disabled
Feb  7 18:13:14 obi hpiod: 0.9.7 accepting connections at 44473... 
Feb  7 18:13:18 obi lpd[4209]: restarted
Feb  7 18:13:18 obi kernel: NET: Registered protocol family 10
Feb  7 18:13:18 obi kernel: lo: Disabled Privacy Extensions
Feb  7 18:13:18 obi kernel: IPv6 over IPv4 tunneling driver

==> /var/log/syslog <==
Feb  7 18:13:19 obi /usr/sbin/cron[4420]: (CRON) STARTUP (fork ok)
Feb  7 18:13:19 obi /usr/sbin/cron[4420]: (CRON) INFO (Running @reboot jobs)
Feb  7 18:13:19 obi gdm[4443]: gdm_config_parse: Chooser not found or it can't be executed by the GDM user
Feb  7 18:13:21 obi gdm[4449]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 18:13:26 obi gdm[4496]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 18:13:28 obi kernel: eth0: no IPv6 routers present
Feb  7 18:13:28 obi kernel: DMA write timed out
Feb  7 18:13:30 obi gdm[4503]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
Feb  7 18:13:30 obi gdm[4445]: deal_with_x_crashes: Running the XKeepsCrashing script
Feb  7 18:13:37 obi gdm[4445]: Failed to start X server several times in a short time period; disabling display :0

==> /var/log/messages <==
Feb  7 18:14:37 obi kernel: usb 1-1: new high speed USB device using ehci_hcd and address 6
Feb  7 18:14:37 obi kernel: usb 1-1: configuration #1 chosen from 1 choice
Feb  7 18:14:37 obi kernel: scsi2 : SCSI emulation for USB Mass Storage devices

==> /var/log/syslog <==
Feb  7 18:14:37 obi kernel: usb 1-1: new high speed USB device using ehci_hcd and address 6
Feb  7 18:14:37 obi kernel: usb 1-1: configuration #1 chosen from 1 choice
Feb  7 18:14:37 obi kernel: usb-storage: USB Mass Storage device detected
Feb  7 18:14:37 obi kernel: usb-storage: -- associate_dev
Feb  7 18:14:37 obi kernel: usb-storage: Vendor: 0x0781, Product: 0x5150, Revision: 0x0020
Feb  7 18:14:37 obi kernel: usb-storage: Interface Subclass: 0x06, Protocol: 0x50
Feb  7 18:14:37 obi kernel: usb-storage: Transport: Bulk
Feb  7 18:14:37 obi kernel: usb-storage: Protocol: Transparent SCSI
Feb  7 18:14:37 obi kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Feb  7 18:14:37 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:37 obi kernel: usb-storage: device found at 6
Feb  7 18:14:37 obi kernel: usb-storage: waiting for device to settle before scanning
Feb  7 18:14:38 obi kernel: parport0: FIFO is stuck
Feb  7 18:14:38 obi kernel: parport0: BUSY timeout (1) in compat_write_block_pio

==> /var/log/messages <==
Feb  7 18:14:42 obi kernel:   Vendor: SanDisk   Model: Cruzer Mini       Rev: 0.2 
Feb  7 18:14:42 obi kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb  7 18:14:42 obi kernel: SCSI device sdc: 2001888 512-byte hdwr sectors (1025 MB)
Feb  7 18:14:42 obi kernel: sdc: Write Protect is off
Feb  7 18:14:42 obi kernel: SCSI device sdc: 2001888 512-byte hdwr sectors (1025 MB)
Feb  7 18:14:42 obi kernel: sdc: Write Protect is off
Feb  7 18:14:42 obi kernel:  sdc:<7>usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel:  sdc1 sdc2
Feb  7 18:14:42 obi kernel: sd 2:0:0:0: Attached scsi removable disk sdc
Feb  7 18:14:42 obi kernel: sd 2:0:0:0: Attached scsi generic sg2 type 0

==> /var/log/syslog <==
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
Feb  7 18:14:42 obi kernel: usb-storage: GetMaxLUN command result is 1, data is 0
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command INQUIRY (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  12 00 00 00 24 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 36 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 36/36
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel:   Vendor: SanDisk   Model: Cruzer Mini       Rev: 0.2 
Feb  7 18:14:42 obi kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  00 00 00 00 00 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x2 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  25 00 00 00 00 00 00 00 00 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x3 L 8 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 8 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 8/8
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x3 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: SCSI device sdc: 2001888 512-byte hdwr sectors (1025 MB)
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command MODE_SENSE (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  1a 00 3f 00 c0 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x4 L 192 F 128 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 192 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code -121; transferred 4/192
Feb  7 18:14:42 obi kernel: usb-storage: -- short read transfer
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x1
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code -32; transferred 0/13
Feb  7 18:14:42 obi kernel: usb-storage: clearing endpoint halt for pipe 0xc0008680
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=81 len=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_clear_halt: result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW (2nd try)...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x4 R 188 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: sdc: Write Protect is off
Feb  7 18:14:42 obi kernel: sdc: Mode Sense: 03 00 00 00
Feb  7 18:14:42 obi kernel: sdc: assuming drive cache: write through
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  00 00 00 00 00 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x5 L 0 F 0 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x5 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  1e 00 00 00 01 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x6 L 0 F 0 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x6 R 0 Stat 0x1
Feb  7 18:14:42 obi kernel: usb-storage: -- transport indicates command failure
Feb  7 18:14:42 obi kernel: usb-storage: Issuing auto-REQUEST_SENSE
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x7 L 18 F 128 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 18/18
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x7 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: -- Result from auto-sense is 0
Feb  7 18:14:42 obi kernel: usb-storage: -- code: 0x70, key: 0x5, ASC: 0x24, ASCQ: 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Illegal Request: Invalid field in cdb
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x2
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  00 00 00 00 00 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x8 L 0 F 0 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x8 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  25 00 00 00 00 00 00 00 00 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x9 L 8 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 8 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 8/8
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x9 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: SCSI device sdc: 2001888 512-byte hdwr sectors (1025 MB)
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command MODE_SENSE (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  1a 00 3f 00 c0 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0xa L 192 F 128 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 192 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code -121; transferred 4/192
Feb  7 18:14:42 obi kernel: usb-storage: -- short read transfer
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x1
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code -32; transferred 0/13
Feb  7 18:14:42 obi kernel: usb-storage: clearing endpoint halt for pipe 0xc0008680
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=81 len=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_clear_halt: result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW (2nd try)...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0xa R 188 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: sdc: Write Protect is off
Feb  7 18:14:42 obi kernel: sdc: Mode Sense: 03 00 00 00
Feb  7 18:14:42 obi kernel: sdc: assuming drive cache: write through
Feb  7 18:14:42 obi kernel:  sdc:<7>usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 00 00 00 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0xb L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0xb R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel:  sdc1 sdc2
Feb  7 18:14:42 obi kernel: sd 2:0:0:0: Attached scsi removable disk sdc
Feb  7 18:14:42 obi kernel: sd 2:0:0:0: Attached scsi generic sg2 type 0
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Bad target number (1:0)
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x40000
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Bad target number (2:0)
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x40000
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Bad target number (3:0)
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x40000
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Bad target number (4:0)
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x40000
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Bad target number (5:0)
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x40000
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Bad target number (6:0)
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x40000
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Bad target number (7:0)
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x40000
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: device scan complete
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  00 00 00 00 00 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0xc L 0 F 0 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0xc R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d6 3f 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0xd L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0xd R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  00 00 00 00 00 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0xe L 0 F 0 Trg 0 LUN 0 CL 6
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0xe R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d7 17 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0xf L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0xf R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 1e 8b 20 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x10 L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x10 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 1e 8b d8 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x11 L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x11 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d7 1f 00 00 01 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x12 L 512 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 512/512
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x12 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 1e 8b a0 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x13 L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x13 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d6 df 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x14 L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x14 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d6 1f 00 00 01 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x15 L 512 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 512/512
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x15 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d6 20 00 00 01 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x16 L 512 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 512/512
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x16 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d6 21 00 00 06 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x17 L 3072 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 3072 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 3072/3072
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x17 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 1e 8a e0 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x18 L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x18 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 1e 8b d0 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x19 L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x19 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 1e 8a 50 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1a L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1a R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d7 20 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1b L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1b R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d7 0f 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1c L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1c R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d7 28 00 00 40 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1d L 32768 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 32768 bytes, 8 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 32768/32768
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1d R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d5 8f 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1e L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1e R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 17 d7 68 00 00 40 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x1f L 32768 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 32768 bytes, 5 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 32768/32768
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x1f R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 00 00 3f 00 00 08 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x20 L 4096 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 4096/4096
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x20 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 00 00 47 00 00 40 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x21 L 32768 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 32768 bytes, 4 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 32768/32768
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x21 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:42 obi kernel: usb-storage: queuecommand called
Feb  7 18:14:42 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:14:42 obi kernel: usb-storage: Command READ_10 (10 bytes)
Feb  7 18:14:42 obi kernel: usb-storage:  28 00 00 00 01 b7 00 00 28 00
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Command S 0x43425355 T 0x22 L 20480 F 128 Trg 0 LUN 0 CL 10
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 31/31
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk command transfer result=0
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_sglist: xfer 20480 bytes, 3 entries
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 20480/20480
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk data transfer result 0x0
Feb  7 18:14:42 obi kernel: usb-storage: Attempting to get CSW...
Feb  7 18:14:42 obi kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Feb  7 18:14:42 obi kernel: usb-storage: Status code 0; transferred 13/13
Feb  7 18:14:42 obi kernel: usb-storage: -- transfer complete
Feb  7 18:14:42 obi kernel: usb-storage: Bulk status result = 0
Feb  7 18:14:42 obi kernel: usb-storage: Bulk Status S 0x53425355 T 0x22 R 0 Stat 0x0
Feb  7 18:14:42 obi kernel: usb-storage: scsi cmd done, result=0x0
Feb  7 18:14:42 obi kernel: usb-storage: *** thread sleeping.
Feb  7 18:14:48 obi kernel: DMA write timed out

==> /var/log/messages <==
Feb  7 18:15:43 obi kernel: usb 1-1: USB disconnect, address 6

==> /var/log/syslog <==
Feb  7 18:15:43 obi kernel: usb 1-1: USB disconnect, address 6
Feb  7 18:15:43 obi kernel: usb-storage: storage_disconnect() called
Feb  7 18:15:43 obi kernel: usb-storage: usb_stor_stop_transport called
Feb  7 18:15:43 obi kernel: usb-storage: -- usb_stor_release_resources
Feb  7 18:15:43 obi kernel: usb-storage: -- sending exit command to thread
Feb  7 18:15:43 obi kernel: usb-storage: -- dissociate_dev
Feb  7 18:15:43 obi kernel: usb-storage: *** thread awakened.
Feb  7 18:15:43 obi kernel: usb-storage: -- exiting




--------------090905090901000208090908--
