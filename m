Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316721AbSEVUD1>; Wed, 22 May 2002 16:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316725AbSEVUD0>; Wed, 22 May 2002 16:03:26 -0400
Received: from [195.39.17.254] ([195.39.17.254]:49562 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316721AbSEVUDY>;
	Wed, 22 May 2002 16:03:24 -0400
Date: Wed, 22 May 2002 14:17:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
Cc: "Gross, Mark" <mark.gross@intel.com>, linux-kernel@vger.kernel.org,
        r1vamsi@in.ibm.com
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE:    PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Message-ID: <20020522141747.G37@toy.ucw.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com> <200205220748.g4M7mc2157646@northrelay01.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Nice. This also closes another issue pointed out: freezing
> a process while it is holding the mmap_sem, which may be needed later
> while collecting thread registers on IA64.
> 
> Now that Linus has accepted Pavel's swsusp, do you have any thoughts 
> on using Pavel's scheme to freeze processes?

I attempt half of signal delivery to the threads, but that should not be
a problem. Currently freezing stuff is there only for CONFIG_SWSUSP case,
but it is probably small enough to be there unconditionaly.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

