Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286672AbRL1Brm>; Thu, 27 Dec 2001 20:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286653AbRL1Brc>; Thu, 27 Dec 2001 20:47:32 -0500
Received: from bitmover.com ([192.132.92.2]:1184 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286649AbRL1Br2>;
	Thu, 27 Dec 2001 20:47:28 -0500
Date: Thu, 27 Dec 2001 17:47:23 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011227174723.V25698@work.bitmover.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227173739.U25698@work.bitmover.com> <18754.1009503708@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <18754.1009503708@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Fri, Dec 28, 2001 at 12:41:48PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 12:41:48PM +1100, Keith Owens wrote:
> On Thu, 27 Dec 2001 17:37:39 -0800, 
> Larry McVoy <lm@bitmover.com> wrote:
> >A couple of questions:
> >
> >a) will 2.5 be as fast as the current system?  Faster?
> 
> At the moment kbuild 2.5 ranges from 10% faster on small builds to 100%
> slower on a full kernel build.  

I don't understand why it would be slower.  Maybe I'm clueless but I thought
you were moving more towards a single makefile system, kind of like what
BSD had about 15 years ago, you went to /sys/MYMACHINE and typed make and
it did the build completely in that directory.  You did different configs
by running a configure tool that made /sys/MYMACHINE /sys/YOURMACHINE, etc.

If this is the general approach, shouldn't this be a lot faster than the
current approach?  The current approach stats stuff many times.  Linux is
really good at making stats cheap, but nothing is as good as not doing it
twice.

Am I completely misunderstanding what kbuild is all about?  My apologies
if so...
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
