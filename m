Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131080AbQK2S6w>; Wed, 29 Nov 2000 13:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131136AbQK2S6m>; Wed, 29 Nov 2000 13:58:42 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:32772
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S131080AbQK2S6a>; Wed, 29 Nov 2000 13:58:30 -0500
Date: Wed, 29 Nov 2000 10:27:17 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Kurt Garloff <kurt@garloff.de>
cc: --Damacus Porteng-- <kernel@bastion.yi.org>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE-SCSI/HPT366 Problem
In-Reply-To: <20001129191402.F5891@garloff.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.10.10011291025411.1743-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Kurt Garloff wrote:

> Strange. If you read data from the harddisk on an IDE channel and write it
> (with cdrecord) to some CDRW on the same IDE channel, you have to expect
> trouble: As with IDE there is no disconnect from the bus (as opposed to
> SCSI), you risk buffer underruns. 
> A lockup however is not to be expected :-(

It is completely expected bacause of teh active timing changes done on
this chipset design.  The timings are for ATA DMA and not ATAPI.
You should expect a 100% hardlock on mistimed IO access.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
