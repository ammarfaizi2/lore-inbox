Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTIEKGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbTIEKGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:06:15 -0400
Received: from [195.39.17.254] ([195.39.17.254]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262373AbTIEKGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:06:14 -0400
Date: Fri, 5 Sep 2003 12:06:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Ed Sweetman <ed.sweetman@wmich.edu>,
       Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] extents support for EXT3
Message-ID: <20030905100607.GA220@elf.ucw.cz>
References: <m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu> <m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu> <m3ad9snxo6.fsf@bzzz.home.net> <3F4FAFA2.4080202@wmich.edu> <20030829213940.GC3846@matchmail.com> <3F4FD2BE.1020505@wmich.edu> <20030829231726.GE3846@matchmail.com> <m18yp9r2uq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18yp9r2uq.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > you get no real slowdown as far as rough benchmarks are concerned, 
> > > perhaps with a microbenchmark you would see one and also, doesn't it 
> > > take up more space to save the extent info and such? Either way, all of 
> > > it's real benefits occur on large files.
> > 
> > IIRC, if your blocks are contiguous, you can save as soon as soon as the
> > file size goes above one block (witout extents, the first 12 blocks are
> > pointed to by what?  I forget... :-/ )
> 
> They are pointed to directly from the inode.
> 
> In light of other concerns how reasonable is a switch to e2fsck that
> will remove extents so people can downgrade filesystems?

It is going to be non-trivial: downgrading filesystem will likely need
free space. And now: what happens when there's no free space?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
