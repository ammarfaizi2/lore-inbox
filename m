Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbUCTTQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUCTTQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:16:09 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:57873 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S263512AbUCTTPn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:15:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH - InfiniBand Access Layer (IBAL)
Date: Sat, 20 Mar 2004 14:15:42 -0500
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB01EE9ADC@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH - InfiniBand Access Layer (IBAL)
Thread-Index: AcQOpJecM8+IuaJhTzCMd19S9rW3OAABI9Kw
From: "Acker, Dave" <dacker@infiniconsys.com>
To: "Ulrich Drepper" <drepper@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ulrich Drepper [mailto:drepper@redhat.com]
> Sent: Saturday, March 20, 2004 12:56 PM
> To: Acker, Dave
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
> 
> Acker, Dave wrote:
> > I can say that these other APIs are
> > already being used by other programs (or other APIs themselves) and
> > really can't go away.  If folks ask for ICSC support, it will
probably
> > get in there.
> 
> Spoken in true "proprietary-software, don't get the concept of free
> software"-fashion.
> 
> Just consider the implications if this would be accepted as an
argument.
>  Everybody who is producing a new API has to create just a couple of
> programs using it before publishing the specs to be able to say: well,
> here's the API.  Use it.  Oh, and don't change it, that's not
acceptable
> because we have code relying on the API.  Yep, strong-arming people
you
> have no control over works out fine, all the time.
> 
> The only acceptable order in which things can happen is:
> 
> 1. develop API
> 
> 2. propose API to be accepted by "community"/distributions
> 
> 3. change API if necessary, and go back to 2.
> 
> 4. write applications using new API
> 
> 

I don't mean that these other APIs MUST be accepted...just that people
are using them and will want to keep using them because they work for
them.  Even if there is one true standard linux interconnect API, I
suspect this APIs may hang around outside of standard linux.  Changing
an API is a lot easier than changing all the software that uses it.
 
I mention these other APIS because people have an interest in them
already and having interest in an API is a good thing.  People who are
actually going to use the API bring useful comments to the table.
Developing an API that no one wants to use isn't a very good way to
spend your time in my opinion.
The process you define is great if a company can wait for the process to
shake out a final API.  Often companies can not wait and have to move
forward.  The IB companies did just that.  This isn't to say we are not
open to moving from a proprietary API we made out of need to a community
accepted one.  That is what OpenIB.org is all about.  If we didn't care
we would not have bothered with this.  We are not trying to "strong-arm"
anyone into anything.  We want an open standard and are willing to
follow this process.  All of the companies involved have agreed to
support the results of this process. 


> > If folks ask for ICSC support, it will probably
> > get in there.
> 
> You did not in the least address the main point: IB is just one fiber.
> I cannot imagine anybody but the IB people want to have a specific API
+
> kernel extensions for each separate interconnect fiber.
> 
> Get it all over with in one stroke.  Come up with an API which covers
it
> all.  The requirements aren't that different.  And I singled out ICSC
> because it attempts to do just this.
> 

We are not looking for a specific API + kernel extensions for each
interconnect fiber.  We work in the area of IB and want to solve its
issues but I don't think that we are against a standard that solves all
interconnect issues.  I don't believe that we are against an API that
covers it all.  We (most IB companies) have supported DAPL and MPI.
Both are standards that try to work for all interconnects, not just IB.
If the community sees these as the wrong way to go and ICSC (or
something else) as the correct way then we (the IB community) will work
to support it.

> And don't say "we did our part, if the Linux community wants to have
> something else it's their to come up with a unified solution".  That
> would be acceptable only if it wouldn't be the IB people who want
their
> code to be generally accepted.  If you don't care about the later,
fine,
> leave it all as is.  But the code might not be picked up at all.
> 

Again, we are totally open to a unified solution...I don't believe we
have ever said we were not.  We started with looking for an InfiniBand
solution because that is what we know about and deal with everyday.

> Furthermore, don't count on much community participation.  There
aren't
> many people out there with the necessary hardware.  Or even the
ability
> to collect experiences.  The price for the changes have to be carried
by
> the parties with the agenda.
> 

Sure.  We expect to be making the changes ourselves often.

> 
> > If there is
> > going to be a standard linux infiniband stack it will have to be
very
> > good or else splinter versions and incompatible versions will live
on.
> 
> And by very good you mean of course your implementation.  From the
> comment above it is clear that if the standardized stack does not
> include your code you intent to keep using your code anyway.
Designing
> standards is always about compromises.
> 

Not at all.  In fact, the stack my company uses is not the base stack
openib.org has starting with, yet InfiniCon is still involved.
Compromises have already been made and more will be made in the future.
By "very good", I just mean that we want lots of review on the code.  We
want to hear what the community has to say.

> The organizations with interconnect interest have to come together to
> create just this, a compromise which in the end might not fulfill you
> "very good" criteria in all places.
> 

Sure.  It is totally possible that the final version lacks things that
some IB folks see as "very good" or needed.  This is where IB companies
can still offer and support additional pieces of open software that
suite their customer's needs.  For example, it is doubtful that MPI will
end up being the interconnect standard accepted by the linux community.
It is likely that its users will not be willing to change to another
interconnect API, even a standard one.  The rewrite cost would be too
high for many of them.  In these cases companies that sell interconnects
used for MPI applications will have to continue to support MPI.
Meanwhile others are free to use the standard out of the box and get
standard kernel support for it.

I am pretty sure RedHat and other Linux distributors have done similar
things for similar reasons.

-Ack

p.s. Again, these are my opinions, not the official opinions of
InfiniCon. 
