Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbTIMQX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 12:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbTIMQX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 12:23:29 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34249 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261268AbTIMQX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 12:23:27 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>, axboe@suse.de
Subject: Re: DMA for ide-scsi?
Date: Sat, 13 Sep 2003 18:25:27 +0200
User-Agent: KMail/1.5
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se>
In-Reply-To: <200309131101.h8DB1WNd021570@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309131825.27402.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 of September 2003 13:01, Mikael Pettersson wrote:
> On Sat, 13 Sep 2003 08:29:18 +0200, Jens Axboe <axboe@suse.de> wrote:
> >> Actually with 2.6, you no longer need ide-scsi.  You'll need to upgrade
> >> your cdrecord tools and probably your burning GUI, if you use one.  I've
> >> been burning that way for several months now.  (I'm using xcdroast,
> >> though I need to start it with "-n" since I'm using cdrecord 2.01a18.)
> >> This actually works better for me than ide-scsi as for some reason it
> >> uses less CPU.
> >
> >That's because it _is_ faster. It contains no silly memory allocations
> >for the buffer and data copying in the kernel, the data is mapped from
> >the user buffer and DMA'ed directly from there. It also uses DMA where
> >ide-scsi wont.
>
> That begs the question: why won't ide-scsi do DMA?
> I understand you'd rather see it disappear (:->) but since I use
> it for other ATAPI devices as well, I'd like to see it maintained
> and fully operational. Having DMA in ide-scsi would be nice.

ide-scsi maintainer position is available :-).

> (And the concept of using a SCSI API to ATA devices is in itself
> not broken, even if the implementation has some problems.)

It is not broken short-term, however it is broken long-term.

> /Mikael

