Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265441AbTFMQa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbTFMQ3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:29:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6139 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265435AbTFMQ2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:28:54 -0400
Date: Fri, 13 Jun 2003 09:32:27 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613163226.GA5799@kroah.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <1055493636.5163.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055493636.5163.8.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 09:40:37AM +0100, Alan Cox wrote:
> On Iau, 2003-06-12 at 23:03, Andrew Morton wrote:
> > This is a significantly crappy aspect of the /sbin/hotplug callout.  I'd be
> > very interested in reading an outline of how you propose fixing it, without
> > waiting until OLS, thanks.
> 
> Dave Miller posted a simple patch to allow netlink to be used for
> kernel->user messages - hotplug/disk error/logging/whatever. I'm
> suprised therefore that the whole thing is being regurgitated again.

For error logging stuff I think the netlink interface is fine.  And I'm
pretty sure some of the IBM RAS people are looking into useing it.

But as a hotplug interface, no, I do not want to change to using it.
The bash /sbin/hotplug plugin writers would hate me...  :)

thanks,

greg k-h
