Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265472AbTFMSNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265475AbTFMSNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:13:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18870 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265472AbTFMSNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:13:14 -0400
Date: Fri, 13 Jun 2003 11:23:30 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613182330.GD6037@kroah.com>
References: <3EE8D038.7090600@mvista.com> <200306130027.09288.oliver@neukum.org> <3EE9F5C7.8070304@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE9F5C7.8070304@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 09:03:19AM -0700, Steven Dake wrote:
> >Aside from that, what exactly are you trying to do?
> >You are not solving the fundamental device node reuse race,
> >yet you are making necessary a further demon.
> > 
> >
> For device enumeration, I see a daemon as necessary.  The main goal of 
> this work is to solve the out-of-order execution of sbin/hotplug and 
> improve performance of the system during device enumeration with 
> significant (200 disks, 4 partitions each) amounts of devices.  Boot 
> time with this scheme appears, in my rudimentary tests, to be faster on 
> the order of 1-2 seconds for bootup for the case of just 12 disks.  I 
> would imagine 200 disks (which I don't have a good way to test, as I 
> don't have 200 disks:) would provide better speed gains during bootup.  
> This compares greg's original udev to this patched udev binary.

You're also using a 500k dynamically linked binary.  Please don't do
that for testing/real life.  Use the 6k udev binary for you tests...

thanks,

greg k-h
