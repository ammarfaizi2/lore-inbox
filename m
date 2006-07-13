Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWGMVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWGMVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWGMVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:07:27 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:19627 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030395AbWGMVH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:07:27 -0400
Date: Thu, 13 Jul 2006 23:07:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Roman Zippel <zippel@linux-m68k.org>, wookey@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support DOS line endings
Message-ID: <20060713210725.GA1923@mars.ravnborg.org>
References: <20060707173458.GB1605@parisc-linux.org> <Pine.LNX.4.64.0607080513280.17704@scrub.home> <20060713181825.GA22895@mars.ravnborg.org> <Pine.LNX.4.64.0607132039560.12900@scrub.home> <20060713193543.GB312@mars.ravnborg.org> <20060713200223.GL1629@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713200223.GL1629@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 02:02:23PM -0600, Matthew Wilcox wrote:
> On Thu, Jul 13, 2006 at 09:35:43PM +0200, Sam Ravnborg wrote:
> > --- a/scripts/kconfig/confdata.c
> > +++ b/scripts/kconfig/confdata.c
> > @@ -195,6 +195,8 @@ load:
> >  			p2 = strchr(p, '\n');
> >  			if (p2)
> >  				*p2 = 0;
> > +			if (*--p2 == '\r')
> > +				*p2 = 0;
> 
> ... but if p2 is NULL ... 
> 
> so:
> 			if (p2) {
> 				*p2 = 0;
> 				if (*--p2 == '\r')
> 					*p2 = 0;
> 			}
> 
> but maybe it'd be better to do ...
> 
> 			if (p2) {
> 				*p2-- = 0;
> 				if (*p2 == '\r')
> 					*p2 = 0;
> 			}
Thanks. Maybe I should just stop trying to code anything today ;-)

	Sam
