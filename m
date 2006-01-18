Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWARWcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWARWcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWARWcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:32:52 -0500
Received: from baikonur.stro.at ([213.239.196.228]:57503 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S932567AbWARWcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:32:51 -0500
Date: Wed, 18 Jan 2006 23:32:33 +0100
From: maximilian attems <maks@sternwelten.at>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Bastian Blank <waldi@debian.org>
Subject: Re: [patch] kbuild: add automatic updateconfig target
Message-ID: <20060118223233.GA6217@nancy>
References: <20060118194056.GA26532@nancy> <20060118204234.GC14340@mars.ravnborg.org> <20060118204750.GD14340@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118204750.GD14340@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Sam Ravnborg wrote:

> On Wed, Jan 18, 2006 at 09:42:34PM +0100, Sam Ravnborg wrote:
> > Please always add Roman Zippel when dealing with kconfig changes.
> And I should do so in my replies - yes!
> Please use this mail for futher comments to keep all in the loop.
> 
> 	Sam

ok will do.
 	
> > On Wed, Jan 18, 2006 at 08:40:56PM +0100, maximilian attems wrote:
> > > From: Bastian Blank <waldi@debian.org>
> > > 
> > > current hack for daily build linux-2.6-git is quite ugly: 
> > > yes "n" | make oldconfig
> > > 
> > > belows target helps to build git snapshots in a more automated way,
> > > setting the new options to their default.
> > 
> > Please always add Roman Zippel when dealing with kconfig changes.
> > We had a similar though more advanced proposal named miniconfig a month
> > or so ago but Roman had some grief with it so it was not applied.
> > 
> > I've let Roman decide on this one too.
> > Nitpicking below.
> > 
> > 	Sam
> > 	
> > 
> > > +updateconfig: $(obj)/conf
> > > +	$< -U arch/$(ARCH)/Kconfig
> > 
> > The other methods uses small letters so please change to '-u'
> > 
> > > -	set_random
> > > +	set_random,
> > > +	update_default,
> > 
> > Keep same naming as the others. May I suggest set_default.

ok easy stuff.
 
> > You did not introduce a specific update.config file like for the other
> > targets. Any reason for that?
> > 
> > 	Sam

naah, looks more like an oversight.
will rediff and resend.

-- 
maks
