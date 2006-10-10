Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWJJXxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWJJXxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWJJXxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:53:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:675 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932279AbWJJXxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:53:16 -0400
From: Neil Brown <neilb@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Date: Wed, 11 Oct 2006 09:53:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17708.12903.712376.255113@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MD: conditionalize some code
In-Reply-To: message from Jeff Garzik on Tuesday October 10
References: <20061010231631.GA18222@havoc.gtf.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 10, jeff@garzik.org wrote:
> 
> The autorun code is only used if this module is built into the static
> kernel image.  Adjust #ifdefs accordingly.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

Acked-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

> 
> ---
> 
>  drivers/md/md.c               |    4 +++-
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 57fa64f..c75cdf9 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3368,6 +3368,7 @@ out:
>  	return err;
>  }
>  
> +#ifndef MODULE
>  static void autorun_array(mddev_t *mddev)
>  {
>  	mdk_rdev_t *rdev;
> @@ -3482,6 +3483,7 @@ static void autorun_devices(int part)
>  	}
>  	printk(KERN_INFO "md: ... autorun DONE.\n");
>  }
> +#endif /* !MODULE */
>  
>  static int get_version(void __user * arg)
>  {
> @@ -5592,7 +5594,7 @@ static void autostart_arrays(int part)
>  	autorun_devices(part);
>  }
>  
> -#endif
> +#endif /* !MODULE */
>  
>  static __exit void md_exit(void)
>  {
