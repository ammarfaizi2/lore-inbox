Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131906AbRA1Na3>; Sun, 28 Jan 2001 08:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132362AbRA1NaT>; Sun, 28 Jan 2001 08:30:19 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:63228 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131906AbRA1NaF>; Sun, 28 Jan 2001 08:30:05 -0500
Date: Sun, 28 Jan 2001 13:29:52 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: jamal <hadi@cyberus.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.GSO.4.30.0101280700580.24762-100000@shell.cyberus.ca>
Message-ID: <Pine.SOL.4.21.0101281324210.26837-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, jamal wrote:
> On Sun, 28 Jan 2001, James Sutherland wrote:
> 
> > I'm sure we all know what the IETF is, and where ECN came from. I haven't
> > seen anyone suggesting ignoring RST, either: DM just imagined that,
> > AFAICS.
> 
> The email was not necessarily intended for you. You just pulled the pin.
> There were people who made the suggestion that TCP should retry after a
> RST because it "might be an anti-ECN path"

That depends what you mean by "retry"; I wanted the ability to attempt a
non-ECN connection. i.e. if I'm a mailserver, and try connecting to one of
Hotmail's MX hosts with ECN, I'll get RST every time. I would like to be
able to retry with ECN disabled for that connection.

> > The one point I would like to make, though, is that firewalls are NOT
> > "brain-damaged" for blocking ECN: according to the RFCs governing
> > firewalls, and the logic behind their design, blocking packets in an
> > unknown format (i.e. with reserved bits set) is perfectly legitimate.
> 
> I dont agree that unknown format == reserved. I think it is bad design to
> assume that. You may be forgiven if you provide the operator
> opportunities to reset your assumptions via a config option.
> It has nothing to do with a paranoia setting, just a bad design. Nothing
> legit about that.

On the contrary: rejecting weird-looking traffic is perfectly legit. I
agree RST is the wrong response, but it's too late to tell Cisco that
now...

> > Yes,
> > those firewalls should be updated to allow ECN-enabled packets
> > through. However, to break connectivity to such sites deliberately just
> > because they are not supporting an *experimental* extension to the current
> > protocols is rather silly.
> 
> This is the way it's done with all protocols. or i should say the way it
> used to be done. How do you expect ECN to be deployed otherwise?

The current versions of these firewalls handle ECN OK. I just want Linux
to degrade gracefully when unable to use ECN: it will be a while before
all these firewalls have gone.

> The internet is a form of organized chaos, sometimes you gotta make
> these type of decisions to get things done. Imagine the joy _most_
> people would get flogging all firewall admins who block all ICMP.

Blocking out ICMP doesn't bother me particularly. I know they should be
selective, but it doesn't break anything essential.

> There is nothing silly with the decision, davem is simply a modern day
> internet hero.

No. If it were something essential, perhaps, but it's just a minor
performance tweak to cut packet loss over congested links. It's not
IPv6. It's not PMTU. It's not even very useful right now!


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
