Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136731AbREHB4U>; Mon, 7 May 2001 21:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136737AbREHB4K>; Mon, 7 May 2001 21:56:10 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:50443 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136731AbREHB4F>;
	Mon, 7 May 2001 21:56:05 -0400
Date: Mon, 7 May 2001 21:56:18 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010507215618.B21552@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <E14wO7g-000240-00@the-village.bc.nu> <20010507105950.A771@opus.bloom.county> <20010507213140.I16535@thyrsus.com> <20010507184315.A2378@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010507184315.A2378@opus.bloom.county>; from trini@kernel.crashing.org on Mon, May 07, 2001 at 06:43:15PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> Only sort-of.  There are some cases where you can get away with that.  
> Probably.  eg If you ask for PARPORT, on x86 that means yes to PARPORT_PC,
> always (right?)

Yes.  So the right answer there isn't to use a derivation but to say:

require X86 and PARPORT implies PARPORT_PC
unless X86==n suppress PARPORT_PC

which forces PARPORT_PC==y and makes the question invisible on X86 machines,
but leaves the question visible on all others.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The real point of audits is to instill fear, not to extract revenue;
the IRS aims at winning through intimidation and (thereby) getting
maximum voluntary compliance
	-- Paul Strassel, former IRS Headquarters Agent Wall St. Journal 1980
