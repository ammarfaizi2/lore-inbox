Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUCAQio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 11:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbUCAQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 11:38:44 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19616 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261361AbUCAQil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 11:38:41 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christophe Saout <christophe@saout.de>
Subject: Re: Worrisome IDE PIO transfers...
Date: Mon, 1 Mar 2004 17:45:34 +0100
User-Agent: KMail/1.5.3
Cc: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>,
       Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <4041232C.7030305@pobox.com> <200403010147.47808.bzolnier@elka.pw.edu.pl> <1078147381.7497.15.camel@leto.cs.pocnet.net>
In-Reply-To: <1078147381.7497.15.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011745.34068.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 of March 2004 14:23, Christophe Saout wrote:
> Am Mo, den 01.03.2004 schrieb Bartlomiej Zolnierkiewicz um 01:47:
> > http://www.kernel.org/pub/linux/kernel/people/bart/dm-byteswap-2.6.4-rc1.
> >patch
> >
> > Guess what's this? :)
>
> The thieves... they've stolen my precioussss. ;)
>
> > It is simply a stripped down dm-crypt.c, so all credits go to Christophe.
> > I have tested it quickly with loop device and it seems to work.
>
> Yes, it's not that complicated. Looks good.
> BTW: You don't need the km_types voodoo as the conversion routine is
> never called from a softirq context and you are allowed (but should try
> to avoid it) to sleep. You could add a conditional reschedule after
> kunmapping the buffers to keep the latency low on non-preempt kernels.

Yes, you are of course right.  I will remove "km_types voodoo".

> BTW: I've got some cleanups and a small fix in Andrew's latest tree
> (using a #define for the log prefix and I bvec array thingy).

Yep, I've seen them already.

Thanks,
Bartlomiej

