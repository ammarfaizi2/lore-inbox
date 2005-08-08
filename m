Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVHIDRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVHIDRV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 23:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVHIDRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 23:17:21 -0400
Received: from cpe-24-93-207-102.neo.res.rr.com ([24.93.207.102]:10124 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S932432AbVHIDRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 23:17:20 -0400
Date: Mon, 8 Aug 2005 23:17:14 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>, Matthew Gilbert <mgilbert@mvista.com>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH] Custom IORESOURCE Class
Message-ID: <20050808231714.GB7276@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Greg KH <greg@kroah.com>, Matthew Gilbert <mgilbert@mvista.com>,
	rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <1123524705.7951.5.camel@localhost.localdomain> <20050808160021.GB7481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808160021.GB7481@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 09:00:21AM -0700, Greg KH wrote:
> On Mon, Aug 08, 2005 at 11:11:45AM -0700, Matthew Gilbert wrote:
> > Below is a patch that adds an additional resource class to the platform 
> > resource types. This is to support additional resources that need to be passed
> > to drivers without overloading the existing specific types. In my case, I need
> > to send clock information to the driver to enable power management. 
> > 
> > Signed-off-by: Matthew Gilbert <mgilbert@mvista.com>
> 
> Hm, you do realize that Pat's no longer the driver core maintainer?  :)
> 
> Anyway, Russell and Adam, any objections to this patch?

I'm not sure if I agree with this patch.  "struct resource" is used primarily for
I/O resource assignment.  Although I agree we may need to add new IORESOURCE types,
I'm not sure if clock data belongs here.  I don't think "start" and "end" would be
useful for most platform data.  Could you provide more information about this
specific issue and resource type?  Maybe we could create a new sysfs attribute?

Thanks,
Adam
