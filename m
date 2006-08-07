Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWHGR51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWHGR51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWHGR51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:57:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:40122 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750825AbWHGR5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:57:25 -0400
Date: Mon, 7 Aug 2006 10:56:42 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Renninger <trenn@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
Subject: Re: Options depending on STANDALONE
Message-ID: <20060807175642.GA8201@kroah.com>
References: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com> <1154972011.4302.712.camel@queen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154972011.4302.712.camel@queen.suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 07:33:31PM +0200, Thomas Renninger wrote:
> On Thu, 2006-08-03 at 16:49 -0400, Brown, Len wrote:
> > >On Thu, Aug 03, 2006 at 10:25:43PM +0200, Adrian Bunk wrote:
> > >> ACPI_CUSTOM_DSDT seems to be the most interesting case.
> > >> It's anyway not usable for distribution kernels, and AFAIR the ACPI 
> > >> people prefer to get the kernel working with all original DSDTs
> > >> (which usually work with at least one other OS) than letting 
> > >> the people workaround the problem by using a custom DSDT.
> > >
> > >Not true at all.  For SuSE kernels, we have a patch that lets people
> > >load a new DSDT from initramfs due to broken machines requiring a
> > >replacement in order to work properly.
> > 
> > CONFIG_ACPI_CUSTOM_DSDT allows hackers to debug their system
> > by building a modified DSDT into the kernel to over-ride what
> > came with the system.  It would make no sense for a distro
> > to use it, unless the distro were shipping only on 1 model machine.
> > This technique is necessary for debugging, but makes no
> > sense for production.
> > 
> > The initramfs method shipped by SuSE is more flexible, allowing
> > the hacker to stick the DSDT image in the initrd and use it
> > without re-compiling the kernel.
> > 
> > I have refused to accept the initrd patch into Linux many times,
> > and always will.
> > 
> > I've advised SuSE many times that they should not be shipping it,
> > as it means that their supported OS is running on modified firmware --
> > which, by definition, they can not support.  
> Tainting the kernel if done so should be sufficient.
> > Indeed, one could view
> > this method as couter-productive to the evolution of Linux --
> > since it is our stated goal to run on the same machines that Windows
> > runs on -- without requiring customers to modify those machines
> > to run Linux.
> 
> There are three reasons for the initrd patch (last one also applies for
> the compile in functionality):

<snip>

Yeah, you and others within SuSE have convinced me to not drop this
patch from our kernel tree.

Sorry Len.

thanks,

greg k-h
