Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTFTSWH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264088AbTFTSWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:22:07 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:50419 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264087AbTFTSWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:22:04 -0400
Date: Fri, 20 Jun 2003 11:35:44 -0700
From: Greg KH <greg@kroah.com>
To: Albert Cahalan <albert.cahalan@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI changes and fixes for 2.5.72
Message-ID: <20030620183544.GA12561@kroah.com>
References: <1056123842.986.60.camel@albertc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056123842.986.60.camel@albertc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 11:44:02AM -0400, Albert Cahalan wrote:
> Greg writes:
> 
> > [PATCH] PCI: Unconfuse /proc
> >
> > If we are to cope with multiple domains with clashing PCI bus
> > numbers, we must refrain from creating two directories of the
> > same name in /proc/bus/pci.  This is one solution to the
> > problem; busses with a non-zero domain number get it prepended.
> >
> > Alternative solutions include cowardly refusing to create
> > non-domain-zero bus directories, refusing to create directories
> > with clashing names, and sticking our heads in the sand and
> > pretending the problem doesn't exist.
> 
> Please don't do this. It's gross. As long as we have
> the bus number mangling, stuff can stay as it is.
> When the bus number mangling goes, the old-style
> entries can go as well. I'm working on a patch that
> makes the old-style entries be symlinks like this:
> 
> ../../pci%d/bus%d/dev%d/fn%d/config-space

Symlinks from what to that new file?  Have the result from 'tree' to
show what you are considering?

And until we have such a change, the patch from Matthew is needed, so it
should stay.

thanks,

greg k-h
