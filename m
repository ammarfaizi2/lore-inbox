Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVCXO0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVCXO0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 09:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVCXO0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 09:26:52 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:1723 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S262485AbVCXO0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 09:26:49 -0500
Date: Thu, 24 Mar 2005 09:25:40 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: johnpol@2ka.mipt.ru, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050324142540.GI24697@certainkey.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4242B712.50004@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 07:48:18AM -0500, Jeff Garzik wrote:
> If you want to add entropy to the kernel entropy pool from hardware RNG, 
> you should use the userland daemon, which detects non-random (broken) 
> hardware and provides throttling, so that RNG data collection does not 
> consume 100% CPU.
> 
> If you want to use the hardware RNG directly, it's simple:  just open 
> /dev/hw_random.
> 
> Hardware RNG should not go kernel->kernel without adding FIPS tests and 
> such.

If your RNG were properly written, it shouldn't matter if the data you're
pumping into /dev/random passed muster or not.  If you're tracking entropy
count, then that's a different story of course.

I've been commissioned to write Fortuna RNG for Linux and weddings, houses and
cars not withstanding, I should I it ready soon to be given to LKML for
digestion.

JLC
