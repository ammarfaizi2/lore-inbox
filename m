Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbUDOEFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 00:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbUDOEFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 00:05:55 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31392 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263753AbUDOEFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 00:05:53 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: PAT support
References: <407B7BDE.5030002@colorfullife.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Apr 2004 22:05:25 -0600
In-Reply-To: <407B7BDE.5030002@colorfullife.com>
Message-ID: <m1k70h6g3e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> Hi Terence,
> 
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
> There is an errata in the B2 and C1 stepping of the Pentium 4 cpus that results
> in incorrect PAT numbers: the highest bit is ignored by the CPU under some
> circumstances. There's a similar errata (E27) that affects all Pentium 3 cpus:
> The highest bit is always ignored.
> I think we need a fallback to 4 PAT entries.

Write Through and Write Protect are essentially useless.  So that should
be easy to do.

Eric
