Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265642AbRF1MCf>; Thu, 28 Jun 2001 08:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbRF1MC0>; Thu, 28 Jun 2001 08:02:26 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:2308 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S265646AbRF1MCQ>;
	Thu, 28 Jun 2001 08:02:16 -0400
Date: Thu, 28 Jun 2001 14:02:09 +0200 (CEST)
From: Tobias Ringstrom <tori@unhappy.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Helge Hafting <helge.hafting@idb.hist.no>
cc: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <3B3B14AB.DF020611@idb.hist.no>
Message-ID: <Pine.LNX.4.33.0106281346280.1258-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Helge Hafting wrote:
> Preventing swap-trashing at all cost doesn't help if the
> machine loose to io-trashing instead.  Performance will be
> just as much down, although perhaps more satisfying because
> people aren't that surprised if explicit file operations
> take a long time.  They hate it when moving the mouse
> or something cause a disk access even if their
> apps runs faster. :-(

Exactly.  I still want the ability to tune the system according to my
taste.  I've been thinking about this for some time, and I've specifically
tried to come up with nice tunables, completely ignoring if it is possible
now or not.

If individual pages could be classified as code (text segments), data,
file cache, and so on, I would specify costs to the paging of such pages
in or out.  This way I can make the system perfer to drop a file cache
page that has not been accessed for five minutes, over a program text page
that has not been acccessed for one hour (or much more).

This would be very useful, I think.  Would it be very hard to classify
pages like this (text/data/cache/...)?

Any reason why this is a bad idea?

/Tobias



