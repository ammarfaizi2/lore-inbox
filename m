Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbUCUBYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 20:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUCUBYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 20:24:43 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31207 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263586AbUCUBYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 20:24:41 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Johannes Stezenbach <js@convergence.de>
Subject: Re: [PATCH] barrier patch set
Date: Sun, 21 Mar 2004 02:33:29 +0100
User-Agent: KMail/1.5.3
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040319153554.GC2933@suse.de> <200403201700.05808.bzolnier@elka.pw.edu.pl> <20040320233604.GE2051@convergence.de>
In-Reply-To: <20040320233604.GE2051@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403210233.29715.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 of March 2004 00:36, Johannes Stezenbach wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 20 of March 2004 12:36, Matthias Andree wrote:
> > > > Correct answer is: everything is fine, RTFM (man hdparm). ;-)
> > >
> > > Not everything is fine. hdparm documents -i returns inconsistent data.
> > > Most, but _NOT_ _EVERYTHING_ is cached: the multcount is updated, for
> > > instance. What is that good for? Mix & Match whatever is convenient?
> >
> > I'm aware of this bug - driver shouldn't modify drive->id.  Patches are
> > welcomed.
>
> Why? What's the reason for keeping out-of-date IDENTIFY data?

HDIO_GET_IDENTIFY ioctl which should die first.

> And what about ide_driveid_update()? Is it a bug that
> it exists?

It should just check/copy relevant bits from the new identify
(but without modifying drive->id).

> This is all too confusing for me :-(

Welcome in the wonderful world of IDE driver. ;-)

Bartlomiej

