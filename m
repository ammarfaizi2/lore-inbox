Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265569AbSKFCnb>; Tue, 5 Nov 2002 21:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSKFCnb>; Tue, 5 Nov 2002 21:43:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13241 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265569AbSKFCna>;
	Tue, 5 Nov 2002 21:43:30 -0500
Date: Tue, 5 Nov 2002 21:50:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Eff Norwood <enorwood@effrem.com>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
       evms-announce@lists.sourceforge.net
Subject: RE: [Evms-devel] EVMS announcement
In-Reply-To: <CFEAJJEGMGECBCJFLGDBIEEBCHAA.enorwood@effrem.com>
Message-ID: <Pine.GSO.4.21.0211052054160.6521-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Nov 2002, Eff Norwood wrote:

> > So, you're volunteering to maintain the EVMS subsystem for 2.5 ?
> >
> > If not, I propose you let Kevin and the other EVMS developers
> > make the decision.
> 
> So, having EVMS not included in the kernel was the decision they wanted to
> make?
> 
> If not, then I propose you be a little more reasonable and think about what
> this decision does to all the work thus far put into EVMS.

This decision (to move the bulk of EVMS code to userland and isolate the
changes needed in the kernel) *definitely* means less work in the long
run - for EVMS people in the first place.

Userland code is easier to write.  There one has full runtime environment
and that alone means a lot.  There one has no 8Kb limit on the stack size.
There one has memory protection.  And there code doesn't have to do anything
about the changes of kernel internals.  It's also easier to debug - for very
obvious reasons.

The goal is to provide functionality, not to put it in the kernel - the
latter always means harder life.  It is the last resort measure ("we have
no way to do that in userland with acceptable performance and correctness,
damn, time to deal with the kernel side") and finding a way to make do
with more compact kernel part (ideally - already maintained by somebody
else ;-) is always good news.

And I seriously doubt that work thus far put into EVMS goes down the drain
from move to userland - they would have to be absolutely incompetent for
that to be the case and I don't see what allows you to accuse them in that.

What that decision does mean is serious one-time effort that makes life
easier once it's done.  And that had taken real courage - my applause to
them (and not only mine, while we are at).  What they had done was pretty
amazing and my respect to the team that had chosen to do the right thing,
had been able to defend that decision and to their management that had allowed
that has just gone _way_ up.  Bravo, folks.  And best luck - seriously.

I respect very few people.  These I _do_ respect.  A lot.

