Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTKMLmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTKMLmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:42:06 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:9879 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263887AbTKMLmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:42:04 -0500
Date: Thu, 13 Nov 2003 12:38:47 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Weird ext2 problem in 2.4.18 (redhat)
Message-ID: <20031113113847.GX643@openzaurus.ucw.cz>
References: <20031108063341.GA8349@work.bitmover.com> <20031108164410.GB2955@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031108164410.GB2955@thunk.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hey, neato, it gets weirder.  I went to go run an example and now most of
> > the files in " src/" are gone, most but not all.
> 
> Sounds like there is a two directory entries with the same name in the
> same directory.  This can cuase severe confusion since the kernel
> assumes that this will never happen.  Depending on which one gets
> found first, and what is cached in the dentry cache, you'll get one
> inode or the other.
> 
> E2fsck doesn't normally notice these sorts of inconsistencies, since
> it takes too much time and memory to look for duplicate entries.  If
> you optimize directories using "e2fsck -fD", it will find and offer to
> rename directory entires with a duplicated name.

Is not that a little dangerous? I'd expect filesystem to be
okay after doing plain normal check.

What about at least documenting it in BUGS section of man
page?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

