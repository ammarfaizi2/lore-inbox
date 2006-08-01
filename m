Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWHAOfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWHAOfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWHAOfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:35:47 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:5026 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932490AbWHAOfq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:35:46 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 1 Aug 2006 17:33:52 +0300
From: Tony Lindgren <tony@atomide.com>
To: David Brownell <david-b@pacbell.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>,
       Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Message-ID: <20060801143351.GA5625@atomide.com>
References: <1154066134.13520.267064606@webmail.messagingengine.com> <200607310941.01340.david-b@pacbell.net> <20060731191001.GA10489@flint.arm.linux.org.uk> <200607311655.43524.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607311655.43524.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Brownell <david-b@pacbell.net> [060801 02:58]:
> On Monday 31 July 2006 12:10 pm, Russell King wrote:
> > On Mon, Jul 31, 2006 at 09:41:00AM -0700, David Brownell wrote:
> > > On Monday 31 July 2006 9:13 am, Jean Delvare wrote:
> > > > Hi David,
> > > > 
> > > > > And I **really** hope this gets merged into 2.6.18 since virtually
> > > > > no OMAP board is very usable without it.  I2C is one of the main
> > > > > missing pieces(*) ... can whoever's managing I2C merges please
> > > > > expedite this?
> > 
> > Slightly off-topic, and probably not your area, but it would probably
> > help your case if omap were better looked after in mainline. 
> 
> Actually that _is_ part of my case.  It can't be looked after in any
> reasonable way until the I2C driver gets merged, because significant
> chunks of the OMAP driver stack require I2C.  (And notably for me,
> USB always requires I2C to handle VBUS switches ...)
> 
> So for example once the OMAP I2C gets merged, then it'll finallly
> become practical for folk to try _using_ mainline kernels.  Which
> is a prerequisite for getting the bugs there fixed with any level
> of promptness, since they can't be fixed until they're noticed.

I agree, we want to use the mainline kernel for omap. Most of the core
omap code is already integrated, now we just need to get few more
omap device drivers integrated to have mainline kernel usable for
most omap boards.
 
> > Most OMAP 
> > platforms build fine, except for one long standing one - the H2 1610
> > defconfig, which hasn't built since 2.6.17-git11.
> 
> Yet oddly enough, that's the only OMAP defconfig present.  :( 
> 
> Once I2C gets merged, the OSK defconfig could be merged too; and
> that's a much handier board to work with and test.  H2 and OSK use
> basically the same OMAP chip (5912 ~= 1610b), but 5912 doesn't need
> NDAs; and the OSK board is is 10x smaller in size and price, plus
> it's available on the open market.

I agree. After the omap I2C driver has been integrated, we should
provide patches for few more omap defconfigs.
 
> > So, rather than shoveling new stuff in there, can the maintainence of
> > the stuff already merged please be improved.

Sorry, my fault, I've been on vacation for most of July.
 
> > Build results vs kernel version for H2 1610:
> > 
> > http://armlinux.simtec.co.uk/kautobuild/omap_h2_1610_defconfig.html
> 
> You'll observe that I recently posted four build fixes (tps65010,
> ohci-omap, omap-rng, smc91x) ... all of which would affect H2... the
> fifth build fix will go to your armlinux patch database soon, it
> addresses the fatal error in that build log.  I've already submitted
> patches for the three Kconfig complaints.  (By the way, those build
> logs could become more informative by using "make -k" ...)
> 
> Plus H2 is another of the OMAP platforms that can't be fully
> initialized without using I2C.  :)

Good to hear the patches mentioned above fix the compile problem :)

Tony
