Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbRA3NSk>; Tue, 30 Jan 2001 08:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRA3NSb>; Tue, 30 Jan 2001 08:18:31 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:37387 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S130149AbRA3NSN>;
	Tue, 30 Jan 2001 08:18:13 -0500
Date: Tue, 30 Jan 2001 14:18:04 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: David Riley <oscar@the-rileys.net>, <linux-kernel@vger.kernel.org>
Subject: Re: *massive* slowdowns on 2.4.1-pre1[1|2]
In-Reply-To: <Pine.LNX.4.10.10101292102030.28124-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0101301410070.11641-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Mark Hahn wrote:
> > Kernel 2.4.1-pre11 and pre12 are both massively slower than 2.4.0 on the
> > same machine, compiled with the same options.  The machine is a Athlon
> > 900 on a KT133 chipset.  The slowdown is noticealbe in all areas...
>
> this is known: Linus decreed that, since two people reported
> disk corruption on VIA, any machine with a VIA southbridge
> must boot in stupid 1992 mode (PIO).  (yes, it might be possible
> to boot with ide=autodma or something, but who would guess?)

The only patch concerning VIA IDE in 2.4.1 is a patch that honors the
user's choise in "make menuconfig" regarding using DMA by default.  Just
say yes to that option, and you should have DMA enabled at boot, as you
had in 2.4.0.

The old behaviour was a bug.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
