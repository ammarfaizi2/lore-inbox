Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263130AbTCSUBP>; Wed, 19 Mar 2003 15:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263125AbTCSUBP>; Wed, 19 Mar 2003 15:01:15 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:27490 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S263130AbTCSUAU>;
	Wed, 19 Mar 2003 15:00:20 -0500
Date: Wed, 19 Mar 2003 21:11:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Mansfield <lkml@dm.cobite.com>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
Subject: Re: [ANNOUNCE] cvsps support for parsing BK->CVS kernel tree logs
Message-ID: <20030319201101.GQ30541@dualathlon.random>
References: <Pine.LNX.4.44.0303181214360.21884-100000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303181214360.21884-100000@admin>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what about the deleted files? should we teach cvsps how to diff the old
revision fetched with cvs up -p against /dev/null to make a completely
coherent patch?

this is with 2.4

Directing PatchSet 2742 to file ../patches-2.4//2742.patch
cvs [update aborted]: no such directory `drivers/usb/hcd'
cvs [update aborted]: no such directory `drivers/usb/hcd'
cvs [update aborted]: no such directory `drivers/usb/hcd'
cvs [update aborted]: no such directory `drivers/usb/hcd'
cvs [update aborted]: no such directory `drivers/usb/hcd'
cvs [update aborted]: no such directory `drivers/usb/hcd'
cvs [update aborted]: no such directory `drivers/usb/hcd'
cvs [update aborted]: no such directory `drivers/usb/hcd'
cvs [update aborted]: no such directory `drivers/usb/hcd'

I also wonder if cvsps is so accurate also w/o the --bkcvs option (i.e.
w/o atomic commits from bk). are the dates guaranteed to be the same for
all files w/ a normal cvs tree?

what about the -f option? why can't I use it at the same time with -r?
Can I use multiple -f at the same time? That is getting very cool and so
useful.

Would also be nice to export the API of the cvsps internals to python
(i.e. to allow to efficiently parse the cvsps metadata files in .cvsps
from scripts that will give the flexibility of parsing the data as
you want or to quickly write a gui fronthand). This is low prio though,
having -f working together with -r and all the other options is much
more interesting at this point IMHO.  Being able to specify a directory
as a file would also be very useful.

thanks!

Andrea
