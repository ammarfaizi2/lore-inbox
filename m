Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWFFGxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFFGxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 02:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWFFGxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 02:53:05 -0400
Received: from ns.suse.de ([195.135.220.2]:28558 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750713AbWFFGxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 02:53:03 -0400
Date: Mon, 5 Jun 2006 23:50:16 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
       netdev@vger.kernel.org, mb@bu3sch.de, st3@riseup.net,
       linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
Message-ID: <20060606065016.GB16832@suse.de>
References: <2005123213211@nnikde.cz> <20060605202007.B464FC7B73@atrey.karlin.mff.cuni.cz> <20060605205309.GA31061@kroah.com> <20060606011818.GA4135@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606011818.GA4135@havoc.gtf.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 09:18:18PM -0400, Jeff Garzik wrote:
> On Mon, Jun 05, 2006 at 01:53:09PM -0700, Greg KH wrote:
> > Why not just use the proper pci interface?  Why poke around in another
> > pci device to steal an irq, when that irq might not even be valid?
> > (irqs are not valid until pci_enable_device() is called on them...)
> 
> Answered this question the last time you asked.
> 
> Answer:  this is an embedded platform that needs such poking.  The
> wireless device is _another_ device.

Ugh, sorry, too many patches, too many different threads...  You are
right...

greg k-h
