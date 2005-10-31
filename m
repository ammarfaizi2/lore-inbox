Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVJaL72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVJaL72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVJaL72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:59:28 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:15119 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S932306AbVJaL71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:59:27 -0500
Date: Mon, 31 Oct 2005 11:59:06 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Pete Popov <ppopov@embeddedalley.com>
Subject: Re: [FIXME] Comments on serial and MMC changes in MIPS merge
Message-ID: <20051031115906.GE13561@linux-mips.org>
References: <20051029220722.GI14039@flint.arm.linux.org.uk> <4364A7D6.2060006@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4364A7D6.2060006@drzeus.cx>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:00:38PM +0100, Pierre Ossman wrote:

> > 1. au1xxx mmc driver
> > 
> >    mmc_remove_host() does a safe shutdown of the MMC host, removing
> >    cards and then powering down.  This must be called prior to the
> >    driver thinking of tearing anything down.
> > 
> >    As for those disable_irq()...enable_irq(), are you aware that MMC
> >    can start talking to the host as soon as you've called mmc_add_host() ?
> > 
> 
> I'm also concerned about the ammount of protocol awareness in this
> driver. Is there a spec available for this hardware? Perhaps the MMC
> layer can export more information so that we can avoid switches on
> specific MMC commands?

Cc'ed to ppopov, the actual author.

  Ralf
