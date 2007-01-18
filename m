Return-Path: <linux-kernel-owner+w=401wt.eu-S965004AbXASJS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbXASJS6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 04:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbXASJS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 04:18:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1244 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965004AbXASJS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 04:18:57 -0500
Date: Thu, 18 Jan 2007 23:16:51 +0000
From: Pavel Machek <pavel@ucw.cz>
To: andi@lisas.de
Cc: davej@codemonkey.org.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: intel-agp PM experiences (was: 2.6.20-rc5: usb mouse breaks suspend to ram)
Message-ID: <20070118231650.GA5352@ucw.cz>
References: <20070116135727.GA2831@elf.ucw.cz> <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com> <20070116142432.GA6171@elf.ucw.cz> <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com> <20070117004012.GA11140@rhlx01.hs-esslingen.de> <20070117005755.GB6270@elf.ucw.cz> <20070118115105.GA28233@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118115105.GA28233@rhlx01.hs-esslingen.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Especially the PCI video_state trick finally got me a working resume on
> > > 2.6.19-ck2 r128 Rage Mobility M4 AGP *WITH*(!) fully enabled and working
> > > (and keeping working!) DRI (3D).
> > 
> > Can we get whitelist entry for suspend.sf.net? s2ram from there can do
> > all the tricks you described, one letter per trick :-). We even got
> > PCI saving lately.
> 
> Whitelist? Let me blacklist it all the way to Timbuktu instead!

> I've been doing more testing, and X never managed to come back to working
> state without some of my couple intel-agp changes:
> - a proper suspend method, doing a proper pci_save_state()
>   or improved equivalent
> - a missing resume check for my i815 chipset
> - global cache flush in _configure
> - restoring AGP bridge PCI config space

Can you post a patch?

Whitelist entry would still be welcome.

> All in all intel-agp code semi-shattered my universe.
> I didn't expect to find all these issues in rather important core code
...
> Given the myriads of resume issues we experience in general,
> it may be wise to do something as simple as a code review of *all*

Any volunteers?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
