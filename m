Return-Path: <linux-kernel-owner+w=401wt.eu-S1751698AbXAQVeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbXAQVeL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbXAQVeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:34:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:39493 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbXAQVeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:34:10 -0500
Date: Wed, 17 Jan 2007 13:33:18 -0800
From: Greg KH <greg@kroah.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Brainard, Jim" <jim.brainard@hp.com>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>
Subject: Re: PME_Turn_Off in Linux
Message-ID: <20070117213318.GA2525@kroah.com>
References: <E717642AF17E744CA95C070CA815AE550116B7C8@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E717642AF17E744CA95C070CA815AE550116B7C8@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 10:43:14AM -0600, Miller, Mike (OS Dev) wrote:
> Hello,
> We've been seeing some nasty data corruption issues on some platforms.
> We've been capturing PCI-E traces looking for something nasty but we
> haven't found anything yet. One of the hardware guys if asking if there
> is a call in Linux to issue a PME_Turn_Off broadcast message.
>  
> PME_Turn_Off Broadcast Message
> Before main component power and reference clocks are turned off, the
> Root Complex or Switch Downstream Port must issue a broadcast Message
> that instructs all agents downstream of that point within the hierarchy
> to cease initiation of any subsequent PM_PME Messages, effective
> immediately upon receipt of the PME_Turn_Off Message.
> 
> This must be initiated from the root complex. Is there such a call in
> linux?

This firmware that implements the PCI-E connection should do this, I
don't think there is anything that the Operating system can do to
control this, as PCI-E should be transparant to the OS.

Unless this is on a PCI-E Hotplug system?  What is the sequence of
events that cause the data corruption?

thanks,

greg k-h
