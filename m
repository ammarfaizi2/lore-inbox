Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266653AbUBFHti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 02:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUBFHti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 02:49:38 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3968 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266653AbUBFHth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 02:49:37 -0500
Date: Fri, 6 Feb 2004 07:58:43 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402060758.i167whxX000498@81-2-122-30.bradfords.org.uk>
To: Eduard Bloch <edi@gmx.de>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       alan@redhat.com
In-Reply-To: <20040205233113.GA10254@zombie.inka.de>
References: <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk>
 <yw1xsmhsf882.fsf@kth.se>
 <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
 <20040203174606.GG3967@aurora.fi.muni.cz>
 <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk>
 <yw1xn080m1d2.fsf@kth.se>
 <Pine.LNX.4.53.0402031509100.32547@chaos>
 <20040203224021.GK11683@suse.de>
 <1075849526.11322.9.camel@nosferatu.lan>
 <200402040737.i147bJqq000455@81-2-122-30.bradfords.org.uk>
 <20040205233113.GA10254@zombie.inka.de>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Of course you get problems if a raw devices changes underneath a
> > mounted filesystem, I would expect that.  That is _NOT_ what we were
> > talking about _AT ALL_.  The point is that the device itself caches
> > the state of the disc over an erase, so even if the device is
> > unmounted before an erase, when it is re-mounted, the stale data is
> > read from the device's own cache, which should have been invalidated
> > by the erase.
> 
> Is it realy a hardware issue?

I originally thought so, but maybe I was wrong.  Jens posted a patch
to invalidate kernel buffers on an umount - if the problem persists
with that patch, I still believe it is a hardware fault.

> Oh, and it is very simple to shout on anyone "Just eject and reload,
> there is no issue, everything pointless".

Well, I never suggested that, and I don't think it's an acceptable
solution, unless the problem is limited to a few broken drives.

John.
