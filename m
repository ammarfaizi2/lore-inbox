Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129856AbRBYWp4>; Sun, 25 Feb 2001 17:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129865AbRBYWpp>; Sun, 25 Feb 2001 17:45:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3601 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129856AbRBYWpe>;
	Sun, 25 Feb 2001 17:45:34 -0500
Date: Sun, 25 Feb 2001 22:39:13 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: torvalds@transmeta.com, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Message-ID: <20010225223913.A3627@flint.arm.linux.org.uk>
In-Reply-To: <200102251957.TAA01718@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102251957.TAA01718@gw.chygwyn.com>; from steve@gw.chygwyn.com on Sun, Feb 25, 2001 at 07:57:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 07:57:29PM +0000, Steve Whitehouse wrote:
> -int nbd_init(void)
> +int __init nbd_init(void)

> -void cleanup_module(void)
> +void __exit nbd_cleanup(void)

> +
> +module_init(nbd_init);
> +module_exit(nbd_cleanup);

If you're using module_init/module_exit, shouldn't nbd_init/nbd_cleanup
be declared statically?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
