Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030598AbVKXFG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030598AbVKXFG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbVKXFG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:06:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20230 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030598AbVKXFG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:06:27 -0500
Date: Thu, 24 Nov 2005 06:06:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm patch] init/main.c: dummy mark_rodata_ro() should be static
Message-ID: <20051124050626.GN3963@stusta.de>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123223505.GF3963@stusta.de> <Pine.LNX.4.58.0511231443420.20189@shark.he.net> <20051123225440.GJ3963@stusta.de> <20051124042150.GC30849@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124042150.GC30849@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 11:21:50PM -0500, Dave Jones wrote:
> On Wed, Nov 23, 2005 at 11:54:40PM +0100, Adrian Bunk wrote:
>  > On Wed, Nov 23, 2005 at 02:46:51PM -0800, Randy.Dunlap wrote:
>  > > On Wed, 23 Nov 2005, Adrian Bunk wrote:
>  > > 
>  > > > Every inline dummy function should be static.
>  > > 
>  > > Please explain why it matters in this case.
>  > 
>  > We don't need an additional global copy of the function.
> 
> it's an empty body, surely the compiler will compile it away ?

For the one call in init/main.c the function is always inlined and 
optimized away.

But if it isn't static, gcc must additionally emit a global function.

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

