Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291159AbSAaROy>; Thu, 31 Jan 2002 12:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291161AbSAaROr>; Thu, 31 Jan 2002 12:14:47 -0500
Received: from altus.drgw.net ([209.234.73.40]:14084 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291159AbSAaROg>;
	Thu, 31 Jan 2002 12:14:36 -0500
Date: Thu, 31 Jan 2002 11:13:37 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Rob Landley <landley@trommello.org>
Cc: Larry McVoy <lm@bitmover.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020131111337.Y14339@altus.drgw.net>
In-Reply-To: <20020130195154.R22323@work.bitmover.com> <20020131002355.X14339@altus.drgw.net> <20020130223711.L18381@work.bitmover.com> <20020131074924.QZMB10685.femail14.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131074924.QZMB10685.femail14.sdc1.sfba.home.com@there>; from landley@trommello.org on Thu, Jan 31, 2002 at 02:50:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 02:50:31AM -0500, Rob Landley wrote:
> On Thursday 31 January 2002 01:37 am, Larry McVoy wrote:
> 
> > That said, I'm sympathetic to the "I make lotso changes and I want to
> > collapse them into one big change" problem.  It's certainly technically
> > possible to make BK do that, but then you have to *know* that nobody
> > else has a BK repo with your old detailed changes in it, or if they
> > do, they won't ever try to push them back to you (or Linus or ...).
> 
> No, bitkeeper simply has to know. :)
> 
> Put in a node that says "this change collapses this range of other changes" 
> with a range or list of change IDs, and then when you do your next merge with 
> another tree, bitkeeper has the info it needs to avoid sucking in dupes.  If 
> the node says you have that change already, you don't need to suck it in from 
> the other tree.
> 
> > It's not an error if they do, it's just that BK will view them as
> > different changes and automerge them right back into the history.
> > So then you'll have both the collapsed version and the detailed version
> > which puts you worse off than when you started.
> 
> Just teach BK that the collapsed version includes everything in the detailed 
> version.  (Even if that's not technically true, teaching one system to lie to 
> another is an important part of programming... :)  Linus wanted checkpoint 
> functionality to limit backmerges, this seems sort of related-ish.  
> (Boundaries on change sets, merging change sets...)
> 
> Is there an implementation reason why this is particularly hard, or some evil 
> nasty side effects to such an approach that we should know about?


Can you detect the 'collapsed vs full version' thing, and force it to be 
a merge conflict? That, and working LOD support would probably get most 
of what I want (until I try the new version and find more stuff I want 
:P)

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
