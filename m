Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263773AbTKFRWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTKFRWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:22:53 -0500
Received: from thunk.org ([140.239.227.29]:32923 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263773AbTKFRWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:22:51 -0500
Date: Thu, 6 Nov 2003 12:22:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Robert Gyazig <juliarobertz_fan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: undo an mke2fs !!
Message-ID: <20031106172239.GA24360@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Pavel Machek <pavel@ucw.cz>,
	Robert Gyazig <juliarobertz_fan@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20031106055601.75420.qmail@web21505.mail.yahoo.com> <20031106133442.GB23624@thunk.org> <20031106150148.GA27873@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106150148.GA27873@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 04:01:48PM +0100, Pavel Machek wrote:
> Hi!
> 
> > If you had backed up the metadata using an e2image command, you would
> > have been fine, but that command takes a while to run, so most people
> > don't bother to do this.  (Not a bad idea for the absolute paranoids
> > in the house would be to run e2image out of a cron script and save the
> > image file on some *other* filesystem.)
> 
> Assuming I have e2image (I'm actually started to thinking it is pretty
> good idea)... how do I restore it?

<Blush> The libext2fs library routines are there, but the userspace
tools haven't been written yet.  What I've done the few times when
I've used it is to let debugfs access the image file, and use it
mostly for examination purposes.  

What I'll probably do is add debugfs commands that allow you to copy
the superblock/block group descriptors, or the inode table, or the
block/inode allocation bitmaps from the image file back to the
filesystem.  As I said, the library routines are there, but debugfs
front ends haven't been written yet.  If someone has a critical
situation requiring them, I could probably throw together patches
within a day or so.

						- Ted

