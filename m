Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSFDTwk>; Tue, 4 Jun 2002 15:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSFDTwT>; Tue, 4 Jun 2002 15:52:19 -0400
Received: from [195.39.17.254] ([195.39.17.254]:31391 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316662AbSFDTvD>;
	Tue, 4 Jun 2002 15:51:03 -0400
Date: Tue, 4 Jun 2002 16:10:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020604161001.K36@toy.ucw.cz>
In-Reply-To: <3CFB2A38.60242CBA@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We have released the initial implementation of the Adeos nanokernel.
> The following is a complete description of its background, its
> implementation, its API, and its potential uses. Please also see the
> press release (http://www.freesoftware.fsf.org/adeos/pr-2002-06-03.en.txt)
> and the project's workspace (http://freesoftware.fsf.org/projects/adeos/).
> The Adeos code is distributed under the GNU GPL.

Sounds interesting...

> Here are some of the possible uses for Adeos (this list is far
> from complete):
> 1) Much like User-Mode Linux, it should now be possible to have 2
> Linux kernels living side-by-side on the same hardware. In contrast
> to UML, this would not be 2 kernels one ontop of the other, but
> really side-by-side. Since Linux can be told at boot time to use
> only one portion of the available RAM, on a 128MB machine this
> would mean that the first could be made to use the 0-64MB space and
> the second would use the 64-128MB space. We realize that many
> modifications are required. Among other things, one of the 2 kernels
> will not need to conduct hardware initialization. Nevertheless, this
> possibility should be studied closer.

Also, unlike UML, kernels are not protected from each other.

> 2) It follows from #1 that adding other kernels beside Linux should
> be feasible. BSD is a prime candidate, but it would also be nice to
> see what virtualizers such as VMWare and Plex86 could do with Adeos.
> Proprietary operating systems could potentially also be accomodated.

So if your FreeBSD+Linux combination crashes, you do not know if Linux or 
FreeBSD caused it.

> 5) Drivers who require absolute priority and dislike other kernel
> portions who use cli/sti can now create a domain of their own
> and place themselves before Linux in the ipipe. This provides a
> mechanism for the implementation of systems that can provide guaranteed
> realtime response.

This is same approach rtLinux takes, right?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

