Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283004AbRK1AnS>; Tue, 27 Nov 2001 19:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282999AbRK1AnI>; Tue, 27 Nov 2001 19:43:08 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1031 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S281825AbRK1AnE>; Tue, 27 Nov 2001 19:43:04 -0500
Date: Tue, 27 Nov 2001 16:40:44 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
In-Reply-To: <9u0ua1$1g2$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10111271618390.12912-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Given that block is in the transition period, would you consider a
schedule of when you are taking patchs ?

Regard,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

On Tue, 27 Nov 2001, Linus Torvalds wrote:

> In article <200111272044.fARKiTv13653@db0bm.ampr.org>,
> f5ibh  <f5ibh@db0bm.ampr.org> wrote:
> >
> >I've the following error :
> 
> Yes.
> 
> The next-generation block-layer support is starting to be merged into
> the 2.5.x tree, and that breaks old drivers that haven't been updated to
> the new locking.
> 
> In particular, there used to be _one_ lock for the whole IO system
> ("io_request_lock"), and these days it's a per-block-queue lock.
> 
> In many cases the fix is as simple as just replacing the
> "io_request_lock" with "host->host_lock", but sometimes this is
> complicated by the need to pass the right data structures down far
> enough..
> 
> Many drivers have been converted (ie IDE, symbios, aic7xxx etc), but
> many more have not (especially older SCSI drivers, in your case it's the
> classic aha1542).
> 
> It will probably take some time until most drivers have been converted.
> Tested patches are more than welcome,
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

