Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284996AbRLFFhm>; Thu, 6 Dec 2001 00:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284995AbRLFFhc>; Thu, 6 Dec 2001 00:37:32 -0500
Received: from [12.36.112.226] ([12.36.112.226]:65271 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S284996AbRLFFhS>;
	Thu, 6 Dec 2001 00:37:18 -0500
Date: Thu, 6 Dec 2001 00:31:08 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Configure.help 2.4.17 update patch
Message-ID: <20011206003108.A3552@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Steven Cole <elenstev@mesatop.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011203155438.A27630@thyrsus.com> <Pine.LNX.4.21.0112041203490.19552-100000@freak.distro.conectiva> <20011204184439.A1969@thyrsus.com> <200112060322.fB63MNb10689@thor.mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112060322.fB63MNb10689@thor.mesatop.com>; from elenstev@mesatop.com on Wed, Dec 05, 2001 at 08:16:53PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com>:
> I suggest that Marcelo go ahead and apply Eric's patch, with the two
> meaningless rejects, and let the resulting Configure.help be the new
> baseline for the 2.4.x series, and fork Configure.help for the 2.4.x
> and 2.5.x series, since we have different sets of patches coming in
> and it is just not practical (or reasonable) to try to fit the same
> Configure.help file to both the stable and development series.

I specifically do *not* want to fork Configure.help.  

Reason: it's going to go away anyway when CML2 drops in, which (unless
Linus has changed his mind) is scheduled for sometime in 2.5.1-xxx. At
that point it will be functionally replaced by the contents of the
master symbols.cml file, which will have been mechanically derived
from it.

(The reason for this change is to unify the help information with the
symbol-prompt and other message strings.  In the new architecture, it
will be possible to localize the entire kernel config system by dropping in a
localized symbols.cml.)

Because the 2.5.1 side of the Configure.help fork would have a short
lifetime anyway, I'd really prefer not to have to maintain two
separate helpfiles before CML2 comes in.  There are 110 missing
entries that could be filled in before then that go in both trees and
I really, *really* don't want to have to track them in two different
versions.

Afterwards, of course, the 2.4.x file will be strictly Marcelo's baby
and I'll maintain symbols.cml (actually Steven Cole will probably take
over).

I handled a closely analogous problem between the Linus and ac trees by
making Configure.help contain the union of the two sets of entries, some 
marked "Alan's tree" and some marked "Linus's tree".  What I'd prefer to
do in this case is mark NETLINK and RT_NETLINK "Linus's tree only" and
let Marcelo edit them out of the 2.4.x Configure.help file if he wants after
the CML2 conversion.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

When all government ...in little as in great things... shall be drawn to
Washington as the center of all power; it will render powerless the checks
provided of one government on another, and will become as venal and oppressive
as the government from which we separated."	-- Thomas Jefferson, 1821
