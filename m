Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266860AbUBEVM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266863AbUBEVM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:12:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46005 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266860AbUBEVMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:12:15 -0500
Date: Thu, 5 Feb 2004 22:12:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Tomas Zvala <tomas@zvala.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205211212.GG11683@suse.de>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <20040203152805.GI11683@suse.de> <20040205182335.GB294@elf.ucw.cz> <20040205204109.GD11683@suse.de> <20040205210907.GB1541@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205210907.GB1541@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05 2004, Pavel Machek wrote:
> Hi!
> 
> > > > > I believe he meant to write he umounted it.
> > > > > The problem is that there is still some data left in CDRW's cache and it 
> > > > > needs to be emptied. That happens when CDRW is ejected and reinserted 
> > > > > (that is why windows burning software ie. Nero wants to eject the CDR/RW 
> > > > > when it gets written or erased).
> > > > > Maybe kernel could flush the buffers/caches or whatever is there when 
> > > > > CDROM gets mounted. But im afraid about compatibility with broken drives 
> > > > > such as LG.
> > > > 
> > > > There's no command to invalidate read cache, you are probably thinking
> > > > of the SYNC_CACHE command to flush dirty data to media (which is what LG
> > > > fucked up).
> > > > 
> > > > IMO, it's a user problem.
> > > 
> > > Does not look like so.
> > > 
> > > mount
> > > umount
> > > cdrecord -blank
> > > mount
> > > see old data
> > > 
> > > That looks pretty bad. If there's no other solution, we might just
> > > document it, but...
> > 
> > Nonsense. Even if the above was what the user did (I believe he didn't
> > umount the device before blanking it), then it'd be a hardware "bug".
> > It's common to require an eject to completely clear the cache.
> 
> Later in the thread user said he did indeed do umount, and it is
> reproducible for him.
> 
> Okay, we may be dealing with the buggy hardware at this point. Would
> it make sense to tell the drive to flush it caches? If there's no
> other possibility, we might want cdrecord to reset drive at the end of
> blank and/or to make it eject...

Just have cdrecord eject the disc, it's pretty common. Resetting the
drive is a bit drastic, imho.

-- 
Jens Axboe

