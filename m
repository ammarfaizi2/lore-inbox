Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266261AbUAVNST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 08:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUAVNST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 08:18:19 -0500
Received: from dsl-213-023-011-163.arcor-ip.net ([213.23.11.163]:21701 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S266261AbUAVNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 08:18:12 -0500
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Thu, 22 Jan 2004 14:17:53 +0100
Message-ID: <m3hdyo2kce.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi all,

on an ASUS M2400N [*] with both plain vanilla Linux Kernel 2.6.1 and
2.6.1 + acpi-20031203, the machine appears to suspend to RAM without a
problem and it also apparently comes back, but the screen is dead.

Here is the dmesg output for the suspend to RAM / resume cycle:


--=-=-=
Content-Disposition: attachment

PM: Preparing system for suspend
Stopping tasks: ============================================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
Back to C!
PM: Finishing up.
PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:1f.5 to 64
AC'97 warm reset still in progress? [0xffffffff]
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x0
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x4
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x4
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x6
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x6
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xa
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xa
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xc
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xc
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0xe
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0xe
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x10
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x10
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x12
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x12
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x14
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x14
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x16
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x16
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x18
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x18
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x1a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x1a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x22
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x22
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x2c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x2c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x32
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x32
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 0: semaphore is not ready for register 0x3a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 0: semaphore is not ready for register 0x3a
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x0
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x20
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x26
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x2
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_write 1: semaphore is not ready for register 0x1c
codec_semaphore: semaphore is not ready [0xff][0xffffffff]
codec_read 1: semaphore is not ready for register 0x1c
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks...<6>Synaptics Touchpad, model: 1
 Firmware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
 done
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000175

--=-=-=
Content-Disposition: inline


When trying to get/set the LCD status via /proc/acpi/asus/lcd, dmesg
shows

 Asus ACPI: Error reading LCD status
 Asus ACPI: Error switching LCD

Suggestions, anyone? If you need more info, let me know.

Regards,
Georg


[*] /proc/acpi/asus/info:

Model reference    : M2X
SFUN value         : 0x0a7f
DSDT length        : 27945
DSDT checksum      : 212
DSDT revision      : 1
OEM id             : 0ABBD
OEM table id       : 0ABBD001
OEM revision       : 0x1
ASL comp vendor id : MSFT
ASL comp revision  : 0x100000d

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--=-=-=--
