Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbUAXXZp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbUAXXZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:25:45 -0500
Received: from smtp.everyone.net ([216.200.145.17]:47093 "EHLO
	rmta03.mta.everyone.net") by vger.kernel.org with ESMTP
	id S263290AbUAXXZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:25:42 -0500
Date: Sat, 24 Jan 2004 18:25:33 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Lang <david.lang@digitalinsight.com>,
       David Ford <david+hb@blue-labs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to public posts
Message-ID: <20040124232533.GA7294@arizona.localdomain>
References: <1074717499.18964.9.camel@localhost.localdomain> <20040121211550.GK9327@redhat.com> <20040121213027.GN23765@srv-lnx2600.matchmail.com> <pan.2004.01.21.23.40.00.181984@dungeon.inka.de> <1074731162.25704.10.camel@localhost.localdomain> <yq0hdyo15gt.fsf@wildopensource.com> <401000C1.9010901@blue-labs.org> <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com> <20040124201437.GA7133@arizona.localdomain> <Pine.LNX.4.58.0401241307490.10144@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401241307490.10144@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 01:12:34PM -0800, Linus Torvalds wrote:
> 
> On Sat, 24 Jan 2004, Kevin O'Connor wrote:
> > 
> > A good Bayesian spam filter isn't nearly as susceptible to random words as
> > some people think.  Words that are likely to be spam (along with words that
> > are frequently "ham") are given _exponentially_ more weight than other
> > words.
> 
> Especially if the "random words" in the spam end up being weighted by real
> frequency, you just _cannot_ use single-word bayes filters on it. Or if 
> you do, you'll eventually have those words either being neutral, or (worst 
> of all cases) you'll have real mail be marked as spam after having 
> aggressively trained the filter for the spams.

A "random" word will not occur frequently enough in spam messages (when
measured over a large sample of spam) to become a "spam" token or to
adversely effect it becoming a "ham" token.  (If it did, then it would be a
good indicator of "spam", and spammers wouldn't be using it in their
"random" word blocks.)  Also, the algorithms in the filter make sure that
words don't become spam tokens just because one receives more spam than ham
(ie. you can't train the filter to over aggressively catch spam).

Don't get me wrong - I agree that multi-word bayes filters can be more
precise.  But, I don't see them as being significantly different from
single word filters -- they're susceptible to the same "attack" you outline
above (with blocks of random sentences) -- and they will have larger
dictionaries and require more training time.

> It might not be that big of a deal especially if you have a fairly narrow 
> scope of emails in your ham-list, but people who get mail from varied 
> sources _will_ get screwed by this, one way or the other.

A lot of testing has been done on these filters (see for example
http://spambayes.sourceforge.net/background.html) with a very large email
corpus.  If you haven't looked at bayes filters recently, or have only been
looking at the simplistic ones, then I think you might have better luck
trying again.

-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------
