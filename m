Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266723AbRHBRJB>; Thu, 2 Aug 2001 13:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266864AbRHBRIv>; Thu, 2 Aug 2001 13:08:51 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:35854 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266723AbRHBRIg>;
	Thu, 2 Aug 2001 13:08:36 -0400
Date: Thu, 2 Aug 2001 10:06:05 -0700
From: Greg KH <greg@kroah.com>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent device numbers
Message-ID: <20010802100605.A26987@kroah.com>
In-Reply-To: <000901c11b1c$a87b1f40$21c9ca95@mow.siemens.ru> <200108021020.f72AKZC17605@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108021020.f72AKZC17605@ns.caldera.de>; from hch@ns.caldera.de on Thu, Aug 02, 2001 at 12:20:35PM +0200
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 12:20:35PM +0200, Christoph Hellwig wrote:
> > Most commercial systems (O.K. those I looked into) have some sort of logical
> > device numbering that assigns fixed name based on some unique hardware
> > address (cf /etc/path_to_inst in Solaris). Hardware address usually is a
> > path needed to access device - i.e. Bus/Slot/Channel[/drive id], so that you
> > can set
> >
> > PCI0/Slot3/Channel1 == eth3
> >
> > and this never changes if you add or remove any card.
> >
> > Do I miss something and Linux has such mechanism?
> 
> For some device-types this is provided be userspace tools.  E.g. LVM
> provides persistan names for it's deice by stroing name and UUID on disk,
> 'normal' filesystems can be mounted by UUID or label and Andi Kleen has
> a tool that allows naming network interfaces by MAC addresses.

Yes, and combine the 'nameif' program with the linux-hotplug scripts and
you can have your network devices always be named correctly
automatically when the interface starts up.

greg k-h
