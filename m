Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWBSTiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWBSTiE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWBSTiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:38:04 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:43182 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750882AbWBSTiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:38:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WsO+XQBSd6OlCN8mLf1HsmwSZrm8pCFSn9BbNEK/EH8sWjyppYcVcwkwIxvelqY5mEJObs4hnYs4ddozGQC/Of/8D1w41FR40AITWAW2xYF3lQ6RDUZ+pmc38fzOVqPisH6LGlH6HK2xMrdn+Qo0siRskMZyvmFNFSSp+68PR5o=
Message-ID: <8b12046a0602191137n12997938kd8404814f7c8e2ba@mail.gmail.com>
Date: Sun, 19 Feb 2006 19:37:58 +0000
From: "Subodh Shrivastava" <subodh.shrivastava@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ieee1394 failed to work after S3 resume.
Cc: bcollins@debian.org, scjody@modernduck.com,
       linux1394-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Suspend to Ram works fine here with 2.6.16-rc3 kernel except ieee1394
fails to resume properly.

2.6.16-rc3 #4 PREEMPT Sun Feb 19 18:13:07 GMT 2006 i686 Intel(R)
Pentium(R) M processor 1300MHz GNU/Linux
.config is available on request.

Feb 19 18:17:22 [kernel] ieee1394: sbp2: Logged into SBP-2 device
Feb 19 18:17:22 [kernel] ieee1394: Node 0-00:1023: Max speed [S400] -
Max payload [2048]
Feb 19 18:17:22 [kernel]   Vendor: PLEXTOR   Model: DVDR   PX-750A    Rev: 1.02
Feb 19 18:17:22 [kernel]   Type:   CD-ROM                            
ANSI SCSI revision: 00
Feb 19 18:17:22 [kernel] sr0: scsi3-mmc drive: 40x/40x writer dvd-ram
cd/rw xa/form2 cdda tray
Feb 19 18:17:22 [kernel] sr 0:0:0:0: Attached scsi CD-ROM sr0
Feb 19 18:17:22 [kernel] sr 0:0:0:0: Attached scsi generic sg0 type 5
Feb 19 18:17:22 [kernel] Adding 499928k swap on /dev/hda9. 
Priority:-1 extents:1 across:499928k
Feb 19 18:17:22 [kernel] EXT3 FS on hda8, internal journal
Feb 19 18:17:22 [kernel] ieee80211_crypt: registered algorithm 'WEP'
Feb 19 18:17:22 [kernel] ieee80211_crypt: registered algorithm 'CCMP'
Feb 19 18:17:22 [kernel] ipw2100: Intel(R) PRO/Wireless 2100 Network
Driver, 1.1.3
Feb 19 18:17:22 [kernel] ipw2100: Copyright(c) 2003-2005 Intel Corporation
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
Feb 19 18:17:22 [kernel] PCI: setting IRQ 11 as level-triggered
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:17:22 [kernel] ipw2100: Detected Intel PRO/Wireless 2100
Network Connection
Feb 19 18:17:22 [kernel] kjournald starting.  Commit interval 5 seconds
Feb 19 18:17:22 [kernel] EXT3 FS on hda6, internal journal
Feb 19 18:17:22 [kernel] EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 18:17:22 [kernel] kjournald starting.  Commit interval 5 seconds
Feb 19 18:17:22 [kernel] EXT3 FS on hda7, internal journal
Feb 19 18:17:22 [kernel] EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:17:22 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:17:22 [kernel] intel8x0_measure_ac97_clock: measured 55491 usecs
Feb 19 18:17:22 [kernel] intel8x0: clocking to 48000
Feb 19 18:18:03 [kernel] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Feb 19 18:18:11 [kernel] Stopping tasks:
===============================================================|
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:02:04.0 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Feb 19 18:18:11 [kernel] Intel machine check architecture supported.
Feb 19 18:18:11 [kernel] Intel machine check reporting enabled on CPU#0.
Feb 19 18:18:11 [kernel] Back to C!
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb 19 18:18:11 [kernel] usb usb2: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link
[LNKD] -> GSI 5 (level, low) -> IRQ 5
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb 19 18:18:11 [kernel] usb usb3: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb 19 18:18:11 [kernel] usb usb4: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link
[LNKH] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:06.0[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:06.1[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Enabling device 0000:02:07.0 (0000 -> 0002)
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:07.0[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] pnp: Failed to activate device 00:06.
Feb 19 18:18:11 [kernel] pnp: Failed to activate device 00:07.
Feb 19 18:18:11 [kernel] Restarting tasks...<6>usb 3-1: USB
disconnect, address 2
Feb 19 18:18:11 [kernel]  done
Feb 19 18:18:11 [kernel] usb 3-1: new low speed USB device using
uhci_hcd and address 3
Feb 19 18:18:11 [kernel] usb 3-1: configuration #1 chosen from 1 choice
Feb 19 18:18:11 [kernel] input: Logitech USB Receiver as /class/input/input4
Feb 19 18:18:11 [kernel] input: USB HID v1.10 Keyboard [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:18:11 [kernel] input: Logitech USB Receiver as /class/input/input5
Feb 19 18:18:11 [kernel] input: USB HID v1.10 Mouse [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:18:12 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:18:13 [kernel] intel8x0_measure_ac97_clock: measured 55410 usecs
Feb 19 18:18:13 [kernel] intel8x0: clocking to 48000
Feb 19 18:18:31 [kernel] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
Feb 19 18:18:31 [kernel] agpgart: Putting AGP V2 device at
0000:00:00.0 into 4x mode
Feb 19 18:18:31 [kernel] agpgart: Putting AGP V2 device at
0000:01:00.0 into 4x mode
Feb 19 18:18:31 [kernel] [drm] Loading R200 Microcode
Feb 19 18:18:41 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:18:41 [kernel] sr 0:0:0:0:
Feb 19 18:18:41 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:18:51 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:18:51 [kernel] sr 0:0:0:0:
Feb 19 18:18:51 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:18:51 [kernel] ieee1394: sbp2: reset requested
Feb 19 18:18:51 [kernel] ieee1394: sbp2: Generating sbp2 fetch agent reset
Feb 19 18:19:01 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:19:01 [kernel] sr 0:0:0:0:
Feb 19 18:19:01 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:19:01 [kernel] sr 0:0:0:0: scsi: Device offlined - not ready
after error recovery
Feb 19 18:19:01 [kernel] sr 0:0:0:0: rejecting I/O to offline device
Feb 19 18:19:41 [kernel] Stopping tasks:
====================================================|
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:02:04.0 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Feb 19 18:19:41 [kernel] Intel machine check architecture supported.
Feb 19 18:19:41 [kernel] Intel machine check reporting enabled on CPU#0.
Feb 19 18:19:41 [kernel] Back to C!
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb 19 18:19:41 [kernel] usb usb2: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link
[LNKD] -> GSI 5 (level, low) -> IRQ 5
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb 19 18:19:41 [kernel] usb usb3: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb 19 18:19:41 [kernel] usb usb4: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link
[LNKH] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:06.0[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:06.1[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Enabling device 0000:02:07.0 (0000 -> 0002)
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:07.0[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] pnp: Failed to activate device 00:06.
Feb 19 18:19:41 [kernel] pnp: Failed to activate device 00:07.
Feb 19 18:19:41 [kernel] Restarting tasks...<6>usb 3-1: USB
disconnect, address 3
Feb 19 18:19:41 [kernel] usb 3-1: new low speed USB device using
uhci_hcd and address 4
Feb 19 18:19:41 [kernel]  done
Feb 19 18:19:41 [kernel] usb 3-1: configuration #1 chosen from 1 choice
Feb 19 18:19:41 [kernel] input: Logitech USB Receiver as /class/input/input6
Feb 19 18:19:41 [kernel] input: USB HID v1.10 Keyboard [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:19:41 [kernel] input: Logitech USB Receiver as /class/input/input7
Feb 19 18:19:41 [kernel] input: USB HID v1.10 Mouse [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:19:42 [kernel] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
Feb 19 18:19:42 [kernel] agpgart: Putting AGP V2 device at
0000:00:00.0 into 4x mode

Feb 19 18:17:22 [kernel] ieee1394: sbp2: Logged into SBP-2 device
Feb 19 18:17:22 [kernel] ieee1394: Node 0-00:1023: Max speed [S400] -
Max payload [2048]
Feb 19 18:17:22 [kernel]   Vendor: PLEXTOR   Model: DVDR   PX-750A    Rev: 1.02
Feb 19 18:17:22 [kernel]   Type:   CD-ROM                            
ANSI SCSI revision: 00
Feb 19 18:17:22 [kernel] sr0: scsi3-mmc drive: 40x/40x writer dvd-ram
cd/rw xa/form2 cdda tray
Feb 19 18:17:22 [kernel] sr 0:0:0:0: Attached scsi CD-ROM sr0
Feb 19 18:17:22 [kernel] sr 0:0:0:0: Attached scsi generic sg0 type 5
Feb 19 18:17:22 [kernel] Adding 499928k swap on /dev/hda9. 
Priority:-1 extents:1 across:499928k
Feb 19 18:17:22 [kernel] EXT3 FS on hda8, internal journal
Feb 19 18:17:22 [kernel] ieee80211_crypt: registered algorithm 'WEP'
Feb 19 18:17:22 [kernel] ieee80211_crypt: registered algorithm 'CCMP'
Feb 19 18:17:22 [kernel] ipw2100: Intel(R) PRO/Wireless 2100 Network
Driver, 1.1.3
Feb 19 18:17:22 [kernel] ipw2100: Copyright(c) 2003-2005 Intel Corporation
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
Feb 19 18:17:22 [kernel] PCI: setting IRQ 11 as level-triggered
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:17:22 [kernel] ipw2100: Detected Intel PRO/Wireless 2100
Network Connection
Feb 19 18:17:22 [kernel] kjournald starting.  Commit interval 5 seconds
Feb 19 18:17:22 [kernel] EXT3 FS on hda6, internal journal
Feb 19 18:17:22 [kernel] EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 18:17:22 [kernel] kjournald starting.  Commit interval 5 seconds
Feb 19 18:17:22 [kernel] EXT3 FS on hda7, internal journal
Feb 19 18:17:22 [kernel] EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:17:22 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:17:22 [kernel] intel8x0_measure_ac97_clock: measured 55491 usecs
Feb 19 18:17:22 [kernel] intel8x0: clocking to 48000
Feb 19 18:18:03 [kernel] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Feb 19 18:18:11 [kernel] Stopping tasks:
===============================================================|
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:02:04.0 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Feb 19 18:18:11 [kernel] Intel machine check architecture supported.
Feb 19 18:18:11 [kernel] Intel machine check reporting enabled on CPU#0.
Feb 19 18:18:11 [kernel] Back to C!
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb 19 18:18:11 [kernel] usb usb2: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link
[LNKD] -> GSI 5 (level, low) -> IRQ 5
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb 19 18:18:11 [kernel] usb usb3: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb 19 18:18:11 [kernel] usb usb4: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link
[LNKH] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:06.0[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:06.1[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Enabling device 0000:02:07.0 (0000 -> 0002)
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:07.0[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] pnp: Failed to activate device 00:06.
Feb 19 18:18:11 [kernel] pnp: Failed to activate device 00:07.
Feb 19 18:18:11 [kernel] Restarting tasks...<6>usb 3-1: USB
disconnect, address 2
Feb 19 18:18:11 [kernel]  done
Feb 19 18:18:11 [kernel] usb 3-1: new low speed USB device using
uhci_hcd and address 3
Feb 19 18:18:11 [kernel] usb 3-1: configuration #1 chosen from 1 choice
Feb 19 18:18:11 [kernel] input: Logitech USB Receiver as /class/input/input4
Feb 19 18:18:11 [kernel] input: USB HID v1.10 Keyboard [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:18:11 [kernel] input: Logitech USB Receiver as /class/input/input5
Feb 19 18:18:11 [kernel] input: USB HID v1.10 Mouse [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:18:12 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:18:13 [kernel] intel8x0_measure_ac97_clock: measured 55410 usecs
Feb 19 18:18:13 [kernel] intel8x0: clocking to 48000
Feb 19 18:18:31 [kernel] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
Feb 19 18:18:31 [kernel] agpgart: Putting AGP V2 device at
0000:00:00.0 into 4x mode
Feb 19 18:18:31 [kernel] agpgart: Putting AGP V2 device at
0000:01:00.0 into 4x mode
Feb 19 18:18:31 [kernel] [drm] Loading R200 Microcode
Feb 19 18:18:41 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:18:41 [kernel] sr 0:0:0:0:
Feb 19 18:18:41 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:18:51 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:18:51 [kernel] sr 0:0:0:0:
Feb 19 18:18:51 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:18:51 [kernel] ieee1394: sbp2: reset requested
Feb 19 18:18:51 [kernel] ieee1394: sbp2: Generating sbp2 fetch agent reset
Feb 19 18:19:01 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:19:01 [kernel] sr 0:0:0:0:
Feb 19 18:19:01 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:19:01 [kernel] sr 0:0:0:0: scsi: Device offlined - not ready
after error recovery
Feb 19 18:19:01 [kernel] sr 0:0:0:0: rejecting I/O to offline device
Feb 19 18:19:41 [kernel] Stopping tasks:
====================================================|
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:02:04.0 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Feb 19 18:19:41 [kernel] Intel machine check architecture supported.
Feb 19 18:19:41 [kernel] Intel machine check reporting enabled on CPU#0.
Feb 19 18:19:41 [kernel] Back to C!
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb 19 18:19:41 [kernel] usb usb2: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link
[LNKD] -> GSI 5 (level, low) -> IRQ 5
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb 19 18:19:41 [kernel] usb usb3: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb 19 18:19:41 [kernel] usb usb4: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link
[LNKH] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:06.0[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:06.1[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Enabling device 0000:02:07.0 (0000 -> 0002)
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:07.0[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] pnp: Failed to activate device 00:06.
Feb 19 18:19:41 [kernel] pnp: Failed to activate device 00:07.
Feb 19 18:19:41 [kernel] Restarting tasks...<6>usb 3-1: USB
disconnect, address 3
Feb 19 18:19:41 [kernel] usb 3-1: new low speed USB device using
uhci_hcd and address 4
Feb 19 18:19:41 [kernel]  done
Feb 19 18:19:41 [kernel] usb 3-1: configuration #1 chosen from 1 choice
Feb 19 18:19:41 [kernel] input: Logitech USB Receiver as /class/input/input6
Feb 19 18:19:41 [kernel] input: USB HID v1.10 Keyboard [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:19:41 [kernel] input: Logitech USB Receiver as /class/input/input7
Feb 19 18:19:41 [kernel] input: USB HID v1.10 Mouse [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:19:42 [kernel] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
Feb 19 18:19:42 [kernel] agpgart: Putting AGP V2 device at
0000:00:00.0 into 4x mode



Feb 19 18:17:22 [kernel] ieee1394: sbp2: Logged into SBP-2 device
Feb 19 18:17:22 [kernel] ieee1394: Node 0-00:1023: Max speed [S400] -
Max payload [2048]
Feb 19 18:17:22 [kernel]   Vendor: PLEXTOR   Model: DVDR   PX-750A    Rev: 1.02
Feb 19 18:17:22 [kernel]   Type:   CD-ROM                            
ANSI SCSI revision: 00
Feb 19 18:17:22 [kernel] sr0: scsi3-mmc drive: 40x/40x writer dvd-ram
cd/rw xa/form2 cdda tray
Feb 19 18:17:22 [kernel] sr 0:0:0:0: Attached scsi CD-ROM sr0
Feb 19 18:17:22 [kernel] sr 0:0:0:0: Attached scsi generic sg0 type 5
Feb 19 18:17:22 [kernel] Adding 499928k swap on /dev/hda9. 
Priority:-1 extents:1 across:499928k
Feb 19 18:17:22 [kernel] EXT3 FS on hda8, internal journal
Feb 19 18:17:22 [kernel] ieee80211_crypt: registered algorithm 'WEP'
Feb 19 18:17:22 [kernel] ieee80211_crypt: registered algorithm 'CCMP'
Feb 19 18:17:22 [kernel] ipw2100: Intel(R) PRO/Wireless 2100 Network
Driver, 1.1.3
Feb 19 18:17:22 [kernel] ipw2100: Copyright(c) 2003-2005 Intel Corporation
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
Feb 19 18:17:22 [kernel] PCI: setting IRQ 11 as level-triggered
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:17:22 [kernel] ipw2100: Detected Intel PRO/Wireless 2100
Network Connection
Feb 19 18:17:22 [kernel] kjournald starting.  Commit interval 5 seconds
Feb 19 18:17:22 [kernel] EXT3 FS on hda6, internal journal
Feb 19 18:17:22 [kernel] EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 18:17:22 [kernel] kjournald starting.  Commit interval 5 seconds
Feb 19 18:17:22 [kernel] EXT3 FS on hda7, internal journal
Feb 19 18:17:22 [kernel] EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 18:17:22 [kernel] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:17:22 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:17:22 [kernel] intel8x0_measure_ac97_clock: measured 55491 usecs
Feb 19 18:17:22 [kernel] intel8x0: clocking to 48000
Feb 19 18:18:03 [kernel] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Feb 19 18:18:11 [kernel] Stopping tasks:
===============================================================|
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:02:04.0 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Feb 19 18:18:11 [kernel] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Feb 19 18:18:11 [kernel] Intel machine check architecture supported.
Feb 19 18:18:11 [kernel] Intel machine check reporting enabled on CPU#0.
Feb 19 18:18:11 [kernel] Back to C!
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb 19 18:18:11 [kernel] usb usb2: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link
[LNKD] -> GSI 5 (level, low) -> IRQ 5
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb 19 18:18:11 [kernel] usb usb3: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb 19 18:18:11 [kernel] usb usb4: root hub lost power or was reset
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link
[LNKH] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Feb 19 18:18:11 [kernel] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:06.0[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:06.1[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] PCI: Enabling device 0000:02:07.0 (0000 -> 0002)
Feb 19 18:18:11 [kernel] ACPI: PCI Interrupt 0000:02:07.0[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:18:11 [kernel] pnp: Failed to activate device 00:06.
Feb 19 18:18:11 [kernel] pnp: Failed to activate device 00:07.
Feb 19 18:18:11 [kernel] Restarting tasks...<6>usb 3-1: USB
disconnect, address 2
Feb 19 18:18:11 [kernel]  done
Feb 19 18:18:11 [kernel] usb 3-1: new low speed USB device using
uhci_hcd and address 3
Feb 19 18:18:11 [kernel] usb 3-1: configuration #1 chosen from 1 choice
Feb 19 18:18:11 [kernel] input: Logitech USB Receiver as /class/input/input4
Feb 19 18:18:11 [kernel] input: USB HID v1.10 Keyboard [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:18:11 [kernel] input: Logitech USB Receiver as /class/input/input5
Feb 19 18:18:11 [kernel] input: USB HID v1.10 Mouse [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:18:12 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:18:13 [kernel] intel8x0_measure_ac97_clock: measured 55410 usecs
Feb 19 18:18:13 [kernel] intel8x0: clocking to 48000
Feb 19 18:18:31 [kernel] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
Feb 19 18:18:31 [kernel] agpgart: Putting AGP V2 device at
0000:00:00.0 into 4x mode
Feb 19 18:18:31 [kernel] agpgart: Putting AGP V2 device at
0000:01:00.0 into 4x mode
Feb 19 18:18:31 [kernel] [drm] Loading R200 Microcode
Feb 19 18:18:41 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:18:41 [kernel] sr 0:0:0:0:
Feb 19 18:18:41 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:18:51 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:18:51 [kernel] sr 0:0:0:0:
Feb 19 18:18:51 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:18:51 [kernel] ieee1394: sbp2: reset requested
Feb 19 18:18:51 [kernel] ieee1394: sbp2: Generating sbp2 fetch agent reset
Feb 19 18:19:01 [kernel] ieee1394: sbp2: aborting sbp2 command
Feb 19 18:19:01 [kernel] sr 0:0:0:0:
Feb 19 18:19:01 [kernel]         command: cdb[0]=0x0: 00 00 00 00 00 00
Feb 19 18:19:01 [kernel] sr 0:0:0:0: scsi: Device offlined - not ready
after error recovery
Feb 19 18:19:01 [kernel] sr 0:0:0:0: rejecting I/O to offline device
Feb 19 18:19:41 [kernel] Stopping tasks:
====================================================|
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:02:04.0 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Feb 19 18:19:41 [kernel] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Feb 19 18:19:41 [kernel] Intel machine check architecture supported.
Feb 19 18:19:41 [kernel] Intel machine check reporting enabled on CPU#0.
Feb 19 18:19:41 [kernel] Back to C!
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb 19 18:19:41 [kernel] usb usb2: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link
[LNKD] -> GSI 5 (level, low) -> IRQ 5
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb 19 18:19:41 [kernel] usb usb3: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb 19 18:19:41 [kernel] usb usb4: root hub lost power or was reset
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link
[LNKH] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1d.7 to 64
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1e.0 to 64
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Setting latency timer of device 0000:00:1f.5 to 64
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link
[LNKA] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Enabling device 0000:02:04.0 (0000 -> 0002)
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:04.0[A] -> Link
[LNKE] -> GSI 11 (level, low) -> IRQ 11
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:06.0[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:06.1[A] -> Link
[LNKB] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] PCI: Enabling device 0000:02:07.0 (0000 -> 0002)
Feb 19 18:19:41 [kernel] ACPI: PCI Interrupt 0000:02:07.0[A] -> Link
[LNKC] -> GSI 10 (level, low) -> IRQ 10
Feb 19 18:19:41 [kernel] pnp: Failed to activate device 00:06.
Feb 19 18:19:41 [kernel] pnp: Failed to activate device 00:07.
Feb 19 18:19:41 [kernel] Restarting tasks...<6>usb 3-1: USB
disconnect, address 3
Feb 19 18:19:41 [kernel] usb 3-1: new low speed USB device using
uhci_hcd and address 4
Feb 19 18:19:41 [kernel]  done
Feb 19 18:19:41 [kernel] usb 3-1: configuration #1 chosen from 1 choice
Feb 19 18:19:41 [kernel] input: Logitech USB Receiver as /class/input/input6
Feb 19 18:19:41 [kernel] input: USB HID v1.10 Keyboard [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:19:41 [kernel] input: Logitech USB Receiver as /class/input/input7
Feb 19 18:19:41 [kernel] input: USB HID v1.10 Mouse [Logitech USB
Receiver] on usb-0000:00:1d.1-1
Feb 19 18:19:42 [kernel] agpgart: Found an AGP 2.0 compliant device at
0000:00:00.0.
Feb 19 18:19:42 [kernel] agpgart: Putting AGP V2 device at
0000:00:00.0 into 4x mode

--
Subodh
