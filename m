Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031619AbWLAQyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031619AbWLAQyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031620AbWLAQyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:54:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32778 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031619AbWLAQyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:54:22 -0500
Date: Fri, 1 Dec 2006 17:54:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Andrew Morton <akpm@osdl.org>, matthew@wil.cx, kyle@parisc-linux.org,
       parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] parisc: "extern inline" -> "static inline" (fwd)
Message-ID: <20061201165427.GD11084@stusta.de>
References: <20061201114811.GQ11084@stusta.de> <20061201164354.GA10549@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201164354.GA10549@colo.lackof.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 09:43:54AM -0700, Grant Grundler wrote:
> On Fri, Dec 01, 2006 at 12:48:11PM +0100, Adrian Bunk wrote:
> > "extern inline" generates a warning with -Wmissing-prototypes and I'm 
> > currently working on getting the kernel cleaned up for adding this to 
> > the CFLAGS since it will help us to avoid a nasty class of runtime 
> > errors.
> 
> 
> John David Anglin is the hppa/parisc gcc maintainer and has
> commented on inline variants last year:
>     http://lists.parisc-linux.org/pipermail/parisc-linux/2005-October/027587.html
> 
> This makes me think -Wmissing-prototypes is reporting the wrong warning.
> ie there is a prototype but no function and no label.
> Can you check with gcc folks to see if this is a gcc bug?
> 
> The parisc point intentionally switched to "extern inline" at one
> point and unless what jda wrote is now incorrect, I'm not inclined
> to change it.

If you read John David Anglin's email, you'll note that if you take the 
address you need this function provided somewhere.

Which of the functions my patch changes also have a global function 
provided within the kernel?

If none, "extern inline" didn't make any sense.

> > If there are places that really need a forced inline, __always_inline 
> > would be the correct solution.
> 
> Yes, all the functions marked "extern inline" are expected to get
> essentially the same treatment as "always_inline".

Currently, "inline" is defined to be always_inline, and 
__always_inline is for cases that produce non-compiling or non-working 
(opposed to only suboptimal) code.

> thanks,
> grant

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

