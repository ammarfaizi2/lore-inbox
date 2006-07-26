Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWGZH3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWGZH3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGZH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:29:04 -0400
Received: from mail.suse.de ([195.135.220.2]:15760 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932368AbWGZH3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:29:03 -0400
Date: Wed, 26 Jul 2006 00:24:52 -0700
From: Greg KH <gregkh@suse.de>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726072452.GB6249@suse.de>
References: <20060725203028.GA1270@kroah.com> <44C69819.8080908@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C69819.8080908@superbug.co.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 11:15:53PM +0100, James Courtier-Dutton wrote:
> Greg KH wrote:
> > During the kernel summit, I was reminded by the wish by some people to
> > do device probing in parallel, so I created the following patch.  It
> > offers up the ability for the driver core to create a new thread for
> > every driver<->device probe call.  To enable this, the driver needs to
> > have the multithread_probe flag set to 1, otherwise the "traditional"
> > sequencial probe happens.
> 
> What happens about the logging?

Nothing, it works just fine.  A little messy perhaps, but it's all
there.  I don't see the problem here...

> Surely one would want the output from one probe to be output into the
> log as a block, and not mix the output from multiple simultaneous probes.

Why not?  Each subsystem already uses the dev_printk() for the most part
for their logging messages, so it's easy to figure out what is going on.

thanks,

greg k-h
