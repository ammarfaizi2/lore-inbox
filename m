Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUIFAHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUIFAHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUIFAHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:07:39 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:912 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267364AbUIFAHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:07:23 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: multi-domain PCI and sysfs
Date: Sun, 5 Sep 2004 17:06:50 -0700
User-Agent: KMail/1.7
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409041603.56324.jbarnes@engr.sgi.com> <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409051706.50455.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 5, 2004 4:04 pm, Matthew Wilcox wrote:
> On Sat, Sep 04, 2004 at 04:03:56PM -0700, Jesse Barnes wrote:
> > On Saturday, September 4, 2004 3:45 pm, Jon Smirl wrote:
> > > Is this a multipath configuration where pci0000:01 and pci0000:02 can
> > > both get to the same target bus? So both busses are top level busses?
> > >
> > > I'm trying to figure out where to stick the vga=0/1 attribute for
> > > disabling all the VGA devices in a domain. It's starting to look like
> > > there isn't a single node in sysfs that corresponds to a domain, in
> > > this case there are two for the same domain.
> >
> > Yes, I think that's the case.  Matthew would probably know for sure
> > though.
>
> Huh, eh, what?  There's no such thing as multipath PCI configurations.
> The important concepts in PCI are:

Right, but I was answering his question about whether or not there was a place 
to stick his 'vga' control file on a per-domain basis.  There would be if the 
layout was something like this:

/sys/devices/pciDDDD/BB/SS.F/foo
rather than the current
/sys/devices/pciDDDD:BB/DDDD:BB:SS.F/foo

> I haven't really looked at the VGA attribute.  I think Ivan or Grant
> would be better equipped to help you on this front.  I remember them
> rehashing it 2-3 years ago.

I'm actually ok with a system wide vga arbitration driver, assuming that we'll 
never have to worry about the scalability of stuff that wants to do legacy 
vga I/O.

Thanks,
Jesse
 
