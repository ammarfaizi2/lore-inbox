Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264976AbUEYRIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbUEYRIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264990AbUEYRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:08:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:16550 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264984AbUEYRGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:06:31 -0400
Date: Tue, 25 May 2004 10:05:28 -0700
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Matthew Wilcox <willy@debian.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040525170527.GA9495@kroah.com>
References: <20040524210146.GA5532@kroah.com> <1085468008.2783.1.camel@laptop.fenrus.com> <20040525080006.GA1047@kroah.com> <20040525113231.GB29154@parcelfarce.linux.theplanet.co.uk> <20040525125452.GC3118@logos.cnet> <20040525144055.GA7252@kroah.com> <20040525165904.GF3385@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525165904.GF3385@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 01:59:04PM -0300, Marcelo Tosatti wrote:
> On Tue, May 25, 2004 at 07:40:56AM -0700, Greg KH wrote:
> > On Tue, May 25, 2004 at 09:54:53AM -0300, Marcelo Tosatti wrote:
> > > 
> > > Hi kernel fellows,
> > > 
> > > On Tue, May 25, 2004 at 12:32:31PM +0100, Matthew Wilcox wrote:
> > > > On Tue, May 25, 2004 at 01:00:06AM -0700, Greg KH wrote:
> > > > > > how does this mesh with the "2.4 is now feature frozen"?
> > > > > 
> > > > > As the major chunk of ACPI support just got added to the tree, and the
> > > > > only reason that went in was for this patch, I assumed that it was
> > > > > acceptable.
> > > 
> > > major? the MMConfig support is minimal as I can see? 
> > 
> > It isn't that big of a patch, but it is make to core PCI code.
> > 
> > > > > Marcelo, feel free to tell me otherwise if you do not want
> > > > > this in the 2.4 tree. 
> > > 
> > > Is this code necessary for PCI-Express devices/busses to work properly?
> > 
> > Not that I can tell, the main point is accessing the extended config
> > space, and speeding up the access to the device to its natural speed.
> > 
> > > > I assume it was added because Len tries to keep ACPI in 2.4 and 2.6 as
> > > > close to identical as possible.  It certainly doesn't hurt anyone to add
> > > > the ACPI functionality without the MMConfig support.
> > > 
> > > I've humbly asked Len to stop doing big updates whenever possible on the 
> > > v2.4 ACPI code, and do bugfixes only instead. Is that a pain in the ass for you, Len?    
> > > 
> > > I asked that because it is common to see new bugs introduced by an ACPI update, 
> > > and you know that more than I do.
> > 
> > Yes, I know that quite well :)
> > 
> > So, because of this, you are saying that we should not apply these
> > patches at this time? 
> 
> Yeap, I would prefer not to apply them at this time. For one, Arjan told
> me privately it can break XFree86 which accesses the PCI config space directly.
> Right?

Um, not that I know of.  2.6 has had this code for a while now with no
reported problems.

Arjan, is there something I need to know about?  :)

> > If so, that's fine with me, as now any distro that wants to add this to
> > their 2.4 kernel can, as the patches are public.
> 
> Yeap. 

Ok, no problem, thanks for looking at it.

greg k-h
