Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRDSSGa>; Thu, 19 Apr 2001 14:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDSSGU>; Thu, 19 Apr 2001 14:06:20 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:46858 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131666AbRDSSGM>;
	Thu, 19 Apr 2001 14:06:12 -0400
Date: Thu, 19 Apr 2001 14:06:50 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Dead symbol elimination, stage 1
Message-ID: <20010419140650.C3841@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010419131944.A3049@thyrsus.com> <16626.987702505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16626.987702505@redhat.com>; from dwmw2@infradead.org on Thu, Apr 19, 2001 at 06:48:25PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> 
> > -# CONFIG_MTD_SBC_MEDIAGX is not set
> > -# CONFIG_MTD_ELAN_104NC is not set
> > -# CONFIG_MTD_SA1100 is not set
> > -# CONFIG_MTD_DC21285 is not set
> > -# CONFIG_MTD_CSTM_CFI_JEDEC is not set
> >  # CONFIG_MTD_JEDEC is not set
> >  # CONFIG_MTD_MIXMEM is not set
> >  # CONFIG_MTD_OCTAGON is not set
> >  # CONFIG_MTD_VMAX is not set
> > -# CONFIG_MTD_NAND is not set
> > -# CONFIG_MTD_NAND_SPIA is not set
> 
> Please don't. People using some of these embedded architectures need to
> update to the latest MTD code (which includes those options) anyway, and I'm
> hoping to merge that all into 2.4 shortly.

Well, then, those symbols will stop being dead.  But note this: *none of
those MTD symbols are set*.  So the effect of losing these would not be
to lose any CML1 information, merely to make a few more questions visible
during make oldconfig.  This is a feature, not a bug.
 
> They're not doing any harm, are they?

They are helping create a dense thicket in which real bugs can hide.

The cross-referencer has already turned up several genuine errors, 
and will doubtless turn up more -- but if the reports are stuffed
full of meaningless crap about undead defconfig symbols that aren't 
even set, the genuine errors are going to be hard to notice.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

In every country and in every age, the priest has been hostile to
liberty. He is always in alliance with the despot, abetting his abuses
in return for protection to his own.
	-- Thomas Jefferson, 1814
