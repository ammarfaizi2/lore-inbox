Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTLJAHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTLJAHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:07:16 -0500
Received: from gprs145-126.eurotel.cz ([160.218.145.126]:38786 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261262AbTLJAHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:07:13 -0500
Date: Wed, 10 Dec 2003 01:07:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Matthew Wilcox <willy@debian.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
Message-ID: <20031210000759.GA618@elf.ucw.cz>
References: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk> <200312051947.hB5Jlupp030878@agora.fsl.cs.sunysb.edu> <20031205202838.GD29469@parcelfarce.linux.theplanet.co.uk> <3FD127D4.9030007@lougher.demon.co.uk> <1070883425.31993.80.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070883425.31993.80.camel@hades.cambridge.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Of course, all this is at the logical file level, and ignores the 
> > physical blocks on disk.  All filesystems assume physical data blocks 
> > can be updated in place.  With compression it is possible a new physical 
> > block has to be found, especially if blocks are highly packed and not 
> > aligned to block boundaries.  I expect this is at least partially why 
> > JFFS2 is a log structured filesystem.
> 
> Not really. JFFS2 is a log structured file system because it's designed
> to work on _flash_, not on block devices. You have an eraseblock size of
> typically 64KiB, you can clear bits in that 'block' all you like till
> they're all gone or you're bored, then you have to erase it back to all
> 0xFF again and start over.
> 
> Even if you were going to admit to having a block size of 64KiB to the
> layers above you, you just can't _do_ atomic replacement of blocks,
> which is required for normal file systems to operate correctly.

Are those assumptions needed for something else than recovery after
crash/powerdown? [i.e., afaics 64K ext2 should work on flash, but fsck
might have some troubles...]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
