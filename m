Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265287AbSJXA0B>; Wed, 23 Oct 2002 20:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265288AbSJXA0B>; Wed, 23 Oct 2002 20:26:01 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7439 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265287AbSJXA0A>;
	Wed, 23 Oct 2002 20:26:00 -0400
Date: Wed, 23 Oct 2002 17:30:43 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorquk.ukuu.org.uk
Subject: Re: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel 2.5.44
Message-ID: <20021024003043.GJ17413@kroah.com>
References: <3DB7304A.3030903@mvista.com> <20021024001818.GH17413@kroah.com> <3DB73E2A.5090001@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB73E2A.5090001@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 05:26:18PM -0700, Steven Dake wrote:
> I'm not sure how driverfs would be used by this particular patch.  Could 
> you be more specific in stating how this could be used?

Your "driver" needs only 6 or so files to work properly, right?  Why not
just create those files under /sys/bus/scsi/ somewhere?  That way you
don't have to create your own fs, and only have to provide read and
write functions for those files, which would be much smaller.

pcihpfs is moving under driverfs soon, once I get some spare cycles.

> >I really like this, a user friendly kernel interface :)
> >
> Think this looks good for inclusion in 2.5.45?

I'll let the scsi people make that call, I don't know the scsi layer at
all (and don't really want to...)

thanks,

greg k-h
