Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161341AbWFVUjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161341AbWFVUjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbWFVUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:39:13 -0400
Received: from mx1.suse.de ([195.135.220.2]:28572 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161341AbWFVUjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:39:12 -0400
Date: Thu, 22 Jun 2006 13:35:59 -0700
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: i2c@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [i2c] [PATCH] I2C bus driver for Philips ARM boards
Message-ID: <20060622203559.GA14445@kroah.com>
References: <20060622153146.2ae56e33.vitalywool@gmail.com> <20060622183955.GA6372@kroah.com> <acd2a5930606221317w6432aefcsf4569fca3b59ebcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd2a5930606221317w6432aefcsf4569fca3b59ebcd@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 12:17:55AM +0400, Vitaly Wool wrote:
> On 6/22/06, Greg KH <greg@kroah.com> wrote:
> >
> >> +static inline int i2c_pnx_bus_busy(volatile struct i2c_regs *master)
> >> +{
> >> +     long timeout;
> >> +
> >> +     timeout = TIMEOUT * 10000;
> >> +     if (timeout > 0 && (master->sts & mstatus_active)) {
> >
> >A big hint about this, if you have volatile in your driver, it's
> >wrong...
> 
> 
> Well, I do remember flames on the subject... Still __raw_readl also uses
> volatile.
> Anyway, I can't disagree that ioreadX-based register access are better.
> Greg, is there anything else I should take care of before re-sending the
> patch, except for the things that you and Ben pointed out?

Not that I can think of, that would be a good starting point :)

thanks,

greg k-h
