Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283073AbRK2Hl1>; Thu, 29 Nov 2001 02:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283084AbRK2HlH>; Thu, 29 Nov 2001 02:41:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14343 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283073AbRK2HlC>;
	Thu, 29 Nov 2001 02:41:02 -0500
Date: Thu, 29 Nov 2001 08:40:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for drivers/char/pc_keyb.c in 2.5.1-pre3
Message-ID: <20011129084039.D5788@suse.de>
In-Reply-To: <20011128163810.C2512@kroah.com> <E169FUY-0006k8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E169FUY-0006k8-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Alan Cox wrote:
> > Here's a patch for 2.5.1-pre3 to fix the compile time problems in
> > drivers/char/pc_keyb.c.  It also fixes the places where the flags
> > variable is the wrong type.
> 
> This is the diff I'm using. It

> @@ -1052,14 +1052,14 @@
>  
>  static int release_aux(struct inode * inode, struct file * file)
>  {
> -	int flags;
> +	unsigned long flags;
>  	fasync_aux(-1, file, 0);
> -	spin_lock_irqsave( &aux_count, flags );
> +	spin_lock_irqsave(&aux_count, flags);

s/aux_count/aux_count_lock typo

-- 
Jens Axboe

