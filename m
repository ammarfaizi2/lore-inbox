Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbTHZOxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTHZO2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:28:13 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:31372 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262701AbTHZO0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:26:04 -0400
Date: Tue, 26 Aug 2003 07:25:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1150] New: Sony CliX USB-Storage doesn't work
Message-ID: <10250000.1061907934@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1150

           Summary: Sony Clié USB-Storage doesn't work
    Kernel Version: 2.6.0-test4
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: skuld@goddess-gate.com


Distribution:
  Gentoo Linux

Hardware Environment:
  i386
  Sony Clié NR70V with Memory Stick
  lspci : 
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
00:0b.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon
7500]


Software Environment:
Problem Description:

I have a Sony PDA Clié NR70V, which has a
memory stick accessible via USB.  It was working fine under 2.4.*
kernels, but since kernel 2.6.0-test2 I get the following behaviour (not sure
about older kernels):

When I start USB Storage application from the PDA, I get in /var/log/message

Aug 26 13:38:51 skuld drivers/usb/host/uhci-hcd.c: b000: wakeup_hc
Aug 26 13:38:51 skuld hub 2-0:0: port 2, status 101, change 1, 12 Mb/s
Aug 26 13:38:51 skuld hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
Aug 26 13:38:51 skuld hub 2-0:0: new USB device on port 2, assigned address 6
Aug 26 13:38:51 skuld usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=0
Aug 26 13:38:51 skuld drivers/usb/core/message.c: USB device number 6 default
language ID 0x409
Aug 26 13:38:51 skuld usb 2-2: Product: Sony PEG Mass Storage
Aug 26 13:38:51 skuld usb 2-2: Manufacturer: Sony
Aug 26 13:38:51 skuld drivers/usb/core/usb.c: usb_hotplug
Aug 26 13:38:51 skuld PM: Adding info for usb:2-2
Aug 26 13:38:51 skuld usb 2-2: usb_new_device - registering interface 2-2:0
Aug 26 13:38:51 skuld drivers/usb/core/usb.c: usb_hotplug
Aug 26 13:38:51 skuld usbserial 2-2:0: usb_probe_interface
Aug 26 13:38:51 skuld usbserial 2-2:0: usb_probe_interface - got id
Aug 26 13:38:51 skuld PM: Adding info for usb:2-2:0

And when I modprobe usb-storage, I get : 

