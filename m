Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTEKPUU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 11:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTEKPUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 11:20:19 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16356 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261651AbTEKPUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 11:20:18 -0400
Date: Sun, 11 May 2003 17:32:44 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeremy Jackson <jerj@coplanar.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Switch ide parameters to new-style and make them unique.
In-Reply-To: <005201c317cd$febb2d00$7c07a8c0@kennet.coplanar.net>
Message-ID: <Pine.SOL.4.30.0305111712230.8722-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 May 2003, Jeremy Jackson wrote:

> Haven't tested, but I have a few comments.
>
> First, I think this is a great step in the right
> direction for the ide driver.

Thanks.

> I think at some point, the kernel command line parameters should be
> consolidated behind a single ata=hda,noprobe or ata=if0,io0x1f0,irq7 type
> parameter, instead of the hda= and ide0=.  Taking that one step furthur, a
> new syntax is needed, and having it go into 2.6 might pave the way for
> removing the old cruft in 2.8?

Yes, I was thinking about it.
I prefer as easily parsable parameters as possible :-)
fe. ata.dev_noprobe=hda and ata.if_io_irq=0,0x1f0,7.

It is a question of shorter command line vs shorter parsing code.

About a 2.6:
I want to mark old command line plus HDIO_DRIVE_CMD and HDIO_DRIVE_TASK
ioctls as obsoleted for 2.6.x and remove these cruft early in 2.7.x.
I hope I will manage to do it, but it depends on Linus.

> That would seem necessary, as I see it, to remove static ide_hwifs and
> eventually support better hotswap.  (But even if it doesn't it would still
> clean up the ide parameters)

FYI I have just done dynamic ide_hwifs allocations, patch needs
    finishing (pdc4030 special case), polishing and testing.

Regards,
--
Bartlomiej

