Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVCAUJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVCAUJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVCAUJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:09:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262049AbVCAUJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:09:00 -0500
Date: Tue, 1 Mar 2005 21:08:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Telemaque Ndizihiwe <telendiz@eircom.net>
Cc: axboe@suse.de, Ingo.Wilken@informatik.uni-oldenburg.de,
       marcelo.tosatti@cyclades.com, torvalds@osdl.org, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removes unnecessary if statement from /drivers/block/z2ram.c
Message-ID: <20050301200858.GE4845@stusta.de>
References: <Pine.LNX.4.62.0503011907001.5142@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503011907001.5142@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 07:27:27PM +0000, Telemaque Ndizihiwe wrote:
> 
> This Patch removes unnecessary if statement from a function that has no 
> implementation (in kernel 2.6.x and 2.4.x); the function returns 0 with 
> or without the if statement:
> 
> 	static int z2_release(struct inode *inode, struct file *filp)
> 	{
> 		if(current_device==-1)
> 			return 0;
> 
> 		return 0;
> 	}
> 
> 
> Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>
> 
> 
> --- linux-2.6.10/drivers/block/z2ram.c.orig	2005-02-23 
> 18:02:51.011967584 +0000
> +++ linux-2.6.10/drivers/block/z2ram.c	2005-02-23 18:05:31.617551824 +0000
> @@ -304,9 +304,6 @@ err_out:
>  static int
>  z2_release( struct inode *inode, struct file *filp )
>  {
> -    if ( current_device == -1 )
> -	return 0; 
> -
>      /*
>       * FIXME: unmap memory
>       */

For what gain?

The real issue is that this function isn't really implemented.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

