Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbVJRXoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbVJRXoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVJRXoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:44:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4114 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751476AbVJRXoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:44:23 -0400
Date: Wed, 19 Oct 2005 01:44:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arthur Othieno <a.othieno@bluewin.ch>
Cc: Ben Dooks <ben@fluff.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - create common header for init/main.c called init functions
Message-ID: <20051018234422.GC3860@stusta.de>
References: <20051014004210.GA3095@home.fluff.org> <20051018231109.GA15443@krypton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018231109.GA15443@krypton>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 07:11:09PM -0400, Arthur Othieno wrote:
> On Fri, Oct 14, 2005 at 01:42:10AM +0100, Ben Dooks wrote:
> > init/main.c calls a number of functions externally
> > but declaring them locally. This patch creates a
> > new header (linux/kernel_init.h) and moves all
> > the declarations into it.
> 
> These functions are only referenced in init/main.c, and rightfully so.
> In the end, this doesn't change anything much, other than maintainance
> overhead for the new include/linux/kernel_init.h
>...

I disagree.

Without having looked deeper at the details of this specific patch, it's 
generally a good cleanup to move function declarations to header files.

This avoids the nasty class of runtime errors we sometimes get when 
someone changes the prototype of a function but forgets to update all 
the prototypes floating around in .c files.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

