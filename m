Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135880AbRDTMIO>; Fri, 20 Apr 2001 08:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135883AbRDTMID>; Fri, 20 Apr 2001 08:08:03 -0400
Received: from sirius-giga.rz.uni-ulm.de ([134.60.246.36]:37581 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S135880AbRDTMHy>; Fri, 20 Apr 2001 08:07:54 -0400
Date: Fri, 20 Apr 2001 14:07:51 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Markus Schaber <markus.schaber@student.uni-ulm.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AHA-154X/1535 not recognized any more
In-Reply-To: <E14puVG-00053d-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.33.0104201402080.11952-100000@lyra.rz.uni-ulm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, Alan Cox wrote:

> > Well, as this device is already configured by the bios, I just tried
> > to load it giving the right IO port, and got the following message:
>
> The kernel PnP will deconfigure it

Ah, interesting.

> The module parameters are
>
> aha1542=io, irq, busff, dmaspeed

I recompiled the kernel with isapnp-support and statically compiled
driver. I then typed aha1542=0x330 at the lilo prompt, but the card wasn't
recognized (see dmesg_pnp_bootparam.txt on http://schabi.de/scsi/).

isapnp will initialize the card when the check entry is removed, but
doesn't activate the driver. I'll next test with modularized driver, and
the isapnp tools.

markus

