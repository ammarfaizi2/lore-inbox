Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTFOO0T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTFOO0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:26:19 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:44209 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262269AbTFOO0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:26:06 -0400
Date: Sun, 15 Jun 2003 09:36:31 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@bitmover.com>
Subject: bkSVN live
Message-ID: <20030615133631.GF542@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Larry, the bkSVN repo is now live. It's actually bkcvs2svn,
since I am using bkcvs's metadata. However subversion is able to make
better use of the metadata than CVS can. You can get better log output,
for one. Also, you can more easily determine the scope of a change,
since subversion supports changesets.

If you aren't familiar with subversion, please visit the URL in my sig.
Please do not ask me a lot of questions about it. First off, it's very
well documented, and second off, I am not what I would consider an
expert on the internals of SVN.

And please DO NOT email linux-kernel with any comments, suggestions,
questions regarding subversion. It is way off topic. Subversion !=
BitKeeper, and it's not intended to replace it. So this isn't a
competition. Otherwise, Larry wouldn't feel so comfortable with hosting
the repo :)

For those that know SVN, you need a recent (e.g. upcoming 0.24 release
of SVN, or current trunk) client. I am using revision r6227. If you need
a client just for testing, you can get a ra_svn only static binary from
http://www.phunnypharm.org/pub/svn/clients/linux/. i386, sparc and ia64
are there. I can build more if needed (I think I have access to just
about anything). You'll need glibc 2.3 for the static clients since it
uses NSS modules, and well, it just wont work with 2.2/2.1/etc. If you
want to build your own, remember, you don't need berkeley DB, or neon
to access this repo.

Now, finally the SVN URL's:

	svn://kernel.bkbits.net/linux-2.4

	svn://kernel.bkbits.net/linux-2.5

WAIT. If you don't know anything about SVN repo layouts, just remember
this:

	REPO_BASE/trunk		Primary (aka HEAD) development
	REPO_BASE/tags/*	Tagged revsions
	REPO_BASE/branches/*	Other development lines (not used in bkSVN)

So, to get the main development for say 2.5:

# svn co svn://kernel.bkbits.net/linux-2.5/trunk linux-2.5-bkbits

Will checkout the main 2.5 trunk into a directory called
linux-2.5-bkbits. Then you can cd into that directory and do "svn up"
just like CVS :). The "svn log" output is much better than in CVS, since
you can do things like "svn log drivers/usb" and get a single list of
revisions that affected anything in drivers/usb, unlike CVS where you
would get history for all files seperately. "svn help" is really useful
aswell.

If you want to checkout a particular version:

# svn co svn://kernel.bkbits.net/linux-2.5/tags/v2.5.60 linux-2.5.60

Or diff versions, via URL, without a working copy:

# svn diff svn://kernel.bkbits.net/linux-2.4/tags/v2.4.19 \
	svn://kernel.bkbits.net/linux-2.4/tags/v2.4.20 > patch-2.4.20.diff

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
