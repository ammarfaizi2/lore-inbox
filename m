Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265875AbRF2MuB>; Fri, 29 Jun 2001 08:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265881AbRF2Mtw>; Fri, 29 Jun 2001 08:49:52 -0400
Received: from srv01s4.cas.org ([134.243.50.9]:62174 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S265875AbRF2Mti>;
	Fri, 29 Jun 2001 08:49:38 -0400
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200106291249.IAA00479@mah21awu.cas.org>
Subject: Re: O_DIRECT please; Sybase 12.5
To: dank@kegel.com (Dan Kegel)
Date: Fri, 29 Jun 2001 08:49:28 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3B3C5571.3259CD32@kegel.com> from "Dan Kegel" at Jun 29, 2001 03:16:17 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Alan Cox wrote:
> > 
> > > the boss say "If Linux makes Sybase go through the page cache on
> > > reads, maybe we'll just have to switch to Solaris.  That's
> > > a serious performance problem."
> > 
> > Thats something you'd have to benchmark. It depends on a very large number
> > of factors including whether the database uses mmap, the average I/O size
> > and the like
> 
> I'll probably benchmark raw vs. non-raw I/O with Sybase ASE 12.5
> on our application once we've come up to speed on basic performance
> issues (we're database newbies).

Quite obviously. One of the primary things a DBA is supposed to do is ensure
that the disk is accessed as *few* times as possible. What size database do
you have? How much memory has the machine have? How much memory does the
database have? How many engines is the database running?

We can take this off-list if you want, but disk I/O shouldn't really be an
issue for any database as long as other parameters are set correctly. Sybase
recommends raw devices *not* because they are faster, but because it's the
only way that they (Sybase) can guarantee the data is actually written to
disk (legal liability, etc.).

/Mike (Sybase DBA)

