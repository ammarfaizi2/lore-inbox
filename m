Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129237AbRBKMEU>; Sun, 11 Feb 2001 07:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129235AbRBKMEK>; Sun, 11 Feb 2001 07:04:10 -0500
Received: from [194.73.73.138] ([194.73.73.138]:38824 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129124AbRBKMEA>;
	Sun, 11 Feb 2001 07:04:00 -0500
Date: Sun, 11 Feb 2001 12:02:57 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More network pci_enable cleanups.
In-Reply-To: <3A860CF4.81622FC0@mandrakesoft.com>
Message-ID: <Pine.LNX.4.31.0102111159430.6348-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2001, Jeff Garzik wrote:

> 1) Bug: Introduced memory leak by replacing "goto err_out" with "return
> err"
> 2) Sole usage of 'err' -- it should be scoped inside the pdev!=NULL
> check.

Will fix up later.

> > -       int     cards_found = 0;
> > +       int     cards_found;
> Rejected.  Introduces bug.  That zero is required!

Refresh my memory here. I thought unitialised vars go to bss,
and get zeroed at boot time ?

> rejected -- already in AC patches (and merged into my tree as well)

Odd, I diffed against the latest AC patch.

> Rejected.  The maintainer clearly wanted the "/* = 0 */" present, yet
> you remove them.  I'm suspicious of the acpi_idle_state initialization
> removal as well, but can't check it quickly at present (acpi_idle_state
> is gone in my tree)

Ok, I'll assume you've got the pci_enable stuff already cleaned there.

> All the rest were applied.

Great :) Thanks Jeff..

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
