Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSEaSUc>; Fri, 31 May 2002 14:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSEaSUb>; Fri, 31 May 2002 14:20:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20828 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315762AbSEaSUa>; Fri, 31 May 2002 14:20:30 -0400
Date: Fri, 31 May 2002 20:19:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Andrew Morton <akpm@zip.com.au>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <20020531181946.GI1172@dualathlon.random>
In-Reply-To: <200205241004.g4OA4Ul28364@mail.pronto.tv> <200205301029.g4UATuE03249@mail.pronto.tv> <3CF67D5F.3398C893@zip.com.au> <200205311656.g4VGut009607@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 06:56:54PM +0200, Roy Sigurd Karlsbakk wrote:
> > I suspect nuke-buffers is simply always the right thing to do.  It's
> > what 2.5 is doing now (effectively).  We'll see...
> >
> > But in your case, you only have a couple of gigs of memory, iirc.
> > You shouldn't be running into catastrophic buffer_head congestion.
> > Something odd is happening.
> >
> > If you can provide a really detailed set of steps which can be
> > used by others to reproduce this, that would really help.
> 
> What I do: start lots (10-50) downloads, each with a speed of 4,5Mbps from 
> another client. The two are connected using gigEthernet. downloads are over 
> HTTP, with Tux or other servers (have tried several). If the clients are 
> reading at full speed (e.g. only a few clients, or reading directly from 
> localhost), the problem doesn't occir. However, when reading at a fixed rate, 
> it seems like the server is caching itself to death.
> 
> 
> Detailed configuration:
> 
> - 4 IBM 40gig disks in RAID-0. chunk size 1MB
> - 1 x athlon 1GHz
> - 1GB RAM - no highmem (900 meg)
> - kernel 2.4.19pre7 + patch from Andrew Morton to ditch buffers early 
>         (thread: [BUG] 2.4 VM sucks. Again)
> - gigEthernet between test client and server
> 
> Anyone got a clue?

can you try to reproduce with 2.4.19pre9aa2 just in case it's an oom
deadlock, and if it deadlocks again can you press SYSRQ+T, and many
times SYSQR+P, and send this info along the system.map (you may need the
serial console to easily gather the data if not even a SYSRQ+I is able
to let the box resurrect from the livelock). (the system.map possibly
not on l-k because it's quite big)

thanks!

Andrea
