Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143627AbRA1RLy>; Sun, 28 Jan 2001 12:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143626AbRA1RLo>; Sun, 28 Jan 2001 12:11:44 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:5552 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S143568AbRA1RLc>; Sun, 28 Jan 2001 12:11:32 -0500
Date: Sun, 28 Jan 2001 17:11:20 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: jamal <hadi@cyberus.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.GSO.4.30.0101281039440.24762-100000@shell.cyberus.ca>
Message-ID: <Pine.SOL.4.21.0101281704430.16734-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, jamal wrote:
> On Sun, 28 Jan 2001, James Sutherland wrote:
> > On Sun, 28 Jan 2001, jamal wrote:
> > > There were people who made the suggestion that TCP should retry after a
> > > RST because it "might be an anti-ECN path"
> >
> > That depends what you mean by "retry"; I wanted the ability to attempt a
> > non-ECN connection. i.e. if I'm a mailserver, and try connecting to one of
> > Hotmail's MX hosts with ECN, I'll get RST every time. I would like to be
> > able to retry with ECN disabled for that connection.
> 
> We are allowing two rules to be broken, one is RFC 793 which
> clearly and unambigously defines what a RST means. the second is

This is NOT being violated: the RST is honoured as normal.

> the firewall or IDS box which clearly is in violation.

Disagreed: it is complying with firewall RFCs, rejecting suspect
packets. Sending an RST isn't a very bright way to do it, but that's
irrelevant: it happens. Deal with it.

> The simplest thing in this chaos is to fix the firewall because it is in
> violation to begin with.

It is not in violation, and you can't fix it: it's not yours.

> I think it is silly to try to be "robust against RSTs" because of ECN.
> What if the RST was genuine?

It is genuine, and is treated as such. There is no "robust against
RSTs" or anything else: just graceful handling of non-ECN routes.

> I see that we mostly have philosphical differences. You'd rather adapt
> to the criminal and most people would rather have the criminal adjust to
> society.

There is no "criminal": no rules are being broken. Since it is
"society" (or a tiny minority thereof) which has changed the rules, it is
"society" which must adapt to be compatible with existing rules.

> I think CISCO have been very good in responding fast. I blame the site
> owners who dont want to go beyond their 9-5 job and upgrade their boxes.
> In the old internet where only hackers were qualified for such jobs, the
> upgrade would have happened by now at hotmail. I suppose it's part of
> growing pains.

I'd have said that's still true - only "hackers" are qualified. The
problem is just that the staff doing (or attempting) the job aren't
necessarily qualified to do it properly...

> If you think the CISCOs were bad sending RSTs, i am sure you havent heard
> about the Raptor firewalls. They dont even bother to send you anything if
> you have ECN enabled ;-> Simply swallow your SYNs.

That's regarded as a better response, actually: just drop suspect packets.

> So tell me, what do you propose we deal with these? Do we further
> disambiguate or assume the packet was lost?
> I actually bothered calling Raptor, they chose to ignore me.

You mean they are still shipping a firewall which drops ECN
packets? Hrm...

> You should never ASSume anything about something that is "reserved".
> I posted the definition from the collegiate dictionary, but i am sure most
> dictionaries would give the same definition.

It isn't just reserved, though, it's stated "must be zero". Very poor
wording, but it's too late now.

> It's too bad we end up defining protocols using English. We should use
> mathematical equations to remove any ambiguity ;->

No, just use English properly. "Must be zero" doesn't actually mean "must
be set to zero when sending, and ignored when receiving/processing", which
is probably what the standard SHOULD have said.

However, it's too late now: ECN-disabled routes exist. ECN implementations
should degrade as well as possible when handling these circumstances.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
