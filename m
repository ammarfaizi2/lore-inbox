Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbTKFTVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTKFTVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:21:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43959 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263606AbTKFTVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:21:19 -0500
Date: Thu, 6 Nov 2003 20:21:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Robert Gyazig <juliarobertz_fan@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: undo an mke2fs !!
Message-ID: <20031106192114.GA23892@atrey.karlin.mff.cuni.cz>
References: <20031106055601.75420.qmail@web21505.mail.yahoo.com> <20031106133442.GB23624@thunk.org> <20031106150148.GA27873@atrey.karlin.mff.cuni.cz> <20031106172239.GA24360@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106172239.GA24360@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If you had backed up the metadata using an e2image command, you would
> > > have been fine, but that command takes a while to run, so most people
> > > don't bother to do this.  (Not a bad idea for the absolute paranoids
> > > in the house would be to run e2image out of a cron script and save the
> > > image file on some *other* filesystem.)
> > 
> > Assuming I have e2image (I'm actually started to thinking it is pretty
> > good idea)... how do I restore it?
> 
> <Blush> The libext2fs library routines are there, but the userspace
> tools haven't been written yet.  What I've done the few times when
> I've used it is to let debugfs access the image file, and use it
> mostly for examination purposes.  
> 
> What I'll probably do is add debugfs commands that allow you to copy
> the superblock/block group descriptors, or the inode table, or the
> block/inode allocation bitmaps from the image file back to the
> filesystem.  As I said, the library routines are there, but debugfs
> front ends haven't been written yet.  If someone has a critical
> situation requiring them, I could probably throw together patches
> within a day or so.

I guess I'll start recomending e2image to people trying software
suspend ;-). It really seems like neat tool for "easy backups".

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
