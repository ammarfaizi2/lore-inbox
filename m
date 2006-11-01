Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161658AbWKAFAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161658AbWKAFAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161646AbWKAFAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:00:37 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:55228 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1161639AbWKAFAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:00:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=dhtxkaTBPmApODDQ1FDZuYZRsvTASHNnlBYkRunJX8bBFbkb3zAtFAUR1FKpN
	XrrBkJVlukx7qsIY1JWHeiEvQ==
Date: Wed, 1 Nov 2006 06:00:34 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tmattox@gmail.com, spiky.kiwi@gmail.com, r.bhatia@ipax.at,
       Darren Salt <linux@youmustbejoking.demon.co.uk>,
       Syed Azam <syed.azam@hp.com>, tbm@cyrius.com
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)
Message-ID: <20061101050034.GB24496@xi.wantstofly.org>
References: <20061029223410.GA15413@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610300032190.1435@poirot.grange> <20061030120158.GA28123@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610302148560.9723@poirot.grange> <Pine.LNX.4.60.0610302214350.9723@poirot.grange> <20061030234425.GB6038@electric-eye.fr.zoreil.com> <Pine.LNX.4.60.0610312000160.5223@poirot.grange> <20061031230538.GA4329@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031230538.GA4329@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 12:05:38AM +0100, Francois Romieu wrote:

> o Lennert, can you apply the two patches
>   - 0001-r8169-perform-a-PHY-reset-before-any-other-operation-at-boot-time.txt
>   - 0002-r8169-more-magic.txt
>   at http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.19-rc4/r8169 against
>   2.6.19-rc4 (2.6.19-rc4 reverted the MAC address changes) and see if the
>   n2100 board still needs to remove the SYSErr handler ?

2.6.19-rc4 + these two patches => doesn't work

2.6.19-rc4 + these two patches + SYSErr removal => works

For reference:
* 2.6.19-rc4 + SYSErr removal => works

So, while these two patches don't fix the problem, they don't seem
to be making things worse, something the MAC address change did do.


cheers,
Lennert
