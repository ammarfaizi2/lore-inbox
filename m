Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWCHBad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWCHBad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWCHBad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:30:33 -0500
Received: from fmr17.intel.com ([134.134.136.16]:8329 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964829AbWCHBac convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:30:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: SATA ATAPI AHCI error messages?
Date: Tue, 7 Mar 2006 17:30:29 -0800
Message-ID: <26CEE2C804D7BE47BC4686CDE863D0F50660ABA5@orsmsx410>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SATA ATAPI AHCI error messages?
Thread-Index: AcZCT+JmHZLW8eXdSAKLHTmJ6khLDg==
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2006 01:30:30.0203 (UTC) FILETIME=[E2D3F8B0:01C6424F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We are seeing the following error messages in dmesg with the 2.6.16-rc5
kernel.  I have also tried to apply the git10 patch and still see the
same errors.  This is seen using a Plextor PX-716SA or PX-712SA SATA
DVDRW drive when in AHCI mode.  I do not see this message when the SATA
controller is set to IDE mode, in the BIOS.  I have reproduced this
using Intel ICH6R, ICH7R and ICH8 SATA controllers.  I have
atapi_enabled=1 set in the libata-core.c file.  These error messages
continue to be repeatedly logged about every 2 seconds.  Can someone
tell me what is going on and if this will be addressed in the next RC
release of the 2.6.16 kernel?
 
ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: translated ATA stat/err 0x51/24 to SCSI SK/ASC/ASCQ 0xb/00/00
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information

Thanks,

Jason

