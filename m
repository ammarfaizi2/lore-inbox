Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVANWZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVANWZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVANWZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:25:21 -0500
Received: from thunk.org ([69.25.196.29]:5276 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262206AbVANWOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:14:05 -0500
Date: Fri, 14 Jan 2005 17:13:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050114221343.GA18140@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
	Marek Habersack <grendel@caudium.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113200308.GC3555@redhat.com> <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org> <1105644461.4644.102.camel@localhost.localdomain> <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org> <20050114183415.GA17481@thunk.org> <Pine.LNX.4.58.0501141047470.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501141047470.2310@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 11:15:19AM -0800, Linus Torvalds wrote:
> 
> What vendor-sec does is to make it "socially acceptable" to be a parasite. 
> 
> I personally think that such behaviour simply should not be encouraged. If
> you have a security "researcher" that has some reason to delay his
> disclosure, you should see for for what he is: looking for cheap PR. 

I disagree.  First of all, we can't know what motivates someone, and
presuming that we know their motivation is something that should only
be done with the greatest of care.  Secondly, someone who does want
cheap PR can do so without delaying their disclosure; they can issue a
breathless press release or "security advisory" about a DOS attack
just easily with a zero-day disclosure as they can with a two-week
delayed disclosure.

Sure, there are less-than-savory security firms that are only after PR
to drive business.  But that's completely orthogonal to whether or not
the disclosure is delayed or not.  Yes, "glorification" of relatively
trivial bugs is a problem; but whether or not the bugs are delayed
doesn't change whether someone issues an "iOFFENSE SECURITY ADVISORY"
which overstates the bug; it only changes whether they send the
advisory right away or a week or two later.  (After all, the security
groups that subscribe to a zero-day "full disclosure" policy use
advisory/press releases glorifies their findings just as much.)

>  (a) accepting that bugs happen, and that they aren't news, but making 
>      sure that the very openness of the process means that people know
>      what's going on exactly because it is _open_, not because some news 
>      organization had to make a big stink about it just to make a vendor
>      take notice.

A one or two week delay is hardly cause for "a news organization to
make a big stick so vendors will take notice".  Besides, which is it?
Are it about security researchers that are after cheap PR, or "news
organizations forcing vendors to take notice"?  Certainly I've never
that kind of dynamic with Linux vendors where reporters are trying to
get vendors to take notice; it doesn't matter whether take notice if
they are going to be releasing in two weeks later come hell or high
water.

> And yes, for this to work people need to get away from the notion of 
> "let's apply vendor patch X to fix problem Y". What we should strive for 
> (and what the whole system should be _geared_ for) is to have redundant 
> enough security that people hopefully don't know of <n> outstanding bugs 
> at the same time that allows for a combination attack. 

Here, we certainly agree.

> And let's not kid ourselves: the security firms may have resources that 
> they put into it, but the worst-case schenario is actual criminal intent. 
> People who really have resources to study security problems, and who have 
> _no_ advantage of using vendor-sec at all. And in that case, vendor-sec is 
> _REALLY_ a huge mistake. 

Nah.  If you have criminal intent, generally there are far easier ways
to target a specific company.  For example, many companies that have
multiple layers of firewalls, intrusion detection systems, etc., will
keep critical financial information in boxes left unlocked in the
hallways, and not bother to do any kind of background checks before
hiring temporary employees/contractors.  Sad but true.

I'm quite certain that far more economic damage is being done by
script kiddies and by "insiders" using officially granted privileges
to access financial applications than by the hypothetical Dr. Evil
that hires computer experts to find vulnerabilities that could be used
to cary out criminal intent.  And it's the script kiddies that we can
prevent by delaying disclosures by only a week or two, to give a
chance to get the fixes out to the people who need them.

						- Ted
