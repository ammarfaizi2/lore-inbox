Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbUKRUpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbUKRUpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUKRUm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:42:29 -0500
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:8077 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261153AbUKRUlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:41:46 -0500
Date: Thu, 18 Nov 2004 22:41:45 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: matthieu castet <castet.matthieu@free.fr>
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
Message-ID: <20041118204145.GA21873@sci.fi>
References: <419CECFF.2090608@free.fr> <20041118185503.GA5584@bougret.hpl.hp.com> <419CFCDE.6090400@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <419CFCDE.6090400@free.fr>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 08:49:50PM +0100, matthieu castet wrote:
> Jean Tourrilhes wrote:
> >On Thu, Nov 18, 2004 at 07:42:07PM +0100, matthieu castet wrote:
> >>>>On3) If the ressources are markes as disabled, you just quit
> >>>>with an error. Compouded with (2), this makes me doubly
> >>>>nervous. Wouldn't it be possible to forcefully enable those 
> >>
> >>ressources ?
> >>pnp should call automatiquely pnp_activate_dev() before probing the 
> >>driver, so the resource should be activated. Have you got an example 
> >>where the resource wheren't activated ?
> >
> >
> >	No, it was more that I don't understand what PnP does for
> >us. I don't have a SMS chipset to test on. Also, I would like to know
> >if it remove the need of smcinit.
> >
> PnP is easy to understand ;)
> When you probe a device, it will activate a device with the best 
> configuration available.

So can we just remove the IORESOURCE_DISABLED tests?

And what about the pnp_*_valid() tests?

parport_pc (which I used as a guide) does both tests but 8250_pnp doesn't 
do either.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
