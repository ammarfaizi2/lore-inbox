Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbREHHQR>; Tue, 8 May 2001 03:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbREHHQH>; Tue, 8 May 2001 03:16:07 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:52748 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131246AbREHHQD>;
	Tue, 8 May 2001 03:16:03 -0400
Date: Tue, 8 May 2001 03:15:11 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Tom Rini <trini@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010508031511.A15782@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <E14wO7g-000240-00@the-village.bc.nu> <20010507105950.A771@opus.bloom.county> <20010507213140.I16535@thyrsus.com> <20010507184315.A2378@opus.bloom.county> <20010507215618.B21552@thyrsus.com> <20010508085941.B17720@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010508085941.B17720@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Tue, May 08, 2001 at 08:59:41AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk>:
> Which is unfortunately wrong if you want the parport subsystem on x86
> but won't be using the parport_pc driver with it.  I.e. you'll be using
> some other driver which isn't part of the kernel tree.  Perhaps a
> modified version of parport_pc, perhaps something else.

If you're integrating drivers that aren't in the kernel tree, you can and
should patch the CML2 rulebase to compensate.  So your patch for
the modified driver should comment out the PARPORT_PC==PARPORT 
requirement.  Problem solved.

More generally, arguments of the form "Non-mainline custom hack X
could invalidate constraint Y, therefore we can't have Y in the
rulebase" are dangerous -- I suspect you could reduce your set of
constraints to nil very quickly that way, and thus badly screw over
the 99% of people who just want to build a more or less stock kernel.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The abortion rights and gun control debates are twin aspects of a deeper
question --- does an individual ever have the right to make decisions
that are literally life-or-death?  And if not the individual, who does?
