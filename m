Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVANSfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVANSfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVANSf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:35:29 -0500
Received: from thunk.org ([69.25.196.29]:34970 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261279AbVANSfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:35:11 -0500
Date: Fri, 14 Jan 2005 13:34:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050114183415.GA17481@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
	Marek Habersack <grendel@caudium.net>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113200308.GC3555@redhat.com> <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org> <1105644461.4644.102.camel@localhost.localdomain> <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 01:03:22PM -0800, Linus Torvalds wrote:
> 
>  - _short_ embargo, for kernel-only. I obviously believe that vendor-sec 
>    is whoring itself for security firms and vendors. I believe there would 
>    be a place for something with stricter rules on disclosure.
> 
>  - vendor-sec. The place where you can play any kind of games you want.
> 

Linus, 

	I think you're being a bit unfair here.  I've been on
vendor-sec since almost its very beginnings, and it's not nearly as
politically driven as you seem to make it out to be.

	Now, that may be because I've seen the early days of CERT,
where I saw an lpr/lpd hole get covered up for some 9 months before I
gave up tracking to see when they would ever bother to issue a CERT
advisory.  *That's* whoring itself to vendors, where CERT would delay
advisories to keep pace with the slowest vendor, because CERT was a
heavy-weight organization that was beholden to vendors in order to
meet its payroll.  Vendor-sec, because it's a mailing list that is
quite frankly, extremely informally organized, especially compared
many of the other security fora that exist out there, doesn't have
many of the shortcomings of CERT, thanks be to $DEITY.

	That being said, part of the problem here is that everybody
has different standards for when they would like to be informed.  Some
people *like* wearing a pager and even if a security vulnerability is
found at 4am on the Tuesday before Thanksgiving, to rush out, download
a kernel.org kernel, and install it on 500 production critical
machines all over their corporate network within the next eight hours.
Other people would prefer that public releases be delayed until after
public holidays --- so they can get back from visiting their family in
Vermont, where cell phones and pagers don't work so well.

	Similarly people who find and disclose security holes do so
for a very large variety of reasons.  Some of them do it for the
glory; some of them do it because they are trying to drive business to
their security firms; and some of them, believe it or not, do it
because they are trying to make the world a better place.  (You know,
like some open source developers.  :-) 

	The people who find and report security holes have a very wide
range of opinions about full versus partial disclosure.  Some of them
take very seriously the possibility of what might happen if they were
to perform full disclosure on some vulnerability, and if an attacker
were to be able to use it to rewire the gates to the Grand Coulee Dam,
and cause huge loss of life, they would consider themselves as least
partially morally culpable.  Other people might say that the upside of
getting the news out faster outweighs any delay at all, even there are
some security breeches that cause loss of life or property.  I don't
hold with that position, but it is an intellectually defensible one.

	As a result, it is a highly religious, extremely charged
emotional issue, and the arguments on *both* sides of the fence tend
to go over the top; I've seen high levels of rhetorical arguing for
both full and delayed disclosure.  I also don't think we're going to
settle this issue any time soon.  We will probably come to some grand
consensus on the emacs versus vi issue first.


	It's probably not going to be helpful to say that vendor-sec
is "whoring itself" because some people who report vulnerabilities say
that they will only report them under certain conditions.  Maybe you
would prefer it if some group of vendors would say "no thank you" if
someone were to attach those conditions to a security report.  That's
a choice you've made, and that's fine.  

	But please reflect that the glory-hounds would in fact get
more attention if they were to announce their findings right away,
along with the exploit that does something public and visible, such as
taking down kernel.org ---- and that sometimes the security
researchers who insist on delayed disclosure are doing so out of the
best of intentions, and will only work with organizations that repsect
their requests.  You may not agree with them, but name calling is not
going to help matters.


	I think this is much like your position about licensing.
People can choose whatever license they want on their code.  But if
they choose a particular license, then you better damn well respect
it.  Similarly, if someone tells you that they will only tell you
about a security vulnerability if you agree not to release it until 1
week later, then you are honor bound either to (a) respect their
request of confidentiality, or (b) refuse to accept the information.
Either is an honorable choice.

	However, there have been some on this thread (not you) that
have claimed that vendor-sec should ignore the requests for delayed
disclosure and make public information where the reporter has said,
"I'll only give you this information if you promise to use it in the
following restricted way".  That's just dealing in bad faith, and I
reject that.  People of good will can, and have, and will no doubt
continue, to disagree about whether some level of delayed disclosure
is a good thing.

	I believe that delays of less than 7-10 days are a good thing,
and that scheduling public releases to avoid making a security problem
public at 5pm on Christmas eve, is a good thing.  I would not agree
with six month delays, and I think I've heard you say that a few days
to perhaps a week on the outside you might think would be acceptable.
The point is that there is a huge middle ground here, and in fact I
think most people participating on this thread are somewhere within
this vast middle ground --- I haven't heard anyone saying that the
(historical) CERT-style "delay for six months" is a good thing.

							- Ted

P.S.  As other people have noted, if the reporter says that they plan
to do immediate full/public disclosure, vendor-sec will work with
people who feel that way, and immediately get word out.  Vendor-sec
does *not* only work with delayed disclosure issues, and does not
insist that people hold back on reports, contrary to what some people
have claimed.  It has and always will be up to the person who
discovered the vulnerability to decide how to release it.  


