Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030754AbWFOSwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030754AbWFOSwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030788AbWFOSwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:52:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34320 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030754AbWFOSwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:52:46 -0400
Date: Thu, 15 Jun 2006 19:52:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] PATCH: Fix 32bitism in SDHCI
Message-ID: <20060615185239.GC8694@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pierre Ossman <drzeus-list@drzeus.cx>, sdhci-devel@list.drzeus.cx,
	linux-kernel@vger.kernel.org
References: <1150385605.3490.85.camel@localhost.localdomain> <449191EE.2090309@drzeus.cx> <1150393058.3490.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150393058.3490.120.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 06:37:37PM +0100, Alan Cox wrote:
> Ar Iau, 2006-06-15 am 18:59 +0200, ysgrifennodd Pierre Ossman:
> > Alan Cox wrote:
> > > The data field is ulong, pointers fit in ulongs. Casting them to int is
> > > bad for 64bit systems.
> > 
> > It's in my (rather large) queue. I'm just waiting for a merge window. :)
> 
> I'd have thought that one was a "Duh whoops, fix it now" kind of
> submission for 2.6.17

akpm sent it to me, so I merged it into my tree, and now I've been
sitting on it all this week because I've taken the decision that I
do not want to put anything further into Linus' tree until we actually
see 2.6.17.

If you look at what Linus said when he released -rc7, the reason we
had -rc7 instead of -final was that we had too many changes.  We can
either go on throwing more and more changes, albiet 100% correct
bug fix changes, and carry on releasing -rc after -rc, but at some
point there must be an end to this, and -final must happen.

It's been three months since 2.6.16 was released.  I'm not prepared
to be the reason that we have another week of -rc-ism because of too
many small but apparantly correct changes.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
