Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVH1XhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVH1XhU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 19:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVH1XhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 19:37:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58628 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750951AbVH1XhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 19:37:19 -0400
Date: Mon, 29 Aug 2005 01:37:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is kmem_bufctl_t different across platforms?
Message-ID: <20050828233716.GB3820@stusta.de>
References: <3B0AEB5C-4A65-413F-BD35-B9F0E0984653@mac.com> <20050828145503.7b1a5f71.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050828145503.7b1a5f71.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 at 02:55:03PM -0700, Andrew Morton wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
> >
> > While exploring the asm-*/types.h files, I discovered that the
> >  type "kmem_bufctl_t" is differently defined across each platform,
> >  sometimes as a short, and sometimes as an int.  The only file
> >  where it's used is mm/slab.c, and as far as I can tell, that file
> >  doesn't care at all, aside from preferring it to be a small-sized
> >  type.
> 
> I don't think there's any good reason for this.  -mm's
> slab-leak-detector.patch switches them all to unsigned long.

What about moving it to include/linux/types.h ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

