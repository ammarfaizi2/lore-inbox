Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbTDNTlK (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbTDNTks (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:40:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52883 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263760AbTDNTkm (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:40:42 -0400
Date: Mon, 14 Apr 2003 12:54:38 -0700
From: Greg KH <greg@kroah.com>
To: oliver@neukum.name
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor
Message-ID: <20030414195438.GA4952@kroah.com>
References: <20030414190032.GA4459@kroah.com> <200304142116.45303.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304142116.45303.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 09:16:45PM +0200, Oliver Neukum wrote:
> 
> > Any objections or comments?  If not, I'll make the changes in the
> > linux-hotplug project and release a new version based on this.
> 
> Yes, consider what this does if you connect to a FibreChannel
> grid. You are pushing system load by at least an order of magnitude.

When you add a FibreChannel grid, the devices are discovered in
sequential order, with SCSI IO happening between each device discovered.
In talking to the SCSI people, that should be about 30ms per device
found at the quickest.  So there's no /sbin/hotplug process storm :)

And even if there is, we have to be able to handle such a load under
normal situations anyway :)

thanks,

greg k-h
