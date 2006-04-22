Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWDVSpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWDVSpv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWDVSpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:45:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:63151 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750837AbWDVSpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:45:50 -0400
Date: Sat, 22 Apr 2006 16:50:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422145000.GF5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422093328.GM19754@stusta.de> <1145707384.16166.181.camel@shinybook.infradead.org> <20060422141410.GA25926@mars.ravnborg.org> <20060422142043.GD5010@stusta.de> <20060422142853.GB25926@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060422142853.GB25926@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 04:28:53PM +0200, Sam Ravnborg wrote:
> > >...
> > 
> > What exactly is the problem with creating the userspace ABI in 
> > include/kabi/ and letting distributions do an
> >   cd /usr/include && ln -s kabi/* .
> > ?
> > 
> > Or with creating the userspace ABI in include/kabi/ and letting 
> > distributions install the subdirs of include/kabi/ directly under 
> > /usr/include?
> > 
> > These are two doable approaches with a new kabi/ that avoid needless 
> > breaking of userspace.
> 
> First off:
> There are many other users that poke direct in the kernel source also.

Kernel space users?
User space users?

Can you give an example of what you are thinking of?

> Secondly and more importantly:
> Introducing kabi/ you will have a half solution where several users will
> have to find their stuff in two places for a longer period.
> kabi/ does not allow you to do it incrementally - it requires you to
> move everything over from a start.
> You may argue that you can just move over a little bit mroe than needed
> but then we ruin the incremental approach.

For kernel space, you can do it incrementally, since the whole kabi/ 
stuff should be transparent for in-kernel uses.

For user space, you need one switch.
But this switch goes from the current mess with several independent 
user space header implementations to one official implementation.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

