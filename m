Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUGMMlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUGMMlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUGMMlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 08:41:25 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:5646 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264911AbUGMMlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 08:41:24 -0400
Date: Tue, 13 Jul 2004 22:40:47 +1000 (EST)
From: Tim Connors <tconnors+linuxkml@astro.swin.edu.au>
X-X-Sender: tconnors@tellurium.ssi.swin.edu.au
To: Waldo Bastian <bastian@kde.org>
cc: kde-core-devel@kde.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kconfig's file handling (was: XFS: how to NOT null files on
 fsck?)
In-Reply-To: <200407131431.43478.bastian@kde.org>
Message-ID: <Pine.LNX.4.53.0407132229370.20527@tellurium.ssi.swin.edu.au>
References: <20040713110520.GB8930@ugly.local> <200407131431.43478.bastian@kde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004, Waldo Bastian wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Tue July 13 2004 13:05, Oswald Buddenhagen wrote:
> > heya,
> >
> > read the attachement first (put on your asbestos underwear first ;).
> > not exactly news to me, but somehow i never got to fixing it ...
>
> There is nothing to fix, we already use a tempfile + rename, it's in KSaveFile
> since 1999. Or just look with strace if you don't believe me. This Tim
> Connors guy shouldn't talk about things he obviously knows nothing about.

Sorry, I'm just basing the above on my *experience* with trying to unfsck
3 different peoples kde settings when the nfs server went down.

And since it was a controlled shutdown, there would have been no cache
worries, and the fact the kde corrupted itself points to having problems
within kde, not problems within a fs or nfs.

> As far as I can see the problem is that the filesystem writes out the meta
> data before the actual file data hits the disk which creates a period of time
> in which the on-disk state of the filesystem contains trashed files. I
> believe ReiserFS actually has an option to do things in a sane order so that
> it doesn't trash recently used files on an unclean shutdown.

Well, no other program I have ever used, which does the tempfile+rename
thing, has ever failed on me.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
                  -o)
                  /\\    The penguins are coming...
                 _\_v       the penguins are coming...
