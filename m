Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTKGWxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTKGW0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:04 -0500
Received: from witte.sonytel.be ([80.88.33.193]:49045 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264051AbTKGKd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 05:33:56 -0500
Date: Fri, 7 Nov 2003 11:33:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pavel Machek <pavel@ucw.cz>
cc: "Theodore Ts'o" <tytso@mit.edu>,
       Robert Gyazig <juliarobertz_fan@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: undo an mke2fs !!
In-Reply-To: <20031106192114.GA23892@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0311071133060.605-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, Pavel Machek wrote:
> > > > If you had backed up the metadata using an e2image command, you would
> > > > have been fine, but that command takes a while to run, so most people
> > > > don't bother to do this.  (Not a bad idea for the absolute paranoids
> > > > in the house would be to run e2image out of a cron script and save the
> > > > image file on some *other* filesystem.)
> > > 
> > > Assuming I have e2image (I'm actually started to thinking it is pretty
> > > good idea)... how do I restore it?
> > 
> > <Blush> The libext2fs library routines are there, but the userspace
> > tools haven't been written yet.  What I've done the few times when
> > I've used it is to let debugfs access the image file, and use it
> > mostly for examination purposes.  
> > 
> > What I'll probably do is add debugfs commands that allow you to copy
> > the superblock/block group descriptors, or the inode table, or the
> > block/inode allocation bitmaps from the image file back to the
> > filesystem.  As I said, the library routines are there, but debugfs
> > front ends haven't been written yet.  If someone has a critical
> > situation requiring them, I could probably throw together patches
> > within a day or so.
> 
> I guess I'll start recomending e2image to people trying software
> suspend ;-). It really seems like neat tool for "easy backups".

Note that according to Ted's first post, e2image backs up the _metadata_. He
didn't mention the real data...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

