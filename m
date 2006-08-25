Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWHYK0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWHYK0v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWHYK0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:26:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33803 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932390AbWHYK0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:26:50 -0400
Date: Fri, 25 Aug 2006 12:26:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Add __global tag where needed.
Message-ID: <20060825102649.GU19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org> <1156433212.3012.120.camel@pmac.infradead.org> <20060824213047.GR19810@stusta.de> <1156499546.2984.43.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156499546.2984.43.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 10:52:26AM +0100, David Woodhouse wrote:
> On Thu, 2006-08-24 at 23:30 +0200, Adrian Bunk wrote:
> > Applying this doesn't seem to make much sense until it's clear whether a
> > "build everything except for assembler files at once" approach (that 
> > needs less globals) or your current "compile only multi-obj at once" 
> > approach (that requires more globals). 
> 
> For the kernel itself, I think that building a directory at once is the
> way forward. For modules, obviously the scope is more limited.

For any desktop or server you buy today your patches are a nice 
improvement but not that important.

But projects like embedded systems or OLPC that really need want 
kernels should be the same projects that already avoid the
10% size penalty of CONFIG_MODULES=y.

> Either way, I'd like to prevent the unnecessary proliferation of
> __global by instrument the link process somehow so that we get a
> _warning_ during the final link if there are any global symbols which
> aren't actually used.
>...

That would give many false positives from files like fs/libfs.c .

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

