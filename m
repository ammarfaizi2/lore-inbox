Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131770AbRCTBjJ>; Mon, 19 Mar 2001 20:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131771AbRCTBi7>; Mon, 19 Mar 2001 20:38:59 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:4089 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131770AbRCTBix>; Mon, 19 Mar 2001 20:38:53 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103200137.f2K1bmj18281@webber.adilger.int>
Subject: Re: [Fwd: Problem with file => 2GB]
In-Reply-To: <3AB636A6.44406C2E@kalifornia.com> from Ben Ford at "Mar 19, 2001
 08:41:10 am"
To: Ben Ford <ben@kalifornia.com>
Date: Mon, 19 Mar 2001 18:37:47 -0700 (MST)
CC: linux kernel <linux-kernel@vger.kernel.org>, forensics@securityfocus.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fabio Pietrosanti (naif)" wrote:
> > i'm currently involved in the analisys of a compromised linux box.
> > It was a IBM xSeries server.
> >
> > I transfer the partition of the server using cat /dev/partition| nc
> > host_of_dump_storage 8889, then i check the checksum using md5sum and
> > all it's ok.
> >
> > There are 2 partition dump of 8GB .
> > So i have to mount another 30GB hd, i installed Linux Kernel 2.4.2 with
> > the 30gb on reiserfs .
> > I recompiled all fileutils, util-linux and bin-utils with kernel 2.4.2
> > and the define for => 2GB file support .
> >
> > Ok, now i could download the partition, i could ls, more, strings the
> > partition, but i need to use it as loop device!!
> >
> > When i mount the partition as loop device the mount command HANG on read()
> > function... it seems that loop device under linux didn't work against => 2gb
> > files ?

There is a bug in 2.4.2 with the loop device, which is fixed in -ac series.
Also, I don't think it is possible to use > 2GB for loop (or at least that
used to be the case).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
