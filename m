Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbSJEB2Q>; Fri, 4 Oct 2002 21:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261953AbSJEB2Q>; Fri, 4 Oct 2002 21:28:16 -0400
Received: from zero.aec.at ([193.170.194.10]:22022 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261952AbSJEB2P>;
	Fri, 4 Oct 2002 21:28:15 -0400
Date: Sat, 5 Oct 2002 03:33:40 +0200
From: Andi Kleen <ak@muc.de>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40: lkcd (4/9): additional kernel symbols
Message-ID: <20021005013340.GA11802@averell>
References: <m3znttg2wz.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0210041822120.10168-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210041822120.10168-100000@nakedeye.aparity.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 03:25:24AM +0200, Matt D. Robinson wrote:
> On 5 Oct 2002, Andi Kleen wrote:
> |>"Matt D. Robinson" <yakker@aparity.com> writes:
> |>
> |>> diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/kernel/i386_ksyms.c linux-2.5.40+lkcd/arch/i386/kernel/i386_ksyms.c
> |>> --- linux-2.5.40/arch/i386/kernel/i386_ksyms.c	Tue Oct  1 12:36:59 2002
> |>> +#if defined(CONFIG_X86) || defined(CONFIG_ALPHA)
> |>> +EXPORT_SYMBOL(page_is_ram);
> |>> +#endif
> |>
> |>This ifdef in i386_ksyms.c doesn't make much sense...
> 
> If the rest of the architectures used page_is_ram(), this
> wouldn't be a problem, but not all do.  And since we use
> it/need it, that's the reason for the addition.

My point was that in i386_ksyms you are always on i386 and never on alpha.
So you can just remove that #ifdef.


-Andi
