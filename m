Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263348AbTC0Rey>; Thu, 27 Mar 2003 12:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263347AbTC0Rex>; Thu, 27 Mar 2003 12:34:53 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29448 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263346AbTC0Rev>;
	Thu, 27 Mar 2003 12:34:51 -0500
Date: Thu, 27 Mar 2003 09:45:03 -0800
From: Greg KH <greg@kroah.com>
To: Patrick McHardy <kaber@trash.net>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Chris Sykes <chris@sigsegv.plus.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-ID: <20030327174503.GB32667@kroah.com>
References: <20030326162538.GG2695@spackhandychoptubes.co.uk> <20030326185236.GE24689@kroah.com> <20030326192520.GH2695@spackhandychoptubes.co.uk> <20030326193437.GI24689@kroah.com> <20030327111600.GI2695@spackhandychoptubes.co.uk> <20030327131214.1dae4005.skraw@ithnet.com> <3E82F00F.7@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E82F00F.7@trash.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 01:35:27PM +0100, Patrick McHardy wrote:
> diff -Nru a/drivers/isdn/isdn_net.c b/drivers/isdn/isdn_net.c
> --- a/drivers/isdn/isdn_net.c	Thu Mar 27 02:00:21 2003
> +++ b/drivers/isdn/isdn_net.c	Thu Mar 27 02:00:21 2003
> @@ -2831,6 +2831,7 @@
>  
>  			/* If binding is exclusive, try to grab the channel */
>  			save_flags(flags);
> +			cli();
>  			if ((i = isdn_get_free_channel(ISDN_USAGE_NET,
>  				lp->l2_proto, lp->l3_proto, drvidx,
>  				chidx, lp->msn)) < 0) {

I thought that cli() was being removed from the kernel, not added :)

This can not build on SMP, so you might want to change it.

thanks,

greg k-h
