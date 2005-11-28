Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVK1VFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVK1VFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVK1VFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:05:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46607 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751305AbVK1VFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:05:51 -0500
Date: Mon, 28 Nov 2005 21:05:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, afleming@gate.crashing.org
Subject: Re: [DRIVER MODEL] Allow overlapping resources for platform devices
Message-ID: <20051128210544.GE14557@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@gate.crashing.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, afleming@gate.crashing.org
References: <20051128180555.GB14557@flint.arm.linux.org.uk> <Pine.LNX.4.44.0511281236250.27530-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0511281236250.27530-100000@gate.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 12:40:25PM -0600, Kumar Gala wrote:
> Well the MDIO device actually is conceptually separate from the ethernet 
> controller that shares register space with it.  For example, we may have a 
> processor with 4 ethernet controllers on it.  We use the register set in 
> controller 1 to get to the MDIO "device" for all four controllers.
> 
> Hopefully, Andy can provide further details about order issues and how the 
> current PHY layer interacts with the ethernet controller.
> 
> However, the issue still exists that the MDIO devices registers live 
> inside another devices register space.

Thanks for clearing that up - I see why you need this now.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
