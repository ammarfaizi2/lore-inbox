Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVASESB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVASESB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 23:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVASESB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 23:18:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58126 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261557AbVASERl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 23:17:41 -0500
Date: Wed, 19 Jan 2005 05:17:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Steve Snyder <swsnyder@insightbb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Testing optimize-for-size suitability?
Message-ID: <20050119041739.GI1841@stusta.de>
References: <200501161040.12907.swsnyder@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501161040.12907.swsnyder@insightbb.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 10:40:12AM -0500, Steve Snyder wrote:
> Is there a benchmark or set of benchmarks that would allow me to test the 
> suitability of the CONFIG_CC_OPTIMIZE_FOR_SIZE kernel config option?
> 
> It seems to me that the benefit of this option is very dependant on the 
> amount of CPU cache installed, with the compiler code generation being a 
> secondary factor.  The use, or not, of CONFIG_CC_OPTIMIZE_FOR_SIZE is 
> basically an act of faith without knowing how it impacts my particular 
> environment.
> 
> I've got a Pentium4 CPU with 512KB of L2 cache, and I'm using GCC v3.3.3.  
> How can I determine whether or not CONFIG_CC_OPTIMIZE_FOR_SIZE should be 
> used for my system?
> 
> Thanks.

In theory, -O2 should produce faster code.

In practice, I don't know about any recent benchmarks comparing -Os/-O2 
kernels.

In practice, I doubt it would make any noticable difference if the 
kernel might be faster by let's say 1% with one option compared to the 
other one.

The main disadvantage of -Os is that it's much less tested for kernel 
compilations, and therefore miscompilations are slightly more likely.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

