Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318984AbSHMRuL>; Tue, 13 Aug 2002 13:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318988AbSHMRuL>; Tue, 13 Aug 2002 13:50:11 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.98]:28630 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S318984AbSHMRuI>; Tue, 13 Aug 2002 13:50:08 -0400
Message-Id: <200208131753.g7DHr9f392108@pimout5-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Tue, 13 Aug 2002 08:53:02 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Phillips <phillips@arcor.de>,
       Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
       <frankeh@watson.ibm.com>, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208130942130.7411-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208130942130.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 August 2002 12:51 pm, Linus Torvalds wrote:
> On Tue, 13 Aug 2002, Rob Landley wrote:
> > Last time I really looked into all this, Stallman was trying to do an
> > enormous new GPL 3.0, addressing application service providers.  That
> > seems to have fallen though (as has the ASP business model), but the
> > patent issue remains unresolved.
>
> At least one problem is exactly the politics played by the FSF, which
> means that a lot of people (not just me), do not trust such new versions
> of the GPL. Especially since the last time this happened, it all happened
> in dark back-rooms, and I got to hear about it not off any of the lists,
> but because I had an insider snitch on it.
>
> I lost all respect I had for the FSF due to its sneakiness.

Exactly why I was thinking a minimalist version (I.E. one more paragraph) was 
about the biggest change the community would be likely to accept.  I strongly 
suspeced GPL 3.0 was going nowhere long before it actually got bogged down...

And the politics being played by the FSF seem to be why they're NOT 
interested in a specific patch to fix a specific problem (lack of addressing 
patents).  If you want bug fixes, they want to log-roll huge new 
infrastructure changes and force you to swallow the whole upgrade.  That's 
been a problem on this list before. :)

> The kernel explicitly states that it is under the _one_ particular version
> of the "GPL v2" that is included with the kernel. Exactly because I do not
> want to have politics dragged into the picture by an external party (and
> I'm anal enough that I made sure that "version 2" cannot be misconstrued
> to include "version 2.1".

Sure.  But it's been re-licensed before.  Version 0.12, if I recall.  (And 
the statement of restriction to 2.0 could also be considered a re-licensing, 
albeit a minor one.)  How much leverage even YOU have to fiddle with the 
license at this point is an open question, but if a version 2.1 WAS 
acceptable (if, if, important word that, and obviously this would be after 
seeing it), and you decided to relax the 2.0 restriction to a 2.1 restriction 
(still operating under the "if" here, I can include semicolons if you 
like...), it probably wouldn't muddy the legal waters too much if the sucker 
later had to be upheld in court (<- nested if).

"Probably" meaning "ask a lawyer", of course...

> Also, a license is a two-way street. I do not think it is morally right to
> change an _existing_ license for any other reason than the fact that it
> has some technical legal problem. I intensely dislike the fact that many
> people seem to want to extend the current GPL as a way to take advantage
> of people who used the old GPL and agreed with _that_ - but not
> necessarily the new one.

The only reason I'd worry about trying to integrate it is to ensure that a 
"patent pool" adendum was compatible with the GPL itself.  It's not an 
additional restricition that would violate the GPL, it's a grant of license 
on an area not explicitly addressed by the GPL, and it's a grant of 
permissions giving you rights you wouldn't otherwise necessarily have.

The problem comes with the "if you sue, your rights terminate" clause.  On 
the one hand, the GPL is generally incompatable with additional termination 
clauses.  On the other hand, it's a termination clause only of the additional 
rights granted by the patent license, not of the rights granted by the GPL 
itself, which is a copyright license...

It's a bit of legal hacking that would definitely require vetting by a 
professional...

On the other hand, cross-licensing ALL your patents with a GPL patent pool 
would probably have to be a seperate statement from the license, that's a 
bigger decision than simply releasing GPL code that might use one or two 
patents, and it's best to have that decision explicitly made and explicitly 
stated.  (The GPL only applies to what you specifically release under it...)  
So making an external statement be compatable with the GPL is definitely a 
good thing anyway.

A case could be made that section 7 sort of implies an intent that enforcing 
patent restrictions violate the license and thus terminate your rights to 
distribute under section 4, and could be argued to mean that you can't put 
code under the GPL without at least implying a license to your own patents.  
But that doesn't solve the "third party who never contributed" problem.  
(That's what requires the patent license termination clause, thus making you 
vulnerable to suits for infringing other patents in the pool...)

I THINK it could be made to work as a seperate supplementary licensing 
statement, compatable with the GPL.  I know it could be made to work as an 
upgrade to the GPL, but you're right there's huge problems with that 
approach...

Either way, it's vaporware until acceptable language is stitched together and 
run by a competent IP attourney...

> As a result, every time this comes up, I ask for any potential new
> "patent-GPL" to be a _new_ license, and not try to feed off existing
> works. Please dopn't make it "GPL". Make it the GPPL for "General Public
> Patent License" or something. And let people buy into it on its own
> merits, not on some "the FSF decided unilaterally to make this decision
> for us".

GPL+, possibly...

In either case it would be a new license.  The people putting "or later" in 
their copyright notices trust the FSF and thus the FSF's new licenses (if 
any).  The people who specify a specific version don't.  The license seems to 
have been intentionally written to leave the option of making this 
distinction open.

> I don't like patents. But I absolutely _hate_ people who play politics
> with other peoples code. Be up-front, not sneaky after-the-fact.

Well, GPL section 9 did plant this particular land mine in 1991, so this is 
probably a case of being sneaky up front. :)  But it's still being sneaky...

That said, section 9 just states that the FSF will put out new versions and 
that code that says a version number "or later", or who don't specify any 
version, can automatically be used under the new version.  The ones that 
specify a specific version don't automatically get re-licensed in future by 
section 9, so the linux case is pretty clear.  (Well, disregarding the binary 
module thing, anyway. 8)

> 		Linus

Rob

P.S.  Yes everybody, RTFL:  http://www.gnu.org/copyleft/gpl.html
