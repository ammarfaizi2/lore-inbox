Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbSIXFyG>; Tue, 24 Sep 2002 01:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261577AbSIXFyF>; Tue, 24 Sep 2002 01:54:05 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:10245 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261576AbSIXFyF>;
	Tue, 24 Sep 2002 01:54:05 -0400
Date: Mon, 23 Sep 2002 22:58:15 -0700
From: Greg KH <greg@kroah.com>
To: Larry Kessler <kessler@us.ibm.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
Message-ID: <20020924055814.GA21931@kroah.com>
References: <3D8FC601.80BAC684@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8FC601.80BAC684@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One further comment:

On Mon, Sep 23, 2002 at 06:55:13PM -0700, Larry Kessler wrote:
> --- linux-2.5.37/drivers/include/linux/net_problem.h	Wed Dec 31 18:00:00 1969
> +++ linux-2.5.37-net/include/linux/net_problem.h	Mon Sep 23 20:04:23 2002


> --- linux-2.5.37/drivers/include/linux/pci_problem.h	Wed Dec 31 18:00:00 1969
> +++ linux-2.5.37-net/include/linux/pci_problem.h	Mon Sep 23 19:56:11 2002

{sigh}

Have people been ignoring all of the core driver changes that have been
happening?  Almost everything that is "struct device" now, with some bus
specific things tacked on (and those bus specific things are getting
slowly merged into struct device too.)

It would make more sense (if you continue this path of changes to the
kernel) to focus on the device, bus, and class structures.  That way you
don't have to create a usb_problem.h, iee1394_problem.h, i2c_problem.h,
i2o_problem.h, scsi_problem.h, ide_problem.h, etc.

thanks,

greg k-h
