Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUAZPiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUAZPh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:37:59 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:64384 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S264363AbUAZPhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:37:53 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16405.13390.835889.391521@jik.kamens.brookline.ma.us>
Date: Mon, 26 Jan 2004 10:37:50 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-rc1-mm3: SCSI TARGET RESET on boot with no indication
   of why
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With my AIC7XXX controller and my rather old Microtek ScanMaker E6
SCSI scanner, 2.6.2-rc1-mm3 for some reason feels compelled to attempt
to reset the scanner immediately after identifying it during the boot
sequence.  When I see "immediately" I mean that there doesn't seem to
be any delay between when it prints out the "Attached scsi generic"
message in the transcript below and when it prints out the subsequent
messages about the TARGET RESET message.

Despite these messages, the scanner appears to work when booting is
finished.

This does not occur with 2.4.22-ac4.

My question is -- do these messages indicate that something is wrong,
what could it be, and what should I do about it?

I tried to find a maintainer for the AIC7XXX code to contact about
this, but I didn't see one in MAINTAINERS.

Thanks,

  jik

Boot log excerpt:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

hub 1-0:1.0: new USB device on port 2, assigned address 3
  Vendor:           Model: Scanner 600       Rev: 1.91
  Type:   Scanner                            ANSI SCSI revision: 03
Attached scsi generic sg0 at scsi0, channel 0, id 4, lun 0,  type 6
scsi0:0:4:0: Attempting to queue a TARGET RESET message
CDB: 0xa0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x4 0x8 0x0 0x0
scsi0:0:4:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi0:0:4:0: Attempting to queue a TARGET RESET message
CDB: 0xa0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x4 0x8 0x0 0x0
scsi0:0:4:0: Command not found
aic7xxx_dev_reset returns 0x2002
scsi0:0:4:0: Attempting to queue a TARGET RESET message
CDB: 0xa0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x4 0x8 0x0 0x0
scsi0:0:4:0: Command not found
aic7xxx_dev_reset returns 0x2002
