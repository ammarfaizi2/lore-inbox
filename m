Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBHXsB>; Thu, 8 Feb 2001 18:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbRBHXru>; Thu, 8 Feb 2001 18:47:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5380 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129156AbRBHXrr>; Thu, 8 Feb 2001 18:47:47 -0500
Message-ID: <3A833005.5C8E0D81@transmeta.com>
Date: Thu, 08 Feb 2001 15:47:17 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net> <95v8am$k6o$1@cesium.transmeta.com> <20010208183232.A1642@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael H. Warfield" wrote:
> 
> On Thu, Feb 08, 2001 at 02:58:30PM -0800, H. Peter Anvin wrote:
> > Followup to:  <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net>
> > By author:    Gerhard Mack <gmack@innerfire.net>
> > In newsgroup: linux.dev.kernel
> > >
> > > Thanklfully bind 9 barfs if you even try this sort of thing.
> > >
> 
> > Personally I find it puzzling what's wrong with MX -> CNAME at all; it
> > seems like a useful setup without the pitfalls that either NS -> CNAME
> > or CNAME -> CNAME can cause (NS -> CNAME can trivially result in
> > irreducible situations; CNAME -> CNAME would require a link maximum
> > count which could result in obscure breakage.)
> 
>         It generally forces another DNS lookup.  If you do a resolve on
> a name of type=ANY it returns any MX records and A records.  If you then
> do a resolve on the MX records, you then get a CNAME and then have to
> add an additional lookup for the CNAME.  If you have a lot of MX records
> and not all the servers are "up" that can add up to a significant
> increase in DNS traffic.
> 

Wouldn't that be true for any CNAME anyway?

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
