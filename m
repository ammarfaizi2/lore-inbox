Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130999AbQL2K4k>; Fri, 29 Dec 2000 05:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131031AbQL2K4b>; Fri, 29 Dec 2000 05:56:31 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:44295
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130999AbQL2K4P>; Fri, 29 Dec 2000 05:56:15 -0500
Date: Fri, 29 Dec 2000 23:25:43 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
Message-ID: <20001229232543.A17646@metastasis.f00f.org>
In-Reply-To: <20001228161126.A982@lingas.basement.bogus> <200012282159.NAA00929@pizda.ninka.net> <20001228212116.A968@lingas.basement.bogus> <92ha5l$1qh$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <92ha5l$1qh$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 28, 2000 at 10:15:17PM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 10:15:17PM -0800, Linus Torvalds wrote:

    I bet that others will have other recommendations, but so far I
    have at least personally had good luck with the eepro100.

I have (and still do) use 3c59x, 3c90x cards, eepro100 and tulips
cards. They all work reasonably well except they all have their own
quirks and none of them are as reliable as (say) the hme cards in our
Solaris machines.

Nor are they as reliable as the same hardware under FreeBSD, which is
somewhat embarrassing.

I have to wonder -- am I jinxed or do other people also find this?

I'm also slightly perturbed by the fact there is no easy way to set
media and duplex on all the cards. This was discussed on netdev not
long ago and I tried hacking ethtool support into the 3c59x code but
its far from a clean job. I'm not sure how simple this would be for
other drivers. Both Solaris and FreeBSD let you set media and duplex
in a uniform way; it's a pity Linux cannot.



  --cw

P.S. FWIW I'm currently trying to standardize on eepro100 cards; so
     far so good except nder sustained load (i.e. 100M full duplex
     completely saturated for many minutes) I get:

	eth1: card reports no resources.

     messages. Looking at the driver source code I can't see wy these
     might occur (I don't have the specs, I'm just going by the
     surrounding code). No harm, but what seems like a slight
     slowdown when this occurs.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
