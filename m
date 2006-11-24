Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935067AbWKXVYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935067AbWKXVYB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935066AbWKXVYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:24:00 -0500
Received: from 1wt.eu ([62.212.114.60]:18180 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S935063AbWKXVYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:24:00 -0500
Date: Fri, 24 Nov 2006 22:23:06 +0100
From: Willy Tarreau <w@1wt.eu>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       Andreas Koensgen <ajk@iehk.rwth-aachen.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 6pack: fix "&= !" typo
Message-ID: <20061124212306.GA1736@1wt.eu>
References: <20061122225856.GB10758@1wt.eu> <20061124185816.GB4973@martell.zuzino.mipt.ru> <20061124202153.GA11858@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124202153.GA11858@linux-mips.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 08:21:53PM +0000, Ralf Baechle wrote:
> On Fri, Nov 24, 2006 at 09:58:16PM +0300, Alexey Dobriyan wrote:
> 
> > Andreas, is this correct?
> > ---------------------------------
> > SIXP_RX_DCD_MASK is 0x18, so the command below will make cmd 0 always.
> > This is likely wrong.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> This one is already merged.
> 
> It's funny how long this bug survived - it's in the kernel since the 6pack
> driver was first merged that is 2.1 or 2.2 ...

One more reason to perform more code reviews helped with automated tools.
We found this one and the rio's one while discussing with Jean Delvare
about such bugs, and firing a random grep to illustrate how easy it could
be to spot bugs similar to Alexey's "&&" instead of "&" ...

I think that we should at least take a look at all lines in the pre-processed
code having both '!' and '&' on the same line. There are a lot of them, but
divided by a sufficient number of volunteers, we might catch a bunch of them.

BTW, has anyone a good idea on how to make gcc dump the preprocessed files
for everything it builds ? I mean, just by changing some variables in the
Makefile.

>   Ralf

Cheers,
Willy

