Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWFFF6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWFFF6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 01:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFFF6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 01:58:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53462 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932117AbWFFF6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 01:58:45 -0400
From: Andi Kleen <ak@suse.de>
To: David Miller <davem@davemloft.net>
Subject: Re: 2.6.17-rc5-mm1
Date: Tue, 6 Jun 2006 07:56:36 +0200
User-Agent: KMail/1.9.3
Cc: mbligh@mbligh.org, linux-kernel@vger.kernel.org
References: <447E3846.1060302@shaw.ca> <p73ac8w0wju.fsf@verdi.suse.de> <20060605.213655.41876860.davem@davemloft.net>
In-Reply-To: <20060605.213655.41876860.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606060756.36193.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 June 2006 06:36, David Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: 02 Jun 2006 10:52:05 +0200
> 
> > "Martin J. Bligh" <mbligh@mbligh.org> writes:
> > > 
> > > All sounds very sensible ... but not sure why -mm would hit it all the
> > > time, and never mainline ...
> > 
> > You can use memeat.c to test the machine with other kernels.
> > It tends to find such problems reliably. Let it run for some time
> > 
> > http://www.firstfloor.org/~andi/memeat.c
> 
> Wouldn't it be more useful for this program to use LowTotal instead of
> LowFree?  It didn't grind my sparc64 machine much until I changed it
> like that. :)

The idea is that the memory that is already used is tested. And the machine should
be still usable.

If you want a generic memory eater you can use memhog from numactl.

It's mainly a quick test for machines that error out when they detect
a 2 bit errors using ECC. And when run for longer it tends to stress
other parts of the motherboard like VRMs.

At least on Opterons with ECC memory it seems to detect most memory problems
pretty reliably, that is why I suggested it to Martin.

-Andi


> 
> 
