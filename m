Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUDMUve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 16:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263746AbUDMUve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 16:51:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6075 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263742AbUDMUvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 16:51:32 -0400
Date: Tue, 13 Apr 2004 16:02:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: PAT support
Message-ID: <20040413140253.GG468@openzaurus.ucw.cz>
References: <407B7BDE.5030002@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407B7BDE.5030002@colorfullife.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> in your patch, you write
> +/* Here is the PAT's default layout on ia32 cpus when we are done.
> + * PAT0: Write Back
> + * PAT1: Write Combine
> + * PAT2: Uncached
> + * PAT3: Uncacheable
> + * PAT4: Write Through
> + * PAT5: Write Protect
> + * PAT6: Uncached
> + * PAT7: Uncacheable
> 
> Is that layout possible?
> There is an errata in the B2 and C1 stepping of the Pentium 4 cpus 
> that results in incorrect PAT numbers: the highest bit is ignored by 
> the CPU under some circumstances. There's a similar errata (E27) that 
> affects all Pentium 3 cpus: The highest bit is always ignored.
> I think we need a fallback to 4 PAT entries.

What about arranging it so that foo is always more restrictive than
foo|4? That way you can get some slowdowns on bad cpus, but it
will always be correct.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

