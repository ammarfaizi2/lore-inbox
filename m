Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWARUr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWARUr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWARUr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:47:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6411 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030434AbWARUr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:47:56 -0500
Date: Wed, 18 Jan 2006 21:47:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: maximilian attems <maks@sternwelten.at>,
       Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Bastian Blank <waldi@debian.org>
Subject: Re: [patch] kbuild: add automatic updateconfig target
Message-ID: <20060118204750.GD14340@mars.ravnborg.org>
References: <20060118194056.GA26532@nancy> <20060118204234.GC14340@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118204234.GC14340@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:42:34PM +0100, Sam Ravnborg wrote:
> Please always add Roman Zippel when dealing with kconfig changes.
And I should do so in my replies - yes!
Please use this mail for futher comments to keep all in the loop.

	Sam

	
> On Wed, Jan 18, 2006 at 08:40:56PM +0100, maximilian attems wrote:
> > From: Bastian Blank <waldi@debian.org>
> > 
> > current hack for daily build linux-2.6-git is quite ugly: 
> > yes "n" | make oldconfig
> > 
> > belows target helps to build git snapshots in a more automated way,
> > setting the new options to their default.
> 
> Please always add Roman Zippel when dealing with kconfig changes.
> We had a similar though more advanced proposal named miniconfig a month
> or so ago but Roman had some grief with it so it was not applied.
> 
> I've let Roman decide on this one too.
> Nitpicking below.
> 
> 	Sam
> 	
> 
> > +updateconfig: $(obj)/conf
> > +	$< -U arch/$(ARCH)/Kconfig
> 
> The other methods uses small letters so please change to '-u'
> 
> > -	set_random
> > +	set_random,
> > +	update_default,
> 
> Keep same naming as the others. May I suggest set_default.
> 
> You did not introduce a specific update.config file like for the other
> targets. Any reason for that?
> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
