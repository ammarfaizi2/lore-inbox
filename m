Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271310AbTHMAbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271311AbTHMAbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:31:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33483 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271310AbTHMAbg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:31:36 -0400
Date: Wed, 13 Aug 2003 01:31:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>, Dave Jones <davej@redhat.com>,
       jgarzik@pobox.com, davem@redhat.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813003134.GQ10015@parcelfarce.linux.theplanet.co.uk>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <20030812235324.GA12953@redhat.com> <20030813000841.GP10015@parcelfarce.linux.theplanet.co.uk> <20030813002344.GA2797@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813002344.GA2797@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 05:23:44PM -0700, Greg KH wrote:
> On Wed, Aug 13, 2003 at 01:08:41AM +0100, Matthew Wilcox wrote:
> > On Wed, Aug 13, 2003 at 12:53:24AM +0100, Dave Jones wrote:
> > > What would be *really* nice, would be the ability to do something
> > > to the effect of..
> 
> Yeah, that would be cool to do.  2.7 :)

Well, we'd need some cooperation from the GCC folks for it ... I can't
see them being too interested in this extension.

> Yeah, it was just a port from 2.4 which says:
> 
> 	struct pci_device_id {
> 		unsigned int vendor, device;
> 		unsigned int subvendor, subdevice;
> 		unsigned int class, class_mask;
> 		unsigned long driver_data;
> 	};
> 
> We could probably change it now if you really want to.  Don't know if it
> will save much space though.

Think about it, 8 bytes per pci_device_id; that's 120 bytes in tg3 alone.
Admittedly tg3 has more than its fair share of IDs, but distro kernels
will love it.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
