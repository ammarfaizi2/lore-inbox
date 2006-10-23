Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWJWQok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWJWQok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWJWQok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:44:40 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:5650 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932169AbWJWQoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:44:39 -0400
Date: Mon, 23 Oct 2006 17:44:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>, linux-kernel@vger.kernel.org,
       linux-omap-open-source@linux.omap.com,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       ilias.biris@indt.org.br
Subject: Re: [patch 0/6] [RFC] Add MMC Password Protection (lock/unlock) support V5
Message-ID: <20061023164422.GB24471@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Carlos Aguiar <carlos.aguiar@indt.org.br>,
	linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com,
	David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>, ilias.biris@indt.org.br
References: <20061020164914.012378000@localhost.localdomain> <453C5B33.6030300@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453C5B33.6030300@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 08:03:31AM +0200, Pierre Ossman wrote:
> Carlos Aguiar wrote:
> > Hi folks,
> 
> Hi Carlos,
> 
> This is very nice work and it is something that should be in the kernel.
> 
> Unfortunately, I won't have time to look at this until the end of the
> week. So just hang tight, I haven't overlooked you. :)

Just make sure that it checks for MMC_CAP_BYTEBLOCK - if that flag isn't
set, the host can't do non-power of two transfers, so probably password
support has to be refused on such hosts.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
