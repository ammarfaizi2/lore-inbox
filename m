Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTIYOmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 10:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTIYOmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 10:42:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38055 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261299AbTIYOmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 10:42:14 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
Subject: Re: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Date: Thu, 25 Sep 2003 16:44:22 +0200
User-Agent: KMail/1.5
Cc: "'Lou Langholtz'" <ldl@aros.net>, linux-kernel@vger.kernel.org
References: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA871@E151000N0>
In-Reply-To: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA871@E151000N0>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309251644.22539.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IDE limit is 137GB, not 128GB.

2.6.0-test4 should be okay, unless you have Promise PDC20265,
then you should use 2.6.0-test5 (allows LBA48 DMA on PDC20265).

Latest 2.4-ac may be even better if you have i.e. ALi IDE controller.
It will use DMA transfers for < 137GB area and PIO for > 137GB,
whereas 2.6 will always use PIO.

--bartlomiej

On Thursday 25 of September 2003 16:03, Norris, Brent wrote:
> > What version of the linux kernel are you using?
> > Ie. provide some more info like what's 'uname -a'
> > say on your system. There's been a few patches go
> > by this list to fix this disk size problem. They
> > should also be in the latest kernel releases too.
>
> Ok, well that is a start then.  I am running Redhat's latest kernel
> 2.4.20-20.9 though I also have 2.4.0test4 on the machine.  I haven't tried
> it under 2.4.0test4 though.  I just didn't have enough time this morning
> when the error surfaced.  Are they in 2.4.22?  Because looking through the
> changelog, I see a bunch of AC's and other fixes for IDE items, but I don't
> see anything about this boundrey?  Did it go in before then?
>
> Thanks for the help
>
> Brent

