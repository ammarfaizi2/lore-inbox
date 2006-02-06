Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWBFQ6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWBFQ6p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 11:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWBFQ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 11:58:45 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:65336 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932227AbWBFQ6o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 11:58:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pN8TIrCSUtzc7a2wCVg+r8wetfBC0FEcsV/OyZaY2g5ZKcgUn4BluJguFgw/JJeNDOQlU9D+Si1/nUlS0zVSfX9wccqbMKHKkN1y2JFDVK34X1SHxSNaqUgNbICx0ABmeNVYpFvTEhHDt8ebrx07yWhwq700cNq3p3IqXk4YWbw=
Message-ID: <5a2cf1f60602060858x268cd05fud533ee554fb2db5a@mail.gmail.com>
Date: Mon, 6 Feb 2006 17:58:41 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: EVMS & SATA failure
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to recover from a disk failure [1], we:
- installed a fresh ubuntu 5.10 (modified kernel 2.6.12) on a new disk
- stopped machine
- connected failing SATA disk to board (in order to try to recover some data)
- rebooted

That doesn't work at all:

* Setting up LVM Volumne Groups
* Starting Enterprise Volume Management System...
ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
Buffer I/O error on device dm-3, logical block 1
ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
Buffer I/O error on device dm-3, logical block 2
ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
Buffer I/O error on device dm-3, logical block 3
ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
Buffer I/O error on device dm-3, logical block 4
ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
Buffer I/O error on device dm-3, logical block 5
ata4: translated ATA stat/err 0x25/00 to SCSI SK/ASC
Buffer I/O error on device dm-3, logical block 6
....

And the boot doesn't go further, the error messages keep looping from
block 0 to 12.

As I am trying to minimize my number of reboots (to not stress my
failing disk), maybe someone has an idea what those messages could
mean? Is that due to my failing disk? Is it some sort of SATA
configuration issue? Or is there an EVMS issue?

Otherwise I will prevent the EVMS daemon from starting at boot and see
if that fixes my issue.

Cheers,

Jerome

[1] http://lkml.org/lkml/2006/1/10/397
