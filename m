Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286246AbRLTNgy>; Thu, 20 Dec 2001 08:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286252AbRLTNgp>; Thu, 20 Dec 2001 08:36:45 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:60682 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S286246AbRLTNgf>; Thu, 20 Dec 2001 08:36:35 -0500
Date: Thu, 20 Dec 2001 13:36:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI updates - prefetchable memory regions
Message-ID: <20011220133618.A30517@flint.arm.linux.org.uk>
In-Reply-To: <20011218235035.P13126@flint.arm.linux.org.uk> <20011220161331.A5330@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011220161331.A5330@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, Dec 20, 2001 at 04:13:31PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 04:13:31PM +0300, Ivan Kokshaysky wrote:
> This looks fine, but I don't like the idea of artificial splitting
> the PCI memory region if we want prefetch support.

Could you explain this a bit better.  The reason we need to split the
prefetchable regions from the non-prefetchable regions is that most
bridges can only cope with one region which is prefetchable.

Also, some machines have a limited (sometimes fixed address and size)
region that can only be used for prefetchable memory.  How do you cater
for this?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

