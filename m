Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSFNVxO>; Fri, 14 Jun 2002 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSFNVxN>; Fri, 14 Jun 2002 17:53:13 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:27537 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S314491AbSFNVxM>;
	Fri, 14 Jun 2002 17:53:12 -0400
Date: Fri, 14 Jun 2002 23:53:09 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206142153.XAA03026@harpo.it.uu.se>
To: davej@suse.de, johnstul@us.ibm.com
Subject: Re: [Patch] tsc-disable_A5
Cc: Martin.Bligh@us.ibm.com, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002 21:56:54 +0200, Dave Jones wrote:
>On Fri, Jun 14, 2002 at 12:04:18PM -0700, john stultz wrote:
>
> > .config that looked like:
> > 
> > CONFIG_X86_TSC=y
> > ...
> > # CONFIG_X86_TSC is not set
> > So I assumed CONFIG_X86_TSC would still hold. Am I wrong, or is there
> > another way to do this?
>
>Ugh, I hadn't realised the .config generation was so primitive.
>That's quite unfortunate. That needs fixing at some point.

Unless my memory is failing me, I believe the simplest approach
is to (1) don't set CONFIG_X86_TSC, and (2) pass "notsc" as a
kernel boot parameter.

CONFIG_X86_TSC means "the machine has working TSC, period".
That's an intensional optimisation.

Without CONFIG_X86_TSC, Linux manages without TSC, but will
detect and use it if it's there.

Finally, the "notsc" kernel parameter is for obscure cases
where the TSC is present, but should not be used for whatever
reason. I guess the present issue qualifies...

/Mikael
