Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292768AbSBUVha>; Thu, 21 Feb 2002 16:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292759AbSBUVhU>; Thu, 21 Feb 2002 16:37:20 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25362
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292768AbSBUVhH>; Thu, 21 Feb 2002 16:37:07 -0500
Date: Thu, 21 Feb 2002 13:24:53 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <E16dtkW-0006yW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10202211323170.31576-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Alan Cox wrote:

> > This is the next round of IDE driver cleanups.
> 
> How about fixing the stuff you've already messed up (like putting the
> drive present flags and the probe return back) ? The changes you made
> to the init code also broke the framework so that 2.5 would eventually
> let you do
> 
> 	open("/dev/cdrom")
> 	read/write
> 	close("/dev/cdrom")
> 	open("/dev/sda")		/* Same device */
> 	burn a cd
> 
> without loading/unloading modules
> 
> I'm also confused how you plan to fix the hot swap case after your changes
> because you've not allowed for the fact drives might be hot swapped while
> you are suspended. The old code was careful to keep the hooks for that
> ready.
>
> Finally you forgot to update the MAINTAINER entry since you've now clearly
> decided to walk over Andre and become the IDE maintainer
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Alan,

Please let me correct this issue as now I am going to start new driver
since this one is now beyond repair for me.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

