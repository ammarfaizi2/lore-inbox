Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268125AbUHFKrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268125AbUHFKrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUHFKrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:47:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55825 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268125AbUHFKrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:47:12 -0400
Date: Fri, 6 Aug 2004 11:47:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <ambx1@neo.rr.com>, linux@dominikbrodowski.de, akpm@osdl.org,
       rml@ximian.com, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH] pcmcia driver model support [1/5]
Message-ID: <20040806114708.B13653@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, linux@dominikbrodowski.de,
	akpm@osdl.org, rml@ximian.com, linux-kernel@vger.kernel.org,
	linux-pcmcia@lists.infradead.org
References: <20040805222026.GA11641@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040805222026.GA11641@neo.rr.com>; from ambx1@neo.rr.com on Thu, Aug 05, 2004 at 10:20:26PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 10:20:26PM +0000, Adam Belay wrote:
> This patch set is an updated version from the last and is against
> 2.6.8-rc3.  It includes suggestions from Dominik and an independent
> pcmcia bugfix.  I would appreciate any comments.

I'm overall _NOT_ happy with the growing number of people trying to
"fix" PCMCIA to do what they want it to do.

I've recently had davem screaming and shouting his head off at me
while I was at OLS claiming that PCMCIA network drivers _MUST_ be
user unloadable at any time, irrespective of the requirements of
the PCMCIA layer.

It's _VERY_ easy to fuck up the PCMCIA code - we've fucked it up
several times already and the only way to detect these fuckups is
to change things _SLOWLY_ and let a full release cycle pass by
between changes.  Yes, it means that PCMCIA changes take _MONTHS_
but that's reality.

So please slow down.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
