Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266787AbUAWXqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266788AbUAWXqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:46:19 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:65216 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266787AbUAWXqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:46:15 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Pascal Schmidt <der.eremit@email.de>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
Date: Sat, 24 Jan 2004 00:50:54 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401240028030.878-100000@neptune.local>
In-Reply-To: <Pine.LNX.4.44.0401240028030.878-100000@neptune.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401240050.54792.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 of January 2004 00:29, Pascal Schmidt wrote:
> On Fri, 23 Jan 2004, Pascal Schmidt wrote:
> > With this patch applied, I can successfully use a 512 byte sector disc.
> > However, then inserting a 2048 byte sector disk and trying to fsck it,
> > I get a dozen of:
> >
> > hde: command error: status=0x51 { DriveReady SeekComplete Error }
> > hde: command error: error=0x70
> > end_request: I/O error, dev hde, sector 196608
> > Buffer I/O error on device hde, logical block 24576
> > lost page write due to I/O error on hde
> >
> > Notice how the sector and logical sector numbers are different by a
> > factor of 8. Shouldn't this be a factor of 4?
> >
> > I don't see why this behaves differently than my previous patch, which
> > shows no such problem.
>
> Slightly better patch, but I still don't get why this doesn't work while
> my first patch does.

Maybe you've tested them differently?
You can start from your first patch then incrementally:
apply some changes, check, repeat.

--bart

