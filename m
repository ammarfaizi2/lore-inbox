Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310548AbSCLLGA>; Tue, 12 Mar 2002 06:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310549AbSCLLFu>; Tue, 12 Mar 2002 06:05:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5893 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310548AbSCLLFi>; Tue, 12 Mar 2002 06:05:38 -0500
Subject: Re: [patch] My AMD IDE driver, v2.7
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 12 Mar 2002 11:17:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        davidsen@tmr.com (Bill Davidsen), linux-kernel@vger.kernel.org (LKML)
In-Reply-To: <3C8D6CA4.8060604@mandrakesoft.com> from "Jeff Garzik" at Mar 11, 2002 09:49:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kkHj-0003R8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, you can still bit-bang with the current implementation, on that 
> capability.  Couldn't that be cured with s/CAP_SYS_RAWIO/some new 
> CAP_DEVICE_CMD/  for the raw device command interface?

By uploading new firmware you can make the drive return compromised pages
from swap which make an existing RAWIO application do what you want

- so CAP_DEVICE_CMD in the IDE case at least is CAP_SYS_RAWIO

> The current implementation needs to be changed anyway :)  From "ATA raw 
> command" to "device raw command" at the very least.

That assumes a totally generic interface is good - ATA is rather different
to ATAPI/SCSI so it may be best the device interface reflects that.
