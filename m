Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbTJCCn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 22:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbTJCCn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 22:43:57 -0400
Received: from genericorp.net ([69.56.190.66]:27323 "EHLO
	narbuckle.genericorp.net") by vger.kernel.org with ESMTP
	id S263609AbTJCCnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 22:43:55 -0400
Date: Thu, 2 Oct 2003 21:43:34 -0500 (CDT)
From: Dave O <cxreg@pobox.com>
X-X-Sender: count@narbuckle.genericorp.net
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-hfsplus-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] new HFS(+) driver
In-Reply-To: <20031003002608.GC13051@matchmail.com>
Message-ID: <Pine.LNX.4.58.0310022142450.2887@narbuckle.genericorp.net>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
 <Pine.LNX.4.58.0310021300220.31213@narbuckle.genericorp.net>
 <Pine.LNX.4.44.0310022028220.8124-100000@serv>
 <Pine.LNX.4.58.0310021359140.31213@narbuckle.genericorp.net>
 <20031003002608.GC13051@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2 Oct 2003, Mike Fedyk wrote:

> On Thu, Oct 02, 2003 at 02:00:25PM -0500, Dave O wrote:
> > This works, however du(1) seems to get the block size wrong:
> >
> > meatloop:/cdrom# ls -l
> > total 393244
> > -rwxr-xr-x    1 501      dialout  341952833 Sep 22 17:24 else.zip
> > -rwxr-xr-x    1 501      dialout  450701627 Sep 22 20:07 outlook.zip
> > -rwxr-xr-x    1 501      dialout  607534655 Sep 22 17:26 quick1.zip
> > -rwxr-xr-x    1 501      dialout  431279243 Sep 22 17:26 quick2.zip
> > -rwxr-xr-x    1 501      dialout  605501959 Sep 22 17:27 quick3.zip
> > -rwxr-xr-x    1 501      dialout  403836898 Sep 22 17:28 quick4.zip
> > -rwxr-xr-x    1 501      dialout  380636073 Sep 22 17:28 quick5.zip
> >
> > meatloop:/cdrom# du -sh
> > 385M    .
>
> Are you sure?  I haven't done the math, but you are comparing base 1000 to
> base 1024 numbers.  Try comparing:
>
> du -sh .
> ls -lh
>

There's not that much to be sure about.  A single file there (else.zip) is
over 300 megs itself, and the total of all the files is about 3 gigs
