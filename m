Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWALRkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWALRkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWALRkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:40:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:32903 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932470AbWALRkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:40:11 -0500
Date: Thu, 12 Jan 2006 09:34:49 -0800
From: Greg KH <greg@kroah.com>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: "Mike D. Day" <ncmike@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
Message-ID: <20060112173449.GB10513@kroah.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <20060112071000.GA32418@kroah.com> <43C66B56.8030801@us.ibm.com> <43C67C7E.3070909@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C67C7E.3070909@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 09:57:50AM -0600, Anthony Liguori wrote:
> Here's a list of the remaining things we current expose in /proc/xen 
> that have no obvious place:
> 
> 1) capabilities (is the domain a management domain)

Is this just a single value or a bitfield?

> 2) xsd_mfn (a frame number for our bus so that userspace can connect to it)

Single number, right?

> 3) xsd_evtchn (a virtual IRQ for xen bus for userspace)

Again, single number?

> I would think these would most obviously go under something like:
> 
> /sys/hypervisor/xen/
> 
> That would introduce a hypervisor subsystem.  There are at least a few 
> hypervisors out there already so this isn't that bad of an idea 
> (although perhaps it may belong somewhere else in the hierarchy).  Greg?

I would have no problem with /sys/hypervisor/xen/ as long as you play by
the rest of the rules for sysfs (one value per file, no binary blobs
being intrepreted by the kernel, etc.)

thanks,

greg k-h
