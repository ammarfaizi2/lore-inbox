Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWCMSKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWCMSKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWCMSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:10:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45324 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932278AbWCMSK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:10:27 -0500
Date: Mon, 13 Mar 2006 19:10:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>, rjwalsh@pathscale.com
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
Message-ID: <20060313181025.GA13973@stusta.de>
References: <patchbomb.1141950930@eng-12.pathscale.com> <867a396dd518ac63ab41.1141950948@eng-12.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867a396dd518ac63ab41.1141950948@eng-12.pathscale.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 04:35:48PM -0800, Bryan O'Sullivan wrote:
>...
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/drivers/infiniband/hw/ipath/Makefile	Thu Mar  9 16:17:00 2006 -0800
> @@ -0,0 +1,42 @@
> +EXTRA_CFLAGS += -O3

I'm still a bit surprised, since in the rest of the kernel we are even 
going from -O2 to -Os for getting better performance.

Robert said he wanted to post some numbers showing that -O3 is 
measurably better for you [1], but I haven't seen them.

> +_ipath_idstr:="PathScale $(shell date +%F)"
> +EXTRA_CFLAGS += -DIPATH_IDSTR='$(_ipath_idstr)' -DIPATH_KERN_TYPE=0
>...

UTS_VERSION is already available and printed at the top of dmesg.
I don't see the point in printing it a second time.

cu
Adrian

[1] http://lkml.org/lkml/2005/12/17/115

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

