Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266493AbSKGKUe>; Thu, 7 Nov 2002 05:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266488AbSKGKUe>; Thu, 7 Nov 2002 05:20:34 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:5893 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S266486AbSKGKTY>; Thu, 7 Nov 2002 05:19:24 -0500
Date: Thu, 7 Nov 2002 13:25:40 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: CFT/RFC: New cardbus resource allocation
Message-ID: <20021107132540.A2612@jurassic.park.msu.ru>
References: <20021106194126.B7495@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021106194126.B7495@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Nov 06, 2002 at 07:41:26PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 07:41:26PM +0000, Russell King wrote:
> The following patch changes this.  We instead use the PCI resource
> code to allocate a resource of the requested size, alignment, and
> offset from the parent bus of the cardbus bridge.

Looks quite reasonable.
Note that we don't need 2 similar functions in setup-res.c -
pci_assign_resource() can be easily converted to use your
pci_alloc_parent_resource(), and pci_assign_bus_resource() can
be killed then.

Ivan.
