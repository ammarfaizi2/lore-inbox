Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTFJQXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbTFJQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:23:20 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56730 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263398AbTFJQXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:23:19 -0400
Date: Tue, 10 Jun 2003 18:36:41 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE Power Management, try 2
In-Reply-To: <1055262472.705.21.camel@gaston>
Message-ID: <Pine.SOL.4.30.0306101832350.24343-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Jun 2003, Benjamin Herrenschmidt wrote:

> On Tue, 2003-06-10 at 18:15, Jens Axboe wrote:
> > On Thu, Jun 05 2003, Bartlomiej Zolnierkiewicz wrote:
> > > Jens, I think generic version of ide_do_drive_cmd() would be useful for
> > > other block devices, what do you think?
> >
> > Something ala this? Completely untested, and I only did scsi_ioctl.c and
> > ide-io.c. iirc, scsi uses somthing similar that could be adapted too.
>
> Hrm... you didn't keep some functionalities I added with the PM
> patch here... like marking of preempt requests so I can fetch them
> even when drive is blocked, and ide_head_wait...
>
> Ben

I've looked for users of ide_preempt in drivers/ide/ and I think
that REQ_PREEMPT can later die if we fix drivers to correctly mark
sense requests with REQ_SENSE...

--
Bartlomiej

