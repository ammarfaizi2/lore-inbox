Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288758AbSADUwo>; Fri, 4 Jan 2002 15:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288759AbSADUwf>; Fri, 4 Jan 2002 15:52:35 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:146
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288758AbSADUwQ>; Fri, 4 Jan 2002 15:52:16 -0500
Date: Fri, 4 Jan 2002 15:36:46 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: David Weinehall <tao@acc.umu.se>, Vojtech Pavlik <vojtech@suse.cz>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104153646.D20097@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	David Weinehall <tao@acc.umu.se>, Vojtech Pavlik <vojtech@suse.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020104211931.D5235@khan.acc.umu.se> <Pine.GSO.3.96.1020104212646.829L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020104212646.829L-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jan 04, 2002 at 09:30:47PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki <macro@ds2.pg.gda.pl>:
> > If you find an MCA-bus, you can suppress most (but not all) ISA-cards
> > too (some of the cards support MCA without having any extra MCA-related
> > code in the drivers, such as the eexpress-driver, but I can help with
> > such a list if necessary.)
> 
>  Shouldn't the drivers depend on "CONFIG_ISA or CONFIG_MCA" then?  Just
> like CONFIG_DEFXX depends on "CONFIG_PCI or CONFIG_EISA"? 

Yes, that's almost the right solution (CONFIG_ISACARDS or CONFIG_MCA).  
I'll add

	require MCA != ISA_CARDS

to the rulebase.  Not that there are a lot of MCA machines out there but
every little bit helps.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

An armed society is a polite society.  Manners are good when one 
may have to back up his acts with his life.
        -- Robert A. Heinlein, "Beyond This Horizon", 1942
