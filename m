Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136728AbREHBb7>; Mon, 7 May 2001 21:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136730AbREHBbs>; Mon, 7 May 2001 21:31:48 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:34827 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136728AbREHBbi>;
	Mon, 7 May 2001 21:31:38 -0400
Date: Mon, 7 May 2001 21:31:40 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010507213140.I16535@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <E14wO7g-000240-00@the-village.bc.nu> <20010507105950.A771@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010507105950.A771@opus.bloom.county>; from trini@kernel.crashing.org on Mon, May 07, 2001 at 10:59:50AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> On Sun, May 06, 2001 at 01:58:49PM +0100, Alan Cox wrote:
> > > # These were separate questions in CML1
> > > derive MAC_SCC from MAC & SERIAL
> > > derive MAC_SCSI from MAC & SCSI
> > > derive SUN3_SCSI from (SUN3 | SUN3X) & SCSI
> > 
> > Not all Mac's use the SCC if they have serial
> > Not all Mac's use the same SCSI controller
> 
> Yes, but in this case 'MAC' means m68k mac, which this _might_ be valid, but
> I never did get Linux up and running on the m68ks I had..

Exactly.  In fact we can be more specific -- the "Macintoshes" in
question are the old-fashioned NuBus-based 68k toaster boxes, not the
more recent designs with a PCI bus.  Relevant stuff in the
Configure.help implies that MAC_SCC and MAC_SCSI enable support for
the on-board hardware built into those puppies.
 
> But Alan's point is a good one.  There are _lots_ of cases you can't get away
> with things like this, unless you get very fine grained.  In fact, it would
> be much eaiser to do this seperately from the kernel.  Ie another, 
> possibly/probably _not_ inkernel config tool which asks what machine you
> have, picks lots of sane defaults and setups a kernel config for you.  This
> is _sort of_ what PPC does right now with the large number of 'default 
> configs' (arch/ppc/configs).

You're really talking about a different issue here,  autoconfiguration
rather than static dependencies.  Giacomo Catenazzi is working on that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Let us hope our weapons are never needed --but do not forget what 
the common people knew when they demanded the Bill of Rights: An 
armed citizenry is the first defense, the best defense, and the 
final defense against tyranny.
   If guns are outlawed, only the government will have guns. Only 
the police, the secret police, the military, the hired servants of 
our rulers.  Only the government -- and a few outlaws.  I intend to 
be among the outlaws.
        -- Edward Abbey, "Abbey's Road", 1979
