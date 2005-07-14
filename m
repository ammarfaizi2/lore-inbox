Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263153AbVGNVr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbVGNVr2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 17:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVGNVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 17:47:15 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:44976 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263153AbVGNVqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:46:07 -0400
Date: Fri, 15 Jul 2005 01:46:11 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Message-ID: <20050715014611.B613@den.park.msu.ru>
References: <20050714155344.A27478@jurassic.park.msu.ru> <20050714145327.B7314@flint.arm.linux.org.uk> <9e47339105071407073f07bed7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9e47339105071407073f07bed7@mail.gmail.com>; from jonsmirl@gmail.com on Thu, Jul 14, 2005 at 10:07:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 10:07:34AM -0400, Jon Smirl wrote:
> I'm don't think it has ever been working in the 2.6 series. If you are
> getting rid of it get rid of the #define PCI_BRIDGE_CTL_VGA in pci.h
> too since this code was the only user.

No. The PCI_BRIDGE_CTL_VGA is not something artificial, it just describes
some well defined hardware bit in the p2p bridge config header, so anyone
working on VGA switching API will have to use it.

> This code is part of VGA arbitration which BenH is addressing with a
> more globally comprehensive patch. Ben's code will probably replace
> it.

Yes, I've heard Ben is working on this, but I've yet to see the code. ;-)
Any pointers?

Ivan.
