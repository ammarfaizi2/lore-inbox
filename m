Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRBHXdI>; Thu, 8 Feb 2001 18:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRBHXc6>; Thu, 8 Feb 2001 18:32:58 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:26381 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S129101AbRBHXcp>; Thu, 8 Feb 2001 18:32:45 -0500
Date: Thu, 8 Feb 2001 18:32:32 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
Message-ID: <20010208183232.A1642@alcove.wittsend.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de> <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net> <95v8am$k6o$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <95v8am$k6o$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Feb 08, 2001 at 02:58:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 02:58:30PM -0800, H. Peter Anvin wrote:
> Followup to:  <Pine.LNX.4.10.10102081346001.16513-100000@innerfire.net>
> By author:    Gerhard Mack <gmack@innerfire.net>
> In newsgroup: linux.dev.kernel
> >
> > Thanklfully bind 9 barfs if you even try this sort of thing.
> > 

> Personally I find it puzzling what's wrong with MX -> CNAME at all; it
> seems like a useful setup without the pitfalls that either NS -> CNAME
> or CNAME -> CNAME can cause (NS -> CNAME can trivially result in
> irreducible situations; CNAME -> CNAME would require a link maximum
> count which could result in obscure breakage.)

	It generally forces another DNS lookup.  If you do a resolve on
a name of type=ANY it returns any MX records and A records.  If you then
do a resolve on the MX records, you then get a CNAME and then have to
add an additional lookup for the CNAME.  If you have a lot of MX records
and not all the servers are "up" that can add up to a significant
increase in DNS traffic.

> 	-hpa
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt

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
