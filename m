Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVGGInc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVGGInc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVGGIlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:41:46 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:49890 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261245AbVGGIlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:41:01 -0400
Subject: Re: SATA: Assertion failed! qc->flags &
	ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3052
From: Soeren Sonnenburg <kernel@nn7.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <200507071243.39080.adobriyan@gmail.com>
References: <1120723473.18056.29.camel@localhost>
	 <200507071243.39080.adobriyan@gmail.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 10:40:55 +0200
Message-Id: <1120725655.18056.33.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 12:43 +0400, Alexey Dobriyan wrote:
> On Thursday 07 July 2005 12:04, Soeren Sonnenburg wrote:
> > with hddtemp regularly polling for the temperature state together with
> > libsata from kernel 2.6.12 on a promise tx2. The disk is set to go to
> > sleep mode (hdparm -S 35 /dev/sda). And after a couple of hours the
> > machine oopsed (the disk was sleeping/not mounted at that time - with
> > high probability) :
> > 
> > ata2: command timeout
> > ata2: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3052
> > ata2: translated ATA stat/err 0xb0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > ata2: status=0xb0 { Busy }
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> > EIP:    0060:[<c0118eac>]    Tainted: P      VLI
> 
> > I am now trying w/o hddtemp, lets see how long it survives...
> 
> With untainted kernel, please. To be sure it's our problem.

Sorry but I am. The machine never hung/oopsed before. The only new thing
now is the sata disk.

Soeren
-- 
"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety." Benjamin Franklin

