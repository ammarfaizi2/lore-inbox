Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTJFTDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTJFTC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:02:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9866 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261183AbTJFTCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:02:52 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Justin Hibbits <jrh29@po.cwru.edu>, linux-kernel@vger.kernel.org
Subject: Re: regression between 2.4.18 and 2.4.21/22
Date: Mon, 6 Oct 2003 21:06:31 +0200
User-Agent: KMail/1.5.4
References: <0AB14379-F78D-11D7-86F4-000A95841F44@po.cwru.edu>
In-Reply-To: <0AB14379-F78D-11D7-86F4-000A95841F44@po.cwru.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310062106.31958.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Your /dev/hda (IBM DeskStar 60GXP) is not in DMA mode because
you don't have support for your IDE controller compiled-in.
Going from 2.4.21 you have to explicitely enable support for IDE chipsets.
Assumption that current .config file will work with future kernel versions
is not true.  Please compile kernel with driver for your on-board IDE chipset
(I deducted from your dmesg that it is VIA82CXXX IDE driver).

Please report back if this cures your problem,

Thanks,
--bartlomiej

On Monday 06 of October 2003 01:38, Justin Hibbits wrote:
> On Sunday, Oct 5, 2003, at 19:22 America/New_York, Bartlomiej
>
> Zolnierkiewicz wrote:
> > Please narrow down kernel version if you want your problem to be cared.
> >
> > Try 2.4.19, 2.4.20.  There are also intermediate prepatches at
> > http://www.kernel.org/pub/linux/kernel/v2.4/testing/old/
> >
> > dmesg output and .config can also be useful.
> >
> > --bartlomiej
> >
> > On Sunday 05 of October 2003 22:21, Justin Hibbits wrote:
> >> Something very strange is going on with my machine.  With 2.4.18, I
> >> was
> >> getting 38MB/s on my main system disk (IBM Deskstar 60gxp), and 35 for
> >> the other drives (Western Digital).  The IBM drive is on a Promise IDE
> >> controller (ASUS A7V266-E motherboard), and the others are on a
> >> PROMISE
> >> 2069 UDMA133 controller.  However, with 2.4.21 and 2.4.22, it will not
> >> set the using_dma flag for my IBM drive, but sets it for the others,
> >> which now get sustained transfer rates of 46MB/s or greater.  I'm
> >> using
> >> the same options for all 3 kernels (at least, for the ATA/IDE
> >> options).
> >>   Any help would be appreciated, and I'll see if maybe I could do
> >> something with it when I get time.
>
> Ok, I tried 2.4.19, which I thought was pretty bad because it randomly
> crashed all the time, and it worked just fine with all my drives.
> 2.4.20 with the wolk-4.0 patch also worked.  So, I'm guessing it was
> between 2.4.20 and 2.4.21....I could try all the prepatches as well,
> and narrow down exact prepatch, will take some time.  dmesg output for
> 2.4.21 follows (uses a patchset for XFS, sensors, etc), along with my
> config, both compressed.

