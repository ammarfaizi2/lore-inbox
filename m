Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVH3Qsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVH3Qsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVH3Qsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:48:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18956 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932220AbVH3Qsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:48:52 -0400
Date: Tue, 30 Aug 2005 18:48:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050830164851.GC7071@stusta.de>
References: <20050830145444.GC3708@stusta.de> <20050830161814.GA31940@suse.de> <20050830162944.GB7071@stusta.de> <20050830163819.GA32201@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830163819.GA32201@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 06:38:19PM +0200, Olaf Hering wrote:
> 
> page_cache_release and release_pages will be undefined when compiling
> arch/ppc/configs/common_defconfig, but not arch/i386/defconfig, with
> CONFIG_SWAP=n

There will be some compile errors in cases where compilation previously 
worked because the undefined function wasn't called due to gcc dead code 
elimination.

We need to fix some code, but I'd strongly prefer this over the possible 
runtime errors -Werror-implicit-function-declaration prevents in other 
cases.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

