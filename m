Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVC1XBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVC1XBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVC1XBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:01:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31716 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262104AbVC1XA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:00:59 -0500
Date: Tue, 29 Mar 2005 01:00:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050328230008.GA1761@elf.ucw.cz>
References: <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de> <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de> <20050325101344.GA1297@elf.ucw.cz> <d120d500050325061963fb13db@mail.gmail.com> <20050325142414.GF23602@elf.ucw.cz> <d120d50005032506526f6b9304@mail.gmail.com> <20050325154237.GB3738@elf.ucw.cz> <d120d5000503250804176343f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000503250804176343f9@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Btw, I dont think that doing selective resume (as opposed to selective
> > > suspend and Nigel's partial device trees) would be so much
> > > complicated. You'd always resume sysdevs and then, when iterating over
> > > "normal" devices, just skip ones not in resume path. It can all be
> > > contained in driver core I believe (sorry but no patch, for now at
> > > least).
> > 
> > :-) I think we can simply make device freeze/unfreeze fast enough.
> > [We do not need to do full suspend/resume; freeze is enough].
> 
> It is not suspend/freeze here that gets us but resume and with resume
> the driver (at least for now) does not have any idea if it is
> "unfreeze" or "full-resume". I mean I could have serio just ignore
> "unfreeze" requests (as I doubt anyone would ever try to suspend over
> PS/2 port ;) ) but I think it should be really handled by the core.

Please just always do full-resume... for now. Patches that enable you
to detect "unfreeze" are not in, yet. If something fails, just printk
with big enough severity and continue, as you don't have method of
signaling error, anyway.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
