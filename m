Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSKMP0U>; Wed, 13 Nov 2002 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSKMP0U>; Wed, 13 Nov 2002 10:26:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17159 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261934AbSKMP0U>; Wed, 13 Nov 2002 10:26:20 -0500
Date: Wed, 13 Nov 2002 15:33:08 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Harald Jung <jung@ecos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cardbus card behind a pci to pci bridge
Message-ID: <20021113153308.A27346@flint.arm.linux.org.uk>
Mail-Followup-To: Harald Jung <jung@ecos.de>, linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021113133414.00b53b00@mail.dns-host.com> <3DD26382.692BD476@aitel.hist.no> <200211131750.22498.jung@ecos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211131750.22498.jung@ecos.de>; from jung@ecos.de on Wed, Nov 13, 2002 at 05:50:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 05:50:22PM +0100, Harald Jung wrote:
> it seems that it isn't possible to map the memory of a pcmcia card or to
> read from it if it is behind a pci to pci bridge.

In the present state, yenta.c just can't handle this.

I've got a pile of patches which allow it to work in a similar situation
on non-x86 platforms, but it breaks x86 (since it doesn't use the
generic PCI resource code.)

Still working on it though, between doing lots of other stuff.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

