Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132898AbRECQRe>; Thu, 3 May 2001 12:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132922AbRECQRY>; Thu, 3 May 2001 12:17:24 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:51464 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132898AbRECQRE>;
	Thu, 3 May 2001 12:17:04 -0400
Date: Thu, 3 May 2001 12:16:57 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Urban Widmark <urban@teststation.com>, John Stoffel <stoffel@casc.com>,
        cate@dplanet.ch, Peter Samuelson <peter@cadcamlab.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Hierarchy doesn't solve the problem
Message-ID: <20010503121657.K31960@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Juan Quintela <quintela@mandrakesoft.com>,
	Urban Widmark <urban@teststation.com>,
	John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
	Peter Samuelson <peter@cadcamlab.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503030431.A25141@thyrsus.com> <Pine.LNX.4.30.0105030907470.28400-100000@cola.teststation.com> <20010503034620.A27880@thyrsus.com> <m2bspa7b9e.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m2bspa7b9e.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Thu, May 03, 2001 at 04:33:33PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan Quintela <quintela@mandrakesoft.com>:
> linux 2.4.(x+1) has more drivers/options/whatever that linux-2.4.x.  I
> want to be prompted only for the new drivers/options/whatever it
> chooses the old ones from the .config file.  Note that my old .config
> file is not a valid configuration because it misses symbols (or I am
> wrong and this is a valid configuration ?).

Yes, you're wrong.  This is a valid configuration.  If any of the
missing values have to be non-N, CML2 will deduce this and tell 
you what it's changing them to and why.

In CML2's world "symbol not set" is different from "symbol set to n".
When a symbol is not set, the deducer can force it to value that 
satisfies constraints.

Your second scenario is addressed by the samne correction.

>                                Otherwise I will be happy if
> you provide me something like:
> 
>     make "CONFIG_SCSI=n" oldconfig
> 
> or similar, i.e. _I_ know what I want to change, and I want to change
> only that.  Notice that I want also be able to do the other way
> around:
> 
>     make "CONFIG_SCSI=m" oldconfig
> 
> and then be prompted for all the SCSI drivers (because they was not in
> the .config before).

There is such an option.  It's -d, which sets a symbol from the
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Love your country, but never trust its government.
	-- Robert A. Heinlein.
