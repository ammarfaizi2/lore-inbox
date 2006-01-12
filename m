Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbWALTbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbWALTbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWALTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:31:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:63666 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161207AbWALTbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:31:41 -0500
Date: Thu, 12 Jan 2006 11:31:21 -0800
From: Greg KH <greg@kroah.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Gerd Hoffmann <kraxel@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112193121.GB13539@kroah.com>
References: <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de> <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de> <20060112173926.GD10513@kroah.com> <43C6A5B4.80801@us.ibm.com> <1137092120.2936.55.camel@laptopd505.fenrus.org> <43C6A70D.8010902@us.ibm.com> <43C6A9CE.9080105@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C6A9CE.9080105@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 02:11:10PM -0500, Mike D. Day wrote:
> Anthony Liguori wrote:
> >Arjan van de Ven wrote:
> >
> >>On Thu, 2006-01-12 at 12:53 -0600, Anthony Liguori wrote:
> >> 
> >>
> >>>We wish to make management hypercalls as the root user in userspace 
> >>>which means we have to go through the kernel.  Currently, we do this
> >>>by having /proc/xen/privcmd accept an ioctl() that takes a structure
> >>>that describe the register arguments.  The kernel interface allows us 
> >>>to control who in userspace can execute hypercalls.
> >>>  
> >>
> >>ioctls on proc is evil though (so is ioctl-on-sysfs). It's a device not
> >>a proc file!
> >> 
> >>
> >I full heartedly agree with you :-)
> 
> What about making hypercalls via with a read/write interface into memory 
> mapped by a char device? Any problems with that approach?

Yes, just make it a syscall as our other sub-thread details.

thanks,

greg k-h
