Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVCaDw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVCaDw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCaDwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:52:55 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:60833 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262484AbVCaDwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:52:47 -0500
Date: Thu, 31 Mar 2005 13:52:14 +1000
From: David McCullough <davidm@snapgear.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: johnpol@2ka.mipt.ru, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050331035214.GA12181@beast>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast> <20050323203856.17d650ec.akpm@osdl.org> <1111666903.23532.95.camel@uganda> <42432596.2090709@pobox.com> <1111724759.23532.121.camel@uganda> <42439781.4080007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42439781.4080007@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Jeff Garzik lays it down ...
...
> >If kernelspace can assist and driver _knows_ in advance that data
> >produced is cryptographically strong, why not allow it directly
> >access pools?
> 
> A kernel driver cannot know in advance that the data from a hardware RNG 
> is truly random, unless the data itself is 100% validated beforehand.

You can also say that it cannot know that data written to /dev/random
is truly random unless it is also validated ?

For argument you could just run "cat < /dev/hwrandom > /dev/random"
instead of using rngd.

If /dev/random demands a level of randomness,  shouldn't it enforce it ?

If the HW is using 2 random sources, a non-linear mixer and a FIPS140
post processor before handing you a random number it would be nice to
take advantage of that IMO.

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
