Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVDNIkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVDNIkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVDNIkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:40:42 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:10768 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261467AbVDNIkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:40:36 -0400
Date: Thu, 14 Apr 2005 18:38:01 +1000
To: Andy Isaacson <adi@hexapodia.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andreas Steinmetz <ast@domdv.de>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: encrypted swap (was Re: [PATCH encrypted swsusp 1/3] core functionality)
Message-ID: <20050414083801.GA13540@gondor.apana.org.au>
References: <20050413233904.GA31174@gondor.apana.org.au> <20050414083119.GB24892@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414083119.GB24892@hexapodia.org>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 01:31:19AM -0700, Andy Isaacson wrote:
> 
> Does dmcrypt have a simple operation mode like OpenBSD's encrypted swap?
> I want to be able to 'sysctl -w kernel.swap_crypt=1' and get

It's not that easy however the distros can make it so that it's as
simple as running one command to enable/disable it.

>  * pages are encrypted as they're written to swap

Yep.

>  * the key is automatically regenerated every 2 hours (or whatever); as
>    pages encrypted under the old key age out, it can be freed eventually

This'll require changes to dmcrypt but it's doable.

>  * I don't have to manage keys, choose algorithms, futz with /etc/fstab,
>    figure out complex configs for /dev/loopN, etc

You don't need to worry about keys unless you want to read from the swap
after a reboot, i.e., swsusp.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
