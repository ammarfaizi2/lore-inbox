Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269442AbUICQqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269442AbUICQqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUICQpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:45:12 -0400
Received: from [195.135.223.198] ([195.135.223.198]:12416 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269442AbUICQnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:43:00 -0400
Date: Fri, 3 Sep 2004 17:44:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040903154431.GB1396@elf.ucw.cz>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I bet you could write a small library to test this out for a few types.  
> See if it's useful to you. And only if it's useful (and would make a huge
> performance difference) would it be worth putting in the kernel.

It seemed really usefull in uservfs incarnation. Unfortunately the
daemon was not multihreaded at that time, so it was not really usefull
on multiuser systems :-(

> Implementation of the _user_space_ library would be something like this:
> 
> 	#define MAXNAME 1024
> 	int open_cached_view(int base_fd, char *type, char *subname)

Well, you'd need more than simple open. For caching tar (etc), you'd
need stat_cached_view and opendir_cached_view and ...

And this really works, only that its called mc_open(), mc_stat() etc.

Gnome actually uses newer incarnation of mc_open etc, but they had to
introduce rather ugly interface to make it asynchronous.
								Pavel
-- 
When do you have heart between your knees?
