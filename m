Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267679AbTBUVOn>; Fri, 21 Feb 2003 16:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267710AbTBUVOn>; Fri, 21 Feb 2003 16:14:43 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10760 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S267679AbTBUVOl>; Fri, 21 Feb 2003 16:14:41 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302212125.h1LLPgxE001759@81-2-122-30.bradfords.org.uk>
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
To: warp@mercury.d2dc.net (Zephaniah E\. Hull)
Date: Fri, 21 Feb 2003 21:25:42 +0000 (GMT)
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20030221205333.GA1684@babylon.d2dc.net> from "Zephaniah E\. Hull" at Feb 21, 2003 03:53:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> --W/nzBZO5zC0uMSeA
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> </lurk>
> 
> On Fri, Feb 21, 2003 at 08:40:45PM +0000, John Bradford wrote:
> > > RFC3168 section 6.1.1.1 says this:
> > >=20
> > >    A host that receives no reply to an ECN-setup SYN within the normal
> > >    SYN retransmission timeout interval MAY resend the SYN and any
> > >    subsequent SYN retransmissions with CWR and ECE cleared.  To overcome
> > >    normal packet loss that results in the original SYN being lost, the
> > >    originating host may retransmit one or more ECN-setup SYN packets
> > >    before giving up and retransmitting the SYN with the CWR and ECE bits
> > >    cleared.
> > >=20
> > > Supporting this would make using ECN a lot less painful - currently, if
> > > I want to use ECN by default, I get to turn it off anytime I find an
> > > ECN-hostile site that I'd like to communicate with.
> >=20
> > Linux shouldn't encourage the use of equipment that violates RFCs, in
> > this case, RFC 739.
> 
> Linux shouldn't encourage the use of equipment that attempts to emulate
> <insert thing here> but screws it up.
> >=20
> > The correct way to deal with it, is to contact the maintainers of the
> > site, and ask them to fix the non conforming equipment.
> 
> The correct way to deal with it, is to contact the manufactures of the
> equipment.
> >=20
> > If the problem is caused upstream, by equipment out of the
> > site's maintainers' control, it is their responsibility to contact the
> > relevant maintainers, or change their upstream provider.
> 
> If the hardware is provided by people upstream, and is out of the
> control of the sysadmin's control, it is their responsibility to contact
> the relevant people, or change hardware providers.
> 
> Oh, look, does that mean that we can now remove all the work arounds in
> the various network, ide, etc drivers?

No, I'm suggesting that at all.

> No, I believe Linus has stated many times that Linux is not a research
> project, it is meant to actually be USED.

As far as I can see, though, implementing this gains less than we
stand to loose.

What if the first SYN packet, or the response to it is lost, (which is
more possible on congested links, which is when ECN would be most
useful), and we disable ECN - then we loose out on functionality we
could have, and the work around is actually detremental to
performance.  Once 99% of internet hosts support ECN, we could be
loosing more than we gain.

If a site is unreachable, ECN can be disabled, and the RFC violating
equipment is easily identified.  Automatically disabling ECN just
hides the problem from the user, who might then not be benefiting from
ECN, and will quite possibly accept the degraded performance as
normal.

John.
