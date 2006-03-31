Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWCaSTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWCaSTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWCaSTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:19:53 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:44466 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S932193AbWCaSTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:19:52 -0500
Subject: Re: [spi-devel-general] Re: question on spi_bitbang
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: David Brownell <david-b@pacbell.net>
Cc: Kumar Gala <galak@kernel.crashing.org>,
       spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200603311011.00981.david-b@pacbell.net>
References: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org>
	 <200603311011.00981.david-b@pacbell.net>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Fri, 31 Mar 2006 10:19:40 -0800
Message-Id: <1143829180.4355.51.camel@ststephen.streetfiresound.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 10:11 -0800, David Brownell wrote:
> I don't know how your particular hardware works, but if you have a
> real SPI controller it would probably be more natural to have your
> setup() function handle that mode register earlier, out of the main
> transfer loop ... unless that mode register is shared among all
> chipselects, in which case you'd use the setup_transfer() call for
> that, inside the transfer loop.  (That call hasn't yet been merged
> into the mainline kernel yet; it's in the MM tree.)
> 
Is setup_transfer() a change to framework API or just the bit_bang
driver?

> The chipselect() call should only affect the chipselect signal and,
> when you're activating a chip, its initial clock polarity.  Though
> if you're not using the latest from the MM tree, that's also your
> hook for ensuring that the SPI mode is set up right.
> 
Ditto?

-Stephen

