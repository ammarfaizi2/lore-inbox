Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269462AbUICJsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269462AbUICJsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUICJpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:45:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40086 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269631AbUICJmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:42:06 -0400
Date: Fri, 3 Sep 2004 11:42:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Spam <spam@tnonline.net>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040903094205.GB11021@atrey.karlin.mff.cuni.cz>
References: <rlrevell@joe-job.com> <1094079071.1343.25.camel@krustophenia.net> <200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl> <1535878866.20040902214144@tnonline.net> <20040902194909.GA8653@atrey.karlin.mff.cuni.cz> <1094155277.11364.92.camel@krustophenia.net> <20040902204351.GE8653@atrey.karlin.mff.cuni.cz> <1094158060.1347.16.camel@krustophenia.net> <20040902205857.GF8653@atrey.karlin.mff.cuni.cz> <1094164385.6163.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094164385.6163.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Uservfs.sf.net.
> > 
> > Unlike alan, I do not think that "do it all in library" is good
> > idea. I put it in the userspace as "codafs" server, and let
> > applications see it as a regular filesystem.
> 
> That works for me too, providing someone has fixed all the user mode fs
> deadlocks with paging

Its okay: coda works on whole file granularity, and files are backed
by real disk, so there are no deadlocks with paging. We only block
open() and similar syscalls, and those are not in paging paths. It
should be safe.
								Pavel

