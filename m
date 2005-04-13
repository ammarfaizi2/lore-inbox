Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVDMKTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVDMKTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVDMKTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:19:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43563
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261289AbVDMKTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:19:41 -0400
Date: Wed, 13 Apr 2005 12:20:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, David Eger <eger@havoc.gtf.org>,
       Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050413102046.GM1521@opteron.random>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org> <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <20050412234005.GJ1521@opteron.random> <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org> <20050413103052.C1798@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413103052.C1798@flint.arm.linux.org.uk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 10:30:52AM +0100, Russell King wrote:
> And my entire 2.6.12-rc2 BK tree, unchecked out, is about 220MB, which
> is more dense than CVS.

Yep, this is why I mentioned SCCS format too, I didn't know it was even
smaller, but I expected a similar density from SCCS.

> Note: I'm _not_ arguing with your sentiments towards CVS.  However, I
> think the space usage point still stands.

If it wasn't for network synchronization it almost wouldn't matter, but
fetching 2.8G uncompressible when I could simply fetch 220MB
compressible (that will compress with zlib at little cost during rsync
to less than 78M), sounds a bit overkill.

> What is the space usage behaviour when you have multiple git trees?

Multiple trees in the sense of pulls from multiple developers aren't
more costly than a normal checkin, due the "soft hardlink" property of
the hashes. It's just every checkin taking lots of space, and generating
a new uncompressible blobs every time a changeset touches one file.
