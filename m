Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWE3RAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWE3RAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWE3RAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:00:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:15053 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932331AbWE3RAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:00:42 -0400
Date: Tue, 30 May 2006 09:58:15 -0700
From: Greg KH <gregkh@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: searching for pci busses
Message-ID: <20060530165815.GA7544@suse.de>
References: <4478DCF1.8080608@gmail.com> <20060529214753.GD10875@kroah.com> <447B6ECB.9080207@pobox.com> <20060530163821.GC7146@suse.de> <9e4733910605300952v1cf56beasc2a907cc77b8a09f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605300952v1cf56beasc2a907cc77b8a09f@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 12:52:31PM -0400, Jon Smirl wrote:
> On 5/30/06, Greg KH <gregkh@suse.de> wrote:
> >On Mon, May 29, 2006 at 05:59:39PM -0400, Jeff Garzik wrote:
> >> Greg KH wrote:
> >> >On Sun, May 28, 2006 at 01:12:26AM +0159, Jiri Slaby wrote:
> >> >>Hello,
> >> >>
> >> >>I want to ask, if there is any function to call (as we debated with
> >> >>Jeff), which
> >> >>does something like this:
> >> >>1) I have some vendor/device ids in table
> >> >>2) I want to traverse raws of the table and compare to system devices,
> >> >>and if
> >> >>found, stop and return pci_dev struct (or raw in the table).
> >> >
> >> >What's wrong with pci_match_id()?
> >> >
> >> >Or just using the pci_register_driver() function properly, which handles
> >> >all of this logic for you?
> >>
> >> These aren't PCI devices proper.  These are embedded non-PCI devices,
> >> which must search for an unrelated PCI device to figure out what type of
> >> platform they are on.
> >
> >Ok, then use pci_match_id() or pci_get_device().
> 
> This is how DRM does it...

6 words that should never be uttered as a reason to justify anything...

thanks,

greg k-h
