Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132718AbRDNCK3>; Fri, 13 Apr 2001 22:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132725AbRDNCKT>; Fri, 13 Apr 2001 22:10:19 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:22788 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132718AbRDNCKK>;
	Fri, 13 Apr 2001 22:10:10 -0400
Date: Fri, 13 Apr 2001 22:11:02 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: esr@snark.thyrsus.com, jeff millar <jeff@wa1hco.mv.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.0.0 doesn't remember configuration changes
Message-ID: <20010413221102.C4651@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	esr@snark.thyrsus.com, jeff millar <jeff@wa1hco.mv.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010411191940.A9081@thyrsus.com> <E14nU6n-0007po-00@the-village.bc.nu> <20010411204523.C9081@thyrsus.com> <002701c0c2f1$fc672960$0201a8c0@home> <20010411225055.A11009@thyrsus.com> <003c01c0c312$73713300$0201a8c0@home> <20010411220646.A12550@thyrsus.com> <20010412232021.A682@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010412232021.A682@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Thu, Apr 12, 2001 at 11:20:21PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>:
> On Wed, Apr 11, 2001 at 10:06:46PM -0400, esr@thyrsus.com wrote:
> > Editconfig was a mistake.  OK, I think I understand the rules now.  Is it:
> > 
> > (1) First, try to read from .config
> > (2) If .config doesn't exist, read from $(ARCH)/defconfig
> 
> Right. But with the following constraints:
> 
>    make oldconfig takes _any_ .config from _any_ kernel and builds a
>    new one for _this_ kernel asking any remaining questions
>    
>    make xconfig, make menuconfig, make config take a .config from
>    _this_ kernel and configure for _this_ kernel
> 
>    if they don't find and .config, then they fall back to
>    $(ARCH)/defconfig
> 
> Would be nice, if CML2 works like this too, because it's not nice
> to go through all the options again, if I install a new kernel or
> just want to change my current kernel config add a module.

OK, 1.1.0 will do these things.  I'm still not certain I have `make
oldconfig' right, but I trust someone will club me gently over the
head if it's still not up to spec.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Are we to understand," asked the judge, "that you hold your own interests
above the interests of the public?"

"I hold that such a question can never arise except in a society of cannibals."
	-- Ayn Rand
