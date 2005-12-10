Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161063AbVLJUWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161063AbVLJUWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 15:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbVLJUWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 15:22:37 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:42270 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161063AbVLJUWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 15:22:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GQ+XkltN/LWQkkkbG4Wp/0RtryakpSxMS7pzEX8kcf6LLJptPh+/mwNgqyVWgj8LU33unFeWq/WWD1QzJbueEY+5HervK5ga7MqwDbsDE5Y86XOPV/EMDjAYxZTpkyFMTejsagjEvoE2Lofvm/QtZmiC7qP/3avR55xF8MWC8m0=
Message-ID: <5a4c581d0512101222je343b28k6e61f80c0727ae54@mail.gmail.com>
Date: Sat, 10 Dec 2005 21:22:35 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.15-rc5 - nonfatal libata assertion (qc->n_elem > 0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is just for the record, as it doesn't appear to have had
 any side effects...

Dell Latitude D610, uptodate FC4, kernel 2.6.15-rc5, booted with
 libata.atapi_enabled=1.

Dec 10 19:33:26 sandman kernel: cdrom: This disc doesn't have any
tracks I recognize!
Dec 10 19:35:21 sandman kernel: Assertion failed! qc->n_elem >
0,drivers/scsi/libata-core.c,ata_fill_sg,line=2482
Dec 10 19:35:35 sandman last message repeated 18 times

This happened presumably when I earlier burned a CD-R
 with .wav audio tracks; the burning was successful.

Drive is detected as follows:

ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
ata2: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000 88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: SONY      Model: DVD+-RW DW-Q58A   Rev: UDS1
  Type:   CD-ROM                             ANSI SCSI revision: 05

--alessandro

 "So much can happen by accident
  No rhyme, no reason - no one's innocent"

   (Steve Wynn - "Under The Weather")
