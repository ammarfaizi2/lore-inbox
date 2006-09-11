Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWIKSIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWIKSIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWIKSIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:08:24 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:45136 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932221AbWIKSIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:08:23 -0400
Message-ID: <4505A612.8070603@tls.msk.ru>
Date: Mon, 11 Sep 2006 22:08:18 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Vendor field with USB, [SP]ATA etc-attached disks
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With current SATA, PATA and at least some USB disks,
Linux reports Vendor: $subsystem, instead of the actual
vendor of the drive, like this:

scsi1 : ata_piix
  Vendor: ATA       Model: ST3808110AS       Rev: n/a
  Type:   Direct-Access                      ANSI SCSI revision: 05

This should be Vendor: Seagate, not ATA (Note also the lack
of "Revision" field).  The same for PATA disk:

scsi0 : pata_via
  Vendor: ATA       Model: ST3120026A        Rev: 3.76
  Type:   Direct-Access                      ANSI SCSI revision: 05

The same is shown in /sys/block/$DEV/device/vendor.

Can it be changed to show real vendor, instead of the subsystem name?

Thanks.

/mjt
