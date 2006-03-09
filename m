Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752072AbWCIXqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbWCIXqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbWCIXqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:46:30 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:52609
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1752072AbWCIXq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:46:29 -0500
Date: Thu, 9 Mar 2006 15:46:07 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, rolandd@cisco.com, gregkh@suse.de,
       akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
Message-ID: <20060309234607.GA26898@kroah.com>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain> <adapskvfbqe.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adapskvfbqe.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 03:18:49PM -0800, Roland Dreier wrote:

Thanks for CC:ing me, but where were the originals of these posted?

>  > +static ssize_t show_version(struct device_driver *dev, char *buf)
>  > +{
>  > +	return scnprintf(buf, PAGE_SIZE, "%s", ipath_core_version);
>  > +}
> 
> Any reason you left a "\n" off of this attribute?
> 
>  > +static ssize_t show_atomic_stats(struct device_driver *dev, char *buf)
>  > +{
>  > +	memcpy(buf, &ipath_stats, sizeof(ipath_stats));
>  > +
>  > +	return sizeof(ipath_stats);
>  > +}
> 
> I think putting a whole binary struct in a sysfs attribute is
> considered a no-no.

That's an understatement, where is the large stick to thwap the author
of this code...

thanks,

greg k-h
