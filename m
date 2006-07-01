Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWGAK3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWGAK3z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWGAK3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:29:55 -0400
Received: from thunk.org ([69.25.196.29]:40373 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932379AbWGAK3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:29:55 -0400
Date: Sat, 1 Jul 2006 06:29:35 -0400
From: Theodore Tso <tytso@mit.edu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Proposal and plan for ext2/3 future development work
Message-ID: <20060701102935.GA12468@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org> <p73sllnvsej.fsf@verdi.suse.de> <20060630151432.GA21675@thunk.org> <20060701094206.GA17588@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701094206.GA17588@stusta.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 11:42:06AM +0200, Adrian Bunk wrote:
> > There were a lot of people who were concerned that simply marking it
> > CONFIG_EXPERIMENTAL might not be enough for to make it very clear that
> > the filesystem format is still changing.  In order to address this
> > concern, we want /etc/fstab to make it abundantly clear that the
> > filesystem format itself is not necessarily stable, and that new
> > features are being added that might not be supported on older
> > kernels.
> >...
> 
> What about a dependency on CONFIG_BROKEN?
> 
> This will require everyone who wants to use it to manually edit the 
> Kconfig file for removing the dependency - which sounds like a good 
> idea.

It's not broken; just experimental.  I think CONFIG_EXPERIMENTAL is
accurately describes the status of fs/ext4 as we plan it.  Patches
will be reviewed and tested via quilt series and/or git trees before
they get pushed to fs/ext4, so the expectation isn't that data will be
lost; only that if you want to downgrade to an earlier kernel, and
explicitly enable the latest bleeding edge feature, you might have to
do some work first.  (Which might be dump/reformat/restore, or it
might be "tune2fs -O ^new_feature /dev/sdXX; e2fsck /dev/sdXX" with a
development snapshot of e2fsprogs.)

						- Ted
