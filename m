Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131507AbQKQCMT>; Thu, 16 Nov 2000 21:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131723AbQKQCMJ>; Thu, 16 Nov 2000 21:12:09 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:24326
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S131507AbQKQCLv>; Thu, 16 Nov 2000 21:11:51 -0500
Date: Thu, 16 Nov 2000 17:41:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: sorted - was: How to add a drive to DMA black list?
In-Reply-To: <5.0.0.25.2.20001117013109.00a5aeb0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10011161740120.6910-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Anton Altaparmakov wrote:

> I am sure you knew this perfectly well already but just in case it is helpful:
> 
> the offending code is in:
> 
> drivers/ide/piix.c::piix_dmaproc [starts on line 402 in 2.4.0-test11-pre5]
> 
> It calls piix_config_drive_for_dma and only then calls ide_dmaproc.
> 
> It is ide_dmaproc that does the good/bad test so obviously it is called too 
> late.

Sorry I have not looked at the PIIX code in a long time and forgot that it
was not complete with the table checks.  But I will get there soon.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
