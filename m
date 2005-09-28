Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVI1Kem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVI1Kem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 06:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVI1Kem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 06:34:42 -0400
Received: from marasystems.com ([83.241.133.2]:39067 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S1750872AbVI1Kel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 06:34:41 -0400
Date: Wed, 28 Sep 2005 12:34:33 +0200 (CEST)
From: Henrik Nordstrom <hno@marasystems.com>
To: Harald Welte <laforge@netfilter.org>
cc: Andi Kleen <ak@suse.de>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
In-Reply-To: <20050928083240.GP4168@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.61.0509281232420.4655@filer.marasystems.com>
References: <432EF0C5.5090908@cosmosbay.com> <200509221503.21650.ak@suse.de>
 <20050923170911.GN731@sunbeam.de.gnumonks.org> <200509271823.19365.ak@suse.de>
 <Pine.LNX.4.61.0509280219110.25500@filer.marasystems.com>
 <20050928083240.GP4168@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Harald Welte wrote:

> Just imagine all those poor sysadmins who know nothing about current
> kernel development, and who upgrade their kernel because their
> distributor provides a new one - suddenly their accounting (which might
> be relevant for their business) doesn't work anymore :(

You seriously expect anyone is using the counters on the policy rule in 
otherwise completely empty rulesets? These counters is also available 
elsewhere (route and interface statistics) and more intuitively so.

> yes, even though we could make the ip_nat / iptable_nat split (that is
> introduced in 2.6.14) in a way that would make ip_nat.ko register those
> hooks that are implicitly needed, and iptable_nat only the user-visible
> chain-related hooks.

Which adds additional overhead, so this approach is a bit 
counter-productive I would say.

Regards
Henrik
