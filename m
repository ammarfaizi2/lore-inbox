Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUKRXKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUKRXKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbUKRXGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:06:48 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:1462 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261184AbUKRXFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:05:38 -0500
Date: Thu, 18 Nov 2004 18:02:51 -0500
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: matthieu castet <castet.matthieu@free.fr>, jt@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
Message-ID: <20041118230251.GK29574@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
	matthieu castet <castet.matthieu@free.fr>, jt@hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <419CECFF.2090608@free.fr> <20041118185503.GA5584@bougret.hpl.hp.com> <419CFCDE.6090400@free.fr> <20041118204145.GA21873@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041118204145.GA21873@sci.fi>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 10:41:45PM +0200, Ville Syrjälä wrote:
> On Thu, Nov 18, 2004 at 08:49:50PM +0100, matthieu castet wrote:
> > Jean Tourrilhes wrote:
> > >On Thu, Nov 18, 2004 at 07:42:07PM +0100, matthieu castet wrote:
> > >>>>On3) If the ressources are markes as disabled, you just quit
> > >>>>with an error. Compouded with (2), this makes me doubly
> > >>>>nervous. Wouldn't it be possible to forcefully enable those 
> > >>
> > >>ressources ?
> > >>pnp should call automatiquely pnp_activate_dev() before probing the 
> > >>driver, so the resource should be activated. Have you got an example 
> > >>where the resource wheren't activated ?
> > >
> > >
> > >	No, it was more that I don't understand what PnP does for
> > >us. I don't have a SMS chipset to test on. Also, I would like to know
> > >if it remove the need of smcinit.
> > >
> > PnP is easy to understand ;)
> > When you probe a device, it will activate a device with the best 
> > configuration available.
> 
> So can we just remove the IORESOURCE_DISABLED tests?
> 
> And what about the pnp_*_valid() tests?
> 
> parport_pc (which I used as a guide) does both tests but 8250_pnp doesn't 
> do either.

Parport_pc uses them because resources could potentially be disabled, but the
parport could still be functional.  Therefore, it must check.  It is probably
ok to not check on most hardware.  Nonetheless, it's best to play it safe, and
always verify the resource configuration.

Thanks,
Adam
