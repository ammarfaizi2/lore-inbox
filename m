Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWAFSZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWAFSZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWAFSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:25:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36109 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964828AbWAFSZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:25:52 -0500
Date: Fri, 6 Jan 2006 19:25:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Arjan van de Ven <arjan@infradead.org>,
       hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>, John Hesterberg <jh@sgi.com>,
       Greg Edwards <edwardsg@sgi.com>
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
Message-ID: <20060106182546.GX12131@stusta.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 09:45:20AM -0800, Luck, Tony wrote:
> >Why can't we keep the default below 64?  Surely the 0.1% of the market
> >which needs more than 64 cpus can recompile their kernel ...
> 
> I suppose that depends on your expectations from defconfig.  In my
> mind its the one that builds into a kernel that will boot and run
> on just about any box.  People who want to get a bit of extra performance
> will do the re-compilation to strip out the bits that they don't want
> and tune down limits that are set higher than they need.  I only
> ever boot a defconfig kernel to check that it still works, my systems
> all run tiger_defconfig/zx1_defconfig based most of the time.  But
> perhaps I'm the weird one?
>...

defconfig's are usually not intended for running on all supported 
machines, they are more a base for compile-tests and a starting point 
for building an own configuration.

If you intend to use the ia64 defconfig in a different way I don't 
see any strong point against it.

But if you seriously want a defconfig "that builds into a kernel that 
will boot and run on just about any box", please change your defconfig 
to ITANIUM=y,MCKINLEY=n. "People who want to get a bit of extra 
performance" can still change their configuration to omit support for 
the original Itanium.

> -Tony

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

