Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVDMSOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDMSOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVDMSOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:14:54 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:13241 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261179AbVDMSOv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:14:51 -0400
X-Mailer: exmh version 2.7.2 04/02/2003 (gentoo 2.7.2) with nmh-1.1
To: linux-kernel@vger.kernel.org
Subject: DVD writer and IDE support...
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 13 Apr 2005 20:14:21 +0200
From: aeriksson@fastmail.fm
Message-Id: <20050413181421.5C20E240480@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All,

I've just gotten myself a new DVD burner which triggers some 
interesting events in the kernel. From the log:

hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x40 { LastFailedSense=0x04 }
ide: failed opcode was: unknown
ATAPI device hdc:
  Error: Hardware error -- (Sense key=0x04)
  Focus servo failure -- (asc=0x09, ascq=0x02)
  The failed "Read Cd/Dvd Capacity" packet command was: 
  "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "


rmmod'ing the icd-cd module and modprob'ing the ide-scsi (seeing as 
that used to be the common approach for folks (I'm new to burners...))
I got this in the log:

ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: AOPEN     Model: DUW1608/ARR       Rev: A060
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0

How should I interprete this? That the device is not supported under
the icd-cd module but the scsi support detects and supports it ok?
I've not tried to burn anything with it yet so I have no hard facts on
if there is enough support (yet).

If there is any sort of data which need to be shipped somewhere to 
make this device supported by ide-cd, I'd be glad to help...

Advice appreciated,

/Anders


