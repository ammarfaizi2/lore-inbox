Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbUJYGm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUJYGm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUJYGmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:42:13 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:60382 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261669AbUJYGlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:41:06 -0400
Date: Sun, 24 Oct 2004 23:41:05 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
cc: mdharm-usb@one-eyed-alien.net, James.Bottomley@SteelEye.com
Subject: 2.6.10-rc1 usb2 dvd device remove troubles
Message-ID: <Pine.LNX.4.61.0410242333250.28094@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this problem still exists in 2.6.10-rc1 (it's been around for a while, and 
others have reported it).

if i plug in then unplug a usb2 dvd player it trips a BUG_ON and the scsi 
and usb layers crash and you lose scsi and usb until the next boot.  
sometimes it takes a couple plug/unplug attempts.

here are console messages:

usb 1-3.3: new high speed USB device using address 3
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: PLEXTOR   Model: DVDR   PX-708A    Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 00
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
usb 1-3.3: USB disconnect, address 3
scsi: Device offlined - not ready after error recovery: host 0 channel 0 
id 0 lun 0
sr 0:0:0:0: Illegal state transition cancel->offline
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1713
 [<f09ce0b9>] scsi_device_set_state+0xc9/0x130 [scsi_mod]
 [<f09cb89e>] scsi_eh_offline_sdevs+0x6e/0x90 [scsi_mod]
 [<f09cbe21>] scsi_unjam_host+0xd1/0x200 [scsi_mod]
 [<c0118880>] default_wake_function+0x0/0x20
 [<f09cc038>] scsi_error_handler+0xe8/0x190 [scsi_mod]
 [<f09cbf50>] scsi_error_handler+0x0/0x190 [scsi_mod]
 [<c0104155>] kernel_thread_helper+0x5/0x10

-dean
