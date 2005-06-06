Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFFIQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFFIQx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 04:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVFFIQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 04:16:52 -0400
Received: from gw.anda.ru ([83.146.86.58]:51460 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S261187AbVFFIQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 04:16:41 -0400
Date: Mon, 6 Jun 2005 14:16:38 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: [PROBLEM] aic7xxx: DV failed to configure device
Message-ID: <20050606141638.A28532@ward.six>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing an Adaptec SCSI controller + an IBM drive.  All the things
used to be fine before I had made the low-level format of the drive
(thru the Ctrl-A Adaptec's menu).  And now after

        modprobe aic7xxx

I have:


scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0:A:0:0: DV failed to configure device.  Please file a bug report against this driver.
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: IBM       Model: DDYS-T09170N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
 sda: unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0


The message

scsi0:A:0:0: DV failed to configure device.  Please file a bug report against this driver.

had never appeared before the low-level format.  But it seems that
after the format the drive still works fine.

So, what does this message mean?  And can I just ignore it?

Some additional info: it's the PCI64 card installed in a 32-bit PCI
slot, Domain Validation is turned on thru the Adaptec BIOS setup.

Thanks in advance.
