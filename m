Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUCVEPl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 23:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUCVEPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 23:15:41 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43154
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261680AbUCVEPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 23:15:38 -0500
Date: Mon, 22 Mar 2004 05:16:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa1
Message-ID: <20040322041629.GK3649@dualathlon.random>
References: <20040321234355.GB3649@dualathlon.random> <Pine.LNX.4.44.0403212239170.20045-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403212239170.20045-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 10:43:41PM -0500, Rik van Riel wrote:
> Presuming you'll never debug your code ;)

typedefs are more readable to my eyes, so if they're there it's more
debuggable, infact I liked when Ingo tried to inject the page_t thing
(was him Ingo or somebody else?)

> They're _LINUX_RMAP_H and not _LINUX_OBJRMAP_H.  If you want
> to be consistent you may want to either rename the inclusion
> guards, or the file ;)

I see what you mean now, I agree.

> Only if (1) you're using bitkeeper and (2) you used 'bk mv'
> to move rmap.c to objrmap.c and (3) Linus pulls from your
> bitkeeper tree.

I know this would be expected (this is what happens with arch too in the
explicit mode, the one that I prefer to be strict in the commits), but I
was just trying to say that Miles theory is that BK gets it right
automatically, either that or Linus's scripts gets it right before
injecting it into bk, that is his whole point. Miles sent to Linus
_patches_ (obviously w/o bk, AFIK Miles is not legally allowed to use bk
and Larry even refused him to sell him a commercial licence of bk so
that Miles could use bk while still working on arch) renaming files, and
he then found the renames being catched correctly in the web.

> Unless all 3 of these are true, you're giving bitkeeper more
> credit than it deserves ;)

It may not be bk catching the renames but just an external script that
Linus uses. I don't know.

> > I renamed it primarly because rmap is the common name for the tecnique
> > of traking the pagetables with pte_chains
> 
> Funny, first thing I hear about that ;)

Not sure after all those discussions how you may not have ever noticed
that people uses objrmap to mean something different than rmap, it's
really hard to believe that you never noticed.
