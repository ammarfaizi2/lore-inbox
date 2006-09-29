Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWI2X3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWI2X3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWI2X3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:29:13 -0400
Received: from mx1.suse.de ([195.135.220.2]:5840 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932244AbWI2X3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:29:12 -0400
Date: Fri, 29 Sep 2006 16:29:04 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>, jgarzik@pobox.com
Subject: Re: 2.6.18-mm2 -- EIP: [<c11a962e>] klist_node_init+0x2b/0x3a SS:ESP 0068:f63a5f80
Message-ID: <20060929232904.GB27431@kroah.com>
References: <a44ae5cd0609281913q127abc03i72dc7ea8711a223f@mail.gmail.com> <20060928200431.8f7f3fea.akpm@osdl.org> <a44ae5cd0609282131t2841a7b7ued9ffc22ac470687@mail.gmail.com> <20060928214910.a3be37ea.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928214910.a3be37ea.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 09:49:10PM -0700, Andrew Morton wrote:
> On Thu, 28 Sep 2006 21:31:19 -0700
> "Miles Lane" <miles.lane@gmail.com> wrote:
> > > Does setting CONFIG_PCI_MULTITHREAD_PROBE=n fix it?
> > 
> > Yes and no.  The BUG no longer occurs,
> 
> OK, thanks.  Note to Greg: CONFIG_PCI_MULTITHREAD_PROBE+ipw2200 = oops.

Odd, it works for me here.

Hm, but that's not at boot time, I load the module at udev init time.

Miles, are you using this as a module or built into the kernel?

Hm, I'm also running it on a single proc machine, which really does not
show any race conditions in the pci probe logic very well.

Anyone have a dual-core laptop they want to donate to the effort?  :)

thanks,

greg k-h
