Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265800AbTAFC6F>; Sun, 5 Jan 2003 21:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbTAFC6F>; Sun, 5 Jan 2003 21:58:05 -0500
Received: from waste.org ([209.173.204.2]:19372 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S265800AbTAFC6E>;
	Sun, 5 Jan 2003 21:58:04 -0500
Date: Sun, 5 Jan 2003 21:06:22 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Andre Hedrick <andre@pyxtechnologies.com>,
       Rik van Riel <riel@conectiva.com.br>, Richard Stallman <rms@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030106030622.GC28100@waste.org>
References: <Pine.LNX.4.10.10301041740090.421-100000@master.linux-ide.org> <3E179CCF.F4CAE1E5@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E179CCF.F4CAE1E5@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 06:47:43PM -0800, Andrew Morton wrote:
> Andre Hedrick wrote:
> > 
> > Rik and Richard,
> > 
> > As you see, I in good faith prior to this holy war, had initiated a formal
> > request include a new protocol into the Linux kernel prior to the freeze.
> > The extention was requested to insure the product was of the highest
> > quality and not limited with excessive erratium as the ratification of the
> > IETF modified, postponed, and delayed ; regardless of reason.
> > 
> > Obviously, PyX had (has) on its schedule to product a high quality target
> > which is transport independent on each side of the protocol.  We are not
> > sure of this position because of the uncertain nature of the basic usages
> > of headers and export_symbols.
> > 
> 
> I suggest that if a function happens to be implemented as an inline
> in a header then it should be treated (for licensing purposes) as
> an exported-to-all-modules symbol.  So in Linux, that would be LGPL-ish.
> 
> The fact that a piece of kernel functionality happens to be inlined
> is a pure technical detail of linkage.
> 
> If there really is inlined functionality which we do not wish made
> available to non-GPL modules then it should be either uninlined and
> not exported or it should be wrapped in #ifdef GPL.

More pragmatically, who cares? There's already at least one vendor
(Cisco) who ships a perfectly good fully GPLed iSCSI initiator module
that doesn't need to touch any core code. It's already the benchmark
for compatibility at interoperability tests. And it's following the
IETF drafts closely too. Once we actually have an iSCSI RFC, it might
be worth pulling it into the kernel tree. I believe Red Hat is
shipping it some form already.

That leaves the question of using Linux as an iSCSI target, and I've
yet to see any reason why this couldn't be done in userspace. In fact,
in a lot of ways that's the right thing to do as it lets you take
proper advantage of MD/LVM/EVMS/crypto, etc..

There are a few other free implementations out there too.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
