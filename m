Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWCQL2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWCQL2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 06:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWCQL2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 06:28:37 -0500
Received: from [81.2.110.250] ([81.2.110.250]:1239 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750748AbWCQL2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 06:28:36 -0500
Subject: Re: libata/sata errors on ich[?]/maxtor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Masham <samuel.masham@gmail.com>
Cc: Mauro Tassinari <mtassinari@cmanet.it>, linux-kernel@vger.kernel.org
In-Reply-To: <93564eb70603162037g1856b7eey@mail.gmail.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAoSG5sanwXkG4qxYkj76rcgEAAAAA@cmanet.it>
	 <93564eb70603162037g1856b7eey@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 11:34:54 +0000
Message-Id: <1142595294.28614.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-03-17 at 13:37 +0900, Samuel Masham wrote:
> As you can see from the printk's here this error continues and the for
> every access (write?) to the drive you just have to wait for a
> timeout.

Eventually the drive will be offlined.

> ata1: command 0x35 timeout, stat 0xd1 host_stat 0x61
> ata1: translated ATA stat/err 0xd1/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata1: status=0xd1 { Busy }
> SCSI disk error : host 0 channel 0 id 1 lun 0 return code = 8000002
> Current sd08:12: sense key Aborted Command
> Additional sense indicates Scsi parity error

It thinks there is a communication (eg cable problem), at least that is
how it has mapped the error report. Not something I'd expect to see in
the SATA case on several machines so it could be some kind of setup
error or timing incompatibility in the driver.

What is attached to that controller (SATA and PATA items)

