Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVLTNhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVLTNhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 08:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVLTNhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 08:37:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17674 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751010AbVLTNha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 08:37:30 -0500
Date: Tue, 20 Dec 2005 14:37:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark Lord <lkml@rtr.ca>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>, nel@vger.kernel.org
Subject: Re: About 4k kernel stack size....
Message-ID: <20051220133729.GC6789@stusta.de>
References: <20051218231401.6ded8de2@werewolf.auna.net> <43A77205.2040306@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A77205.2040306@rtr.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 09:52:53PM -0500, Mark Lord wrote:
>...
> The mainline code paths are undoubtedly fine with 4K stacks.
> It's the *error paths* that are most likely to go deeper on the stack,
> and those are rarely exercised by anyone.  And those are the paths
> that we *really* need to be reliable.

"most likely" is a strong sentence, especially considering that the 
automatic analysis of all possible call chains can and has already 
identified several such problems (which have now been fixed many months 
ago).

We might not getting 100% security against stack overflows, but that's 
not fundamentally different from the current situation with 6 kB stacks.

> Cheers

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

