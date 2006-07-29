Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWG2TTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWG2TTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbWG2TTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:19:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36882 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751420AbWG2TTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:19:38 -0400
Date: Sat, 29 Jul 2006 21:19:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Message-ID: <20060729191938.GH26963@stusta.de>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <200607292050.37877.ak@suse.de> <20060729185737.GG26963@stusta.de> <200607292104.18030.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607292104.18030.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 09:04:18PM +0200, Andi Kleen wrote:
> 
> > > It should be obsolete with autoprobing for the feature as earlier discussed.
> > 
> > That's not the point of the version information in the help text.
> 
> The point in the current option is to select or not select it - 
> if the user gets it wrong it won't compile or worse miscompile.

That was never true in Arjan's patches.

The only change is from a gcc version check to a feature check.

In both cases, a gcc 4.1 without the appropriate patch applied will 
result in this option not being set.

> Once it is auto selected the user could be still informed about 
> it, but it doesn't matter much anymore (we don't inform the user
> about every possible trade off based on compiler version everywhere)

If an option might possible have zero effect, we do always inform the 
user. If not, please tell me which options this are so we can fix them.

We don't inform users about internal compiler version dependent things 
like -fno-unit-at-a-time on i386 with neither a config option nor any 
user visible effect (except for kernel size and speed).

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

