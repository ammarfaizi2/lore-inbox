Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286649AbRL1CCN>; Thu, 27 Dec 2001 21:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286688AbRL1CCD>; Thu, 27 Dec 2001 21:02:03 -0500
Received: from bitmover.com ([192.132.92.2]:9632 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286685AbRL1CBw>;
	Thu, 27 Dec 2001 21:01:52 -0500
Date: Thu, 27 Dec 2001 18:01:48 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011227180148.A3727@work.bitmover.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227174723.V25698@work.bitmover.com> <19047.1009504678@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <19047.1009504678@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Fri, Dec 28, 2001 at 12:57:58PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unlike the broken make dep, kbuild 2.5 extracts accurate dependencies
> by using the -MD option of cpp and post processing the cpp list.  The
> post processing code is slow because the current design requires every
> compile to read a complete list of all the files, giving O(n^2)
> effects.  Mark 2 of the core code will use a shared database with
> concurrent update so post processing is limited to looking up just the
> required files, instead of reading the complete list every time.

Ah, OK, I get it.  Hey, would it help to have a dbm interface compat 
library which uses mmap instead of building the db in brk() space?
We've got a small, fast one that you can have under any license you
like, GPL, LGPL, whatever.  We use it all over the BK code.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
