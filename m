Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbRBIAJD>; Thu, 8 Feb 2001 19:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRBIAIx>; Thu, 8 Feb 2001 19:08:53 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:25358 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129041AbRBIAIo>; Thu, 8 Feb 2001 19:08:44 -0500
Date: Thu, 8 Feb 2001 19:08:23 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: "Michael H. Warfield" <mhw@wittsend.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
Message-ID: <20010208190823.B1640@alcove.wittsend.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@transmeta.com>,
	"Michael H. Warfield" <mhw@wittsend.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net> <95v8am$k6o$1@cesium.transmeta.com> <20010208183232.A1642@alcove.wittsend.com> <3A833005.5C8E0D81@transmeta.com> <20010208185449.B1642@alcove.wittsend.com> <3A83335A.A5764CD7@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <3A83335A.A5764CD7@transmeta.com>; from hpa@transmeta.com on Thu, Feb 08, 2001 at 04:01:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 04:01:30PM -0800, H. Peter Anvin wrote:

> > > Wouldn't that be true for any CNAME anyway?

> >         That's the point...

> >         In other words, you do a lookup, you start with a primary lookup
> > and then possibly a second lookup to resolve an MX or CNAME.  It's only
> > the MX that points to a CNAME that results in yet another lookup.  An
> > MX pointing to a CNAME is almost (almost, but not quite) as bad as a
> > CNAME pointing to a CNAME.


> There is no reducibility problem for MX -> CNAME, unlike the CNAME ->
> CNAME case.

> Please explain how there is any different between an CNAME or MX pointing
> to an A record in a different SOA versus an MX pointing to a CNAME
> pointing to an A record where at least one pair is local (same SOA).

	Ah!  But now you are placing conditions on it (that at least one
pair is local).  That is the very fine distinction that makes up the
"not quite" in the "almost" above and the difference between the "should
not" vs the "must not" in the specifications.  You basically can't qualify
it by saying "you can do this, but only if one pair is in the same SOA".

> 	-hpa

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
