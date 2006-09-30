Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWI3TjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWI3TjP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 15:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWI3TjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 15:39:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40970 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751785AbWI3TjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 15:39:14 -0400
Date: Sat, 30 Sep 2006 19:38:53 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: wireless abi breakage (was Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA)
Message-ID: <20060930193853.GA6890@ucw.cz>
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com> <20060929212748.GA10288@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929212748.GA10288@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> wpa_supplicant log of failing session available upon request.
> > >
> > >It looks like you reverted the WE-21 stuff.  Is your wireless-tools
> > >package up to date?
> > 
> > Well, that's the latest I get under FC5:
> > 
> > [asuardi@sandman ~]$ rpm -q wireless-tools
> > wireless-tools-28-0.pre13.5.1
> 
> 	That's too old, the cutoff is 27-pre15.
> 
> > but indeed (-git11 minus the reverts) iwconfig says
> > 
> > [asuardi@sandman ~]$ iwconfig eth1
> > Warning: Driver for device eth1 has been compiled with version 21
> > of Wireless Extension, while this program supports up to version 19.
> > Some things may be broken...
> 
> 	That's exactly the point of this warning (some distro like to
> kill it), I think it spells pretty clearly what's wrong. Don't say I
> did not warn you...

Well... we are trying to have stable abi here. Breaking older wireless
tools randomly is *not* okay in the middle of stable series.

> > If you have suggestions about either upgrading wireless-tools
> > from a non-FC5 repository or narrowing down the reverts, I'm
> > up for giving them a go :)
> 
> 	If you run a custom kernel, I think you won't see any problems
> running a custom version of Wireless Tools. They are available on my
> web site, pretty easy to install, and have minimal

No. Kernel abi is stable in 2.6.x.
-- 
Thanks for all the (sleeping) penguins.
