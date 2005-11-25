Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbVKYPtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbVKYPtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbVKYPtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:49:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2056 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161121AbVKYPtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:49:23 -0500
Date: Fri, 25 Nov 2005 16:49:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm patch] dummy mark_rodata_ro() should be static
Message-ID: <20051125154922.GT3963@stusta.de>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123223505.GF3963@stusta.de> <20051124051405.GO3963@stusta.de> <1132819019.2832.23.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132819019.2832.23.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 08:56:59AM +0100, Arjan van de Ven wrote:
> On Thu, 2005-11-24 at 06:14 +0100, Adrian Bunk wrote:
> > On Wed, Nov 23, 2005 at 11:35:05PM +0100, Adrian Bunk wrote:
> > 
> > > Every inline dummy function should be static.
> > >...
> > 
> > Sorry, the patch was incomplete.
> 
> ok I was trying to avoid the ifdefs... if you add the ifdefs you might
> as well put the dummy in the header too in a #else clause.

Since it's not architecture specific, it should also move to a header 
under include/linux/.

Any suggestions which one to use?
My first thought was init.h, but this breaks compilation since this 
header is #include'd by assembler code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

