Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSIODvt>; Sat, 14 Sep 2002 23:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317708AbSIODvs>; Sat, 14 Sep 2002 23:51:48 -0400
Received: from packet.digeo.com ([12.110.80.53]:24194 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317701AbSIODvs>;
	Sat, 14 Sep 2002 23:51:48 -0400
Message-ID: <3D8408A9.7B34483D@digeo.com>
Date: Sat, 14 Sep 2002 21:12:25 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.34-mm2
References: <3D803434.F2A58357@digeo.com> <E17qQMq-0001JV-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 03:56:36.0676 (UTC) FILETIME=[E36F1840:01C25C6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Thursday 12 September 2002 08:29, Andrew Morton wrote:
> > url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.34/2.5.34-mm2/
> >
> > -sleeping-release_page.patch
> 
> What's this one?  Couldn't find it as a broken-out patch.

The `-' means it was removed from the patchset.  Linus merged it.
See  2.5.34/2.5.34-mm1/broken-out/sleeping-release_page.patch

> On the nonblocking vm front, does it rule or suck?

It rules, until someone finds something at which it sucks.

>  I heard you
> mention, on the one hand, huge speedups on some load (dbench I think)
> but your in-patch comments mention slowdown by 1.7X on kernel
> compile.

You misread.  Relative times for running `make -j6 bzImage' with mem=512m:

Unloaded system:		                     1.0
2.5.34-mm4, while running 4 x `dbench 100'           1.7
Any other kernel while running 4 x `dbench 100'      basically infinity
