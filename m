Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422980AbWJTVlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422980AbWJTVlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992746AbWJTVlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:41:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19720 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422980AbWJTVlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:41:03 -0400
Date: Fri, 20 Oct 2006 23:41:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more helpful WARN_ON and BUG_ON messages
Message-ID: <20061020214101.GX3502@stusta.de>
References: <4538F81A.2070007@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4538F81A.2070007@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 11:23:54AM -0500, Eric Sandeen wrote:
> After a few bugs I encountered in FC6 in buffer.c, with output like:
> 
> Kernel BUG at fs/buffer.c: 2791
> 
> where buffer.c contains:
> 
> ...
>         BUG_ON(!buffer_locked(bh));
>         BUG_ON(!buffer_mapped(bh));
>         BUG_ON(!bh->b_end_io);
> ...
> 
> around line 2790, it's awfully tedious to go get the exact failing kernel tree
> just to see -which- BUG_ON was encountered.
> 
> Printing out the failing condition as a string would make this more helpful IMHO.
> 
> This is mostly just compile-tested... comments?
>...

Who really needs this considering it implies a size increase of the 
kernel image?

Using a kernel tree so unusual that you can't locate the source anymore 
sounds like an extremely rare and unintelligent situation, not something 
that must be handled.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

