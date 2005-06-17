Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVFQVJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVFQVJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 17:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVFQVJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 17:09:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262085AbVFQVJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 17:09:15 -0400
Date: Fri, 17 Jun 2005 14:10:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: kernel bugzilla
Message-Id: <20050617141003.2abdd8e5.akpm@osdl.org>
In-Reply-To: <20050617142225.GO6957@suse.de>
References: <20050617001330.294950ac.akpm@osdl.org>
	<1119016223.5049.3.camel@mulgrave>
	<20050617142225.GO6957@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Seeing as I did all this typing I added linux-kernel and changed the
subject.  I trust that's OK).

Jens Axboe <axboe@suse.de> wrote:
>
> > If bugzilla can now collect email, just have it forward the bug reports
> > to linux-scsi as through it were from the reporter with itself on the cc
> > list.

It can be set up to report scsi bugs to a mailing list.  So we can replace
andmike with linux-scsi@vger.kernel.org as the person who gets notification
emails for scsi-related bug reports.

And, apparently, bugzilla will now accept emails and will file them away in
the right place.  I've asked Martin to help set bugzilla up so that people
who don't have a bugzilla account will be accepted into the database as well.

> imho, the kernel.org bugzilla should be abandoned.

That's what I used to think.  Until I started trying to keep track of open
bugs against late -rc kernels.  Now, the ability which bugzilla has to keep
track of open bugs and to keep track of all the correspondence associated
with a bug is looking really attractive.

That's why I want it to integrate seamlessly with our normal email-based
processes.  So we can get the best of both worlds.

> is anyone
> (developers) using it successfully?

The ACPI team use bugzilla a lot.

For those bugs which are handled in bugzilla rather than via random emails,
yeah, I'm finding bugzilla preferable.


I haven't tested this yet, but hopefully I will now be able to:

- get an email from bugme

- reply to it and cc linux-kernel and a maintainer

- Other people will comment in the normal manner with reply-to-all

- bugzilla will capture everything.

Suddenly, my ability to track open bugs gets a heap better, and nobody is
impacted at all - just an additional Cc.

One thing I haven't worked out is how to get a bug which is initially
reported via email *into* the bugzilla system for tracking purposes.  One
could just ask the originator to raise a bugzilla entry, as lots of other
projects do.  But I don't think we want to do that - it's in our interest
to make bug reporting as easy as possible for the reporter, rather than
putting up barriers.

Another problem is: what happens if a bug has been discussed via email
which is cc'ed to linux-kernel and bugzilla, and then someone comes along
and updates the bug record via the bugzilla web interface?  I suspect those
people who had been following the discussion via email wouldn't see the
update.  So bugzilla needs to a) automatically add all incoming Cc's to the
records's cc list and b) automatically add all known cc's to outgoing
notifications.
