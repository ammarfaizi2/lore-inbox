Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbQLEURn>; Tue, 5 Dec 2000 15:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLEURg>; Tue, 5 Dec 2000 15:17:36 -0500
Received: from main.cyclades.com ([209.128.87.2]:63753 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S130002AbQLEURZ>;
	Tue, 5 Dec 2000 15:17:25 -0500
Date: Tue, 5 Dec 2000 11:46:49 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <Pine.LNX.4.30.0012051925330.6718-100000@pc24.sr.bham.ac.uk>
Message-ID: <Pine.LNX.4.10.10012051141200.1713-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Dec 2000, Mark Cooke wrote:
> 
> struct foo {
> 	unsigned int	crufty_compatability_number;
> 	.
> 	.
> 	.
> };
> 
>  ?

The problem is not this, but structure alignment and copy_[to|from]_user
operations. This approach, although it's my preferred one (due to being
self-contained), requires synchronization between kernel and utility, and
this sometimes is not always true.

Anyhow, I still prefer this approach over the "tons of different ioctl's"
one. I'd like to get the opinion of the community though (especially
Alan).

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
