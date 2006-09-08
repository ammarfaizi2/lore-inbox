Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWIHWBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWIHWBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWIHWBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:01:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:2208 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751126AbWIHWBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:01:39 -0400
Date: Fri, 8 Sep 2006 15:01:29 -0700
From: Greg KH <greg@kroah.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Thomas Maier <balagi@justmail.de>, linux-kernel@vger.kernel.org,
       "petero2@telia.com" <petero2@telia.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Message-ID: <20060908220129.GB20018@kroah.com>
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com> <4501E33B.50204@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4501E33B.50204@cfl.rr.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 05:40:11PM -0400, Phillip Susi wrote:
> Greg KH wrote:
> >On Fri, Sep 08, 2006 at 07:55:08PM +0200, Thomas Maier wrote:
> >>+/sys/block/pktcdvd/<pktdevname>/packet/
> >>+    statistic         (r)  Show device statistic. One line with
> >>+                           5 values in following order:
> >>+                              packets-started
> >>+                              packets-end
> >>+                              written in kB
> >>+                              read gather in kB
> >>+                              read in kB
> >
> >Please no.  One value per file is the sysfs rule.
> >
> 
> Except in cases like this where you want to read the status of the 
> device at a given point in time, and you can't do that unless you grab 
> all the values at once.

Then don't use sysfs for that.  And is something like this as critical
to get that kind of information all in one atomic chunk?  It seems
merely to be informational.

thanks,

greg k-h
