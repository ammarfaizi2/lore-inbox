Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbRFTDE6>; Tue, 19 Jun 2001 23:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbRFTDEt>; Tue, 19 Jun 2001 23:04:49 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:8800
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264836AbRFTDEn>; Tue, 19 Jun 2001 23:04:43 -0400
Date: Tue, 19 Jun 2001 20:04:42 -0700
From: Larry McVoy <lm@bitmover.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010619200442.E30785@work.bitmover.com>
Mail-Followup-To: Michael Rothwell <rothwell@holly-springs.nc.us>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15CQlA-0006Tr-00@the-village.bc.nu> <993005859.1799.1.camel@gromit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <993005859.1799.1.camel@gromit>; from rothwell@holly-springs.nc.us on Tue, Jun 19, 2001 at 10:57:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 10:57:38PM -0400, Michael Rothwell wrote:
> On 19 Jun 2001 20:01:56 +0100, Alan Cox wrote:
> 
> > Linux inherits several unix properties which are not friendly to good state
> > based programming - lack of good AIO for one.
> 
> Oh, how I would love for select() and poll() to work on files... or for
> any other working AIO mothods to be present.
> 
> What would get broken if things were changed to let select() work for
> filesystem fds?

I asked Linus for this a long time ago and he pointed out that you couldn't
make it work over NFS, at least not nicely.  It does seem like that could 
be worked around by having a "poll daemon" which knew about all the things
being waited on and checked them.  Or something.

I'd like it too.  And I'd like a callback for iocompletion, a way to do
preread(fd, len).

On the other hand, the fact that it doesn't exist on other platforms sort
of means that it isn't going anywhere.  In a sick sort of way, the most
likely way to make this happen is to get Microsoft to do it and then Linux
will do it as well and then the Solaris jocks will also fall in line.  The
only problem with that is that Microsoft can't design an OS interface to save 
their lives, so maybe Linux _should_ do it first.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
