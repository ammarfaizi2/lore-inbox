Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135564AbRDXLyA>; Tue, 24 Apr 2001 07:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135559AbRDXLxo>; Tue, 24 Apr 2001 07:53:44 -0400
Received: from mail.informatik.uni-ulm.de ([134.60.68.63]:15170 "EHLO
	mail.informatik.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S135556AbRDXLxP>; Tue, 24 Apr 2001 07:53:15 -0400
Message-ID: <3AE5690F.AFBA7EB8@student.uni-ulm.de>
Date: Tue, 24 Apr 2001 13:52:47 +0200
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
Organization: University of Ulm
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: de,de-DE,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: AHA-154X/1535 not recognized any more [Repost]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As it seems my original Messages didn't get through, a Repost here:

-------- Original Message --------
Subject: Re: AHA-154X/1535 not recognized any more
Date: Fri, 20 Apr 2001 14:07:51 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Markus Schaber <markus.schaber@student.uni-ulm.de>,Linux Kernel
Mailing List <linux-kernel@vger.kernel.org>

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
driver. I then typed aha1542=0x330 at the lilo prompt, but the card
wasn't
recognized (see dmesg_pnp_bootparam.txt on http://schabi.de/scsi/).

isapnp will initialize the card when the check entry is removed, but
doesn't activate the driver. I'll next test with modularized driver, and
the isapnp tools.

markus
