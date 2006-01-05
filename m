Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWAEPfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWAEPfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWAEPfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:35:39 -0500
Received: from tim.rpsys.net ([194.106.48.114]:14310 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932083AbWAEPfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:35:38 -0500
Subject: Re: [CFT 7/29] Add locomo bus_type probe/remove methods
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg K-H <greg@kroah.com>
In-Reply-To: <20060105142951.13.07@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
	 <20060105142951.13.07@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 15:35:22 +0000
Message-Id: <1136475323.6451.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

but no changelog entry?

On Thu, 2006-01-05 at 14:33 +0000, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> ---
>  arch/arm/common/locomo.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej
> -x .git linus/arch/arm/common/locomo.c linux/arch/arm/common/locomo.c
> --- linus/arch/arm/common/locomo.c      Fri Nov 11 21:20:00 2005
> +++ linux/arch/arm/common/locomo.c      Sun Nov 13 15:56:31 2005
> @@ -1103,14 +1103,14 @@ static int locomo_bus_remove(struct devi
>  struct bus_type locomo_bus_type = {
>         .name           = "locomo-bus",
>         .match          = locomo_match,
> +       .probe          = locomo_bus_probe,
> +       .remove         = locomo_bus_remove,
>         .suspend        = locomo_bus_suspend,
>         .resume         = locomo_bus_resume,
>  };
>  
>  int locomo_driver_register(struct locomo_driver *driver)
>  {
> -       driver->drv.probe = locomo_bus_probe;
> -       driver->drv.remove = locomo_bus_remove;
>         driver->drv.bus = &locomo_bus_type;
>         return driver_register(&driver->drv);
>  }
> 
> 

