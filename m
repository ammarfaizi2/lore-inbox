Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266508AbSKGKah>; Thu, 7 Nov 2002 05:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266510AbSKGKah>; Thu, 7 Nov 2002 05:30:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26635 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266508AbSKGKae>; Thu, 7 Nov 2002 05:30:34 -0500
Date: Thu, 7 Nov 2002 10:37:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CFT/RFC: New cardbus resource allocation
Message-ID: <20021107103712.C7579@flint.arm.linux.org.uk>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
References: <20021106194126.B7495@flint.arm.linux.org.uk> <20021107132540.A2612@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021107132540.A2612@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, Nov 07, 2002 at 01:25:40PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 01:25:40PM +0300, Ivan Kokshaysky wrote:
> Looks quite reasonable.
> Note that we don't need 2 similar functions in setup-res.c -
> pci_assign_resource() can be easily converted to use your
> pci_alloc_parent_resource(), and pci_assign_bus_resource() can
> be killed then.

I looked at that and decided it wasn't practical.  pci_assign_resource()
needs the parent resource to pass it down to the architecture specific
layers.  Unfortunately, trying to get that out of
pci_alloc_parent_resource() makes the API rather disgusting IMHO.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

