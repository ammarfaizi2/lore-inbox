Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262542AbSI0S3v>; Fri, 27 Sep 2002 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbSI0S3v>; Fri, 27 Sep 2002 14:29:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:65411 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262542AbSI0S3u>;
	Fri, 27 Sep 2002 14:29:50 -0400
Message-ID: <3D94A4D9.D458D453@digeo.com>
Date: Fri, 27 Sep 2002 11:35:05 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ingo Molnar <mingo@elte.hu>, Chris Wedgwood <cw@f00f.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 'virtual => physical page mapping cache',vcache-2.5.38-B8
References: <Pine.LNX.4.44.0209271952540.17034-100000@localhost.localdomain> <1033149675.16758.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2002 18:34:58.0815 (UTC) FILETIME=[955050F0:01C26654]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Fri, 2002-09-27 at 18:53, Ingo Molnar wrote:
> >
> > On Fri, 27 Sep 2002, Chris Wedgwood wrote:
> >
> > > O_DIRECT is allow to break if someone does something silly :)  [...]
> >
> > to DMA into a page that does not belong to the process anymore? I doubt
> > that.
> 
> Try doing a truncate on a file as an O_DIRECT write is occuring.
> Scribbling into pages you dont own is the least of your problems.

O_DIRECT writes operate under i_sem, which provides exclusion
from trucate.  Do you know something which I don't??
