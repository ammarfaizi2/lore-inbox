Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbUAXX7R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 18:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbUAXX7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 18:59:17 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.117]:17554 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S263441AbUAXX7N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 18:59:13 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to 
 public posts
References: <20040121194315.GE9327@redhat.com> <Pine.LNX.4.58.0401211155300.2123@home.osdl.org>
 <1074717499.18964.9.camel@localhost.localdomain>
 <20040121211550.GK9327@redhat.com>
 <20040121213027.GN23765@srv-lnx2600.matchmail.com>
 <pan.2004.01.21.23.40.00.181984@dungeon.inka.de>
 <1074731162.25704.10.camel@localhost.localdomain>
 <yq0hdyo15gt.fsf@wildopensource.com> <401000C1.9010901@blue-labs.org>
 <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com>
 <20040124201437.GA7133@arizona.localdomain>
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Sat, 24 Jan 2004 15:59:11 -0800
In-Reply-To: <1hDmg-4AP-9@gated-at.bofh.it> (Linus Torvalds's message of
 "Sat, 24 Jan 2004 22:20:09 +0100")
Message-ID: <87ad4c99v4.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Especially if the "random words" in the spam end up being weighted by
> real frequency, you just _cannot_ use single-word bayes filters on
> it. Or if you do, you'll eventually have those words either being
> neutral, or (worst of all cases) you'll have real mail be marked as spam
> after having aggressively trained the filter for the spams.

> It might not be that big of a deal especially if you have a fairly
> narrow scope of emails in your ham-list, but people who get mail from
> varied sources _will_ get screwed by this, one way or the other.

After having put a couple thousand messages a day through bogofilter for
around half a year now, this is, so far at least, not born out by my
experience.  Single word Bayesian filters are still working fine for me in
practice and legitimate e-mail is not being misclassified as spam because
of this sort of dictionary poisoning.  All the misclassifications I've
seen have been for very obvious reasons unrelated to Markov chains (I
generally have to explicitly train bogofilter a few times on invoices and
shipping notices from commerce sites, for example, since most
commerce-related words occur with a very high frequency in spam), and it
seems unlikely that they would be measurably helped by multiple-word
Bayesian algorithms.

Perhaps this will become a problem eventually (where eventually involves
more than one hundred thousand messages), but if so, I've not yet seen any
evidence of it.

Maybe I just have that narrow scope of e-mail that you refer to.  I'm not
sure how to measure that.  My gut instinct is that most people have a
pretty narrow scope of e-mail that they receive, relative to all the
possible legitimate e-mail messages (and I'm much more skeptical of
Bayesian filters when applied site-wide rather than to a single mailbox).

Using multiple words is probably better along some axes (faster training,
perhaps), but a sufficiently trained single-word filter doesn't appear to
have any real difficulties.  I'm inclined to believe that people who are
experiencing these sorts of problems with Bayesian filters are using
inferior implementations, haven't sufficiently trained their filters, or
have a radically different range of legitimate e-mail than I do.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
