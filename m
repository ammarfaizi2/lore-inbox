Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUATTIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbUATTIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:08:09 -0500
Received: from web40909.mail.yahoo.com ([66.218.78.206]:34347 "HELO
	web40909.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265701AbUATTH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:07:57 -0500
Message-ID: <20040120185713.51398.qmail@web40909.mail.yahoo.com>
Date: Tue, 20 Jan 2004 10:57:13 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: My USB pendrive broke in 2.6.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something in the USB storage code, the FAT code or the SCSI code changed
between 2.6.0 and 2.6.1 to break my USB pendrive. Under 2.6.0 I had no problems
mounting and accessing the drive, but after a move to 2.6.1, this is what appears
in dmesg:

request_module: failed /sbin/modprobe -- block-major-2-0. error = 256
hub 1-0:1.0: new USB device on port 2, assigned address 4
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: STF       Model: Flash Drive       Rev: 1.89
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
updfstab: numerical sysctl 1 23 is obsolete.
 sda: sda1
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
request_module: failed /sbin/modprobe -- block-major-2-0. error = 256
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 4
SCSI error : <1 0 0 0> return code = 0x8000000
Current sda: sense = 70  0
Raw sense data:0x70 0x00 0x00 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 
end_request: I/O error, dev sda, sector 32
FAT: unable to read boot sector

I'm not sure what other information to provide on this issue, but I'm certain
that it worked under 2.6.0 - I'm going to check that ASAP. The drive works under
WinXP, so the unit itself is OK.

Does anyone have any ideas on what I should do next?

TIA

Brad

=====


__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
