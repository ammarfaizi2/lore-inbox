Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268261AbUIBUo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268261AbUIBUo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269097AbUIBUnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:43:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29373 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269043AbUIBUm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:42:27 -0400
Date: Thu, 2 Sep 2004 22:42:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Spam <spam@tnonline.net>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Lee Revell <rlrevell@joe-job.com>, Jamie Lokier <jamie@shareable.org>,
       David Masover <ninja@slaphack.com>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902204225.GD8653@atrey.karlin.mff.cuni.cz>
References: <rlrevell@joe-job.com> <1094079071.1343.25.camel@krustophenia.net> <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl> <1535878866.20040902214144@tnonline.net> <1094151338.5645.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094151338.5645.32.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It is trivial to implement this by looking inside the files. I.e., the way
> > > mc has done this for ages.
> > 
> >   Difference is that you can't do "locate" or "find" or "Search".. You
> >   would have to open the files in an archive-supporting application
> >   such as mc.
> 
> And would you rather that logic was running swappable in shared library
> space or privileged and unswappable in kernel ?

Well, having it in kernel mean that cache gets actually shared between
different processes -- and that's usefull. With coda and similar tools
you can put most of the logic into userspace (kernel impact is 20
lines). You *will* want it to run priviledged, because otherwise
caches are useless.
								Pavel
