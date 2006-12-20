Return-Path: <linux-kernel-owner+w=401wt.eu-S964902AbWLTGK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWLTGK2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 01:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWLTGK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 01:10:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:34514 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964902AbWLTGK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 01:10:26 -0500
Date: Tue, 19 Dec 2006 22:09:59 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Hans J. Koch" <hjk@linutronix.de>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [-mm patch] make uio_irq_handler() static
Message-ID: <20061220060959.GB31524@kroah.com>
References: <20061214225913.3338f677.akpm@osdl.org> <20061216135654.GB3388@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216135654.GB3388@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 02:56:54PM +0100, Adrian Bunk wrote:
> On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-mm1:
> >...
> > +gregkh-driver-uio-irq.patch
> > 
> >  driver tree updates
> >...
> 
> This patch makes the needlessly global uio_irq_handler() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.20-rc1-mm1/drivers/uio/uio_irq.c.old	2006-12-15 22:23:23.000000000 +0100
> +++ linux-2.6.20-rc1-mm1/drivers/uio/uio_irq.c	2006-12-15 22:33:40.000000000 +0100
> @@ -22,7 +22,7 @@
>  
>  static struct uio_device *uio_irq_idev;
>  
> -irqreturn_t uio_irq_handler(int irq, void *dev_id)
> +static irqreturn_t uio_irq_handler(int irq, void *dev_id)
>  {
>  	return IRQ_HANDLED;
>  }

Thanks, I've applied this to my tree.

greg k-h