Aug 26 13:39:32 skuld Initializing USB Mass Storage driver...
Aug 26 13:39:32 skuld usb-storage 2-2:0: usb_probe_interface
Aug 26 13:39:32 skuld usb-storage 2-2:0: usb_probe_interface - got id
Aug 26 13:39:32 skuld usb-storage: USB Mass Storage device detected
Aug 26 13:39:32 skuld usb-storage: act_altsetting is 0, id_index is 93
Aug 26 13:39:32 skuld usb-storage: -- associate_dev
Aug 26 13:39:32 skuld usb-storage: Transport: Control/Bulk/Interrupt
Aug 26 13:39:32 skuld usb-storage: Protocol: 8070i
Aug 26 13:39:32 skuld usb-storage: Endpoints: In: 0xce2294a8 Out: 0xce229494
Int: 0xce229480 (Period 1)
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld scsi2 : SCSI emulation for USB Mass Storage devices
Aug 26 13:39:32 skuld PM: Adding info for No Bus:host2
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Command INQUIRY (6 bytes)
Aug 26 13:39:32 skuld usb-storage:  12 00 00 00 24 00
Aug 26 13:39:32 skuld usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21
value=0000 index=00 len=12
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 12/12
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: Call to usb_stor_ctrl_transfer() returned 0
Aug 26 13:39:32 skuld usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 36/36
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: CBI data stage result is 0x0
Aug 26 13:39:32 skuld usb-storage: usb_stor_intr_transfer: xfer 2 bytes
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 2/2
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: Got interrupt data (0x28, 0x0)
Aug 26 13:39:32 skuld usb-storage: CBI IRQ data showed reserved bType 40
Aug 26 13:39:32 skuld usb-storage: -- transport indicates error, resetting
Aug 26 13:39:32 skuld usb-storage: usb_stor_CB_reset called
Aug 26 13:39:32 skuld usb-storage: usb_stor_control_msg: rq=00 rqtype=21
value=0000 index=00 len=12
Aug 26 13:39:32 skuld usb-storage: Soft reset failed: -32
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x70000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Command INQUIRY (6 bytes)
Aug 26 13:39:32 skuld usb-storage:  12 00 00 00 24 00
Aug 26 13:39:32 skuld usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21
value=0000 index=00 len=12
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 12/12
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: Call to usb_stor_ctrl_transfer() returned 0
Aug 26 13:39:32 skuld usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 36/36
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: CBI data stage result is 0x0
Aug 26 13:39:32 skuld usb-storage: usb_stor_intr_transfer: xfer 2 bytes
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 2/2
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: Got interrupt data (0x28, 0x0)
Aug 26 13:39:32 skuld usb-storage: CBI IRQ data showed reserved bType 40
Aug 26 13:39:32 skuld usb-storage: -- transport indicates error, resetting
Aug 26 13:39:32 skuld usb-storage: usb_stor_CB_reset called
Aug 26 13:39:32 skuld usb-storage: usb_stor_control_msg: rq=00 rqtype=21
value=0000 index=00 len=12
Aug 26 13:39:32 skuld usb-storage: Soft reset failed: -32
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x70000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Command INQUIRY (6 bytes)
Aug 26 13:39:32 skuld usb-storage:  12 00 00 00 24 00
Aug 26 13:39:32 skuld usb-storage: usb_stor_ctrl_transfer: rq=00 rqtype=21
value=0000 index=00 len=12
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 12/12
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: Call to usb_stor_ctrl_transfer() returned 0
Aug 26 13:39:32 skuld usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 36/36
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: CBI data stage result is 0x0
Aug 26 13:39:32 skuld usb-storage: usb_stor_intr_transfer: xfer 2 bytes
Aug 26 13:39:32 skuld usb-storage: Status code 0; transferred 2/2
Aug 26 13:39:32 skuld usb-storage: -- transfer complete
Aug 26 13:39:32 skuld usb-storage: Got interrupt data (0x28, 0x0)
Aug 26 13:39:32 skuld usb-storage: CBI IRQ data showed reserved bType 40
Aug 26 13:39:32 skuld usb-storage: -- transport indicates error, resetting
Aug 26 13:39:32 skuld usb-storage: usb_stor_CB_reset called
Aug 26 13:39:32 skuld usb-storage: usb_stor_control_msg: rq=00 rqtype=21
value=0000 index=00 len=12
Aug 26 13:39:32 skuld usb-storage: Soft reset failed: -32
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x70000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Bad target number (1:0)
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x40000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Bad target number (2:0)
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x40000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Bad target number (3:0)
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x40000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Bad target number (4:0)
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x40000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Bad target number (5:0)
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x40000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Bad target number (6:0)
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x40000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld usb-storage: queuecommand called
Aug 26 13:39:32 skuld usb-storage: *** thread awakened.
Aug 26 13:39:32 skuld usb-storage: Bad target number (7:0)
Aug 26 13:39:32 skuld usb-storage: scsi cmd done, result=0x40000
Aug 26 13:39:32 skuld usb-storage: *** thread sleeping.
Aug 26 13:39:32 skuld WARNING: USB Mass Storage data integrity not assured
Aug 26 13:39:32 skuld USB Mass Storage device found at 6
Aug 26 13:39:32 skuld drivers/usb/core/usb.c: registered new driver usb-storage
Aug 26 13:39:32 skuld USB Mass Storage support registered.


Then, I don't get any /dev/sd*1 device.

Steps to reproduce:


