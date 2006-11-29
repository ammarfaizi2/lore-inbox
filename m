Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758148AbWK2Vrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148AbWK2Vrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758150AbWK2Vrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:47:46 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:45788 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1758148AbWK2Vrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:47:45 -0500
Date: Wed, 29 Nov 2006 22:47:36 +0100
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: mass-storage problems with Archos AV500
Message-ID: <20061129214736.GU14886@vasa.acc.umu.se>
Mail-Followup-To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an Archos AV500 here (running the very latest firmware), pretty
much acting as a doorstop, since I cannot get it to be recognized
properly by Linux.

This device has two modes, and one usb-id for each:

Windows device mode:
0e79:1129

mass storage mode:
0e79:1128

I didn't really expect any luck with the former (and didn't have any
either), but I was kind of hoping that the latter would be supported.
Not so.

Relevant info from dmesg:

[  112.904000] usb 5-5: new high speed USB device using ehci_hcd and
address 4
[  113.036000] usb 5-5: configuration #1 chosen from 1 choice
[  113.124000] usbcore: registered new interface driver libusual
[  113.140000] Initializing USB Mass Storage driver...
[  113.140000] scsi4 : SCSI emulation for USB Mass Storage devices
[  113.140000] usb-storage: device found at 4
[  113.140000] usb-storage: waiting for device to settle before scanning
[  113.140000] usbcore: registered new interface driver usb-storage
[  113.140000] USB Mass Storage support registered.
[  118.140000] scsi 4:0:0:0: Direct-Access     Archos   AV500
0000 PQ: 0 ANSI: 4
[  118.140000] SCSI device sdb: 58074975 512-byte hdwr sectors (29734
MB)
[  118.144000] sdb: Write Protect is off
[  118.144000] sdb: Mode Sense: 33 00 00 00
[  118.144000] sdb: assuming drive cache: write through
[  118.144000] SCSI device sdb: 58074975 512-byte hdwr sectors (29734
MB)
[  118.144000] sdb: Write Protect is off
[  118.144000] sdb: Mode Sense: 33 00 00 00
[  118.144000] sdb: assuming drive cache: write through
[  118.144000]  sdb: unknown partition table
[  118.452000] sd 4:0:0:0: Attached scsi removable disk sdb
[  118.452000] usb-storage: device scan complete

This is with linux-image-2.6.19-7-generic 2.6.19-7.10 from Ubuntu edgy.
I get similar results with a home-brew 2.6.18-rc4.

Any mass storage quirk needed that might be missing?


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
