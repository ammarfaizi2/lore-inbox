Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTDSUaD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTDSUaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:30:03 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:11722 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S263455AbTDSUaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:30:01 -0400
Date: Sat, 19 Apr 2003 22:41:38 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: firmware separation filesystem (fwfs)
Message-ID: <20030419204138.GC638@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030416163641.GA2183@ranty.ddts.net> <1050508028.28586.126.camel@dhcp22.swansea.linux.org.uk> <20030417012321.GB9219@zax> <1050585122.31390.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050585122.31390.25.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 02:12:03PM +0100, Alan Cox wrote:
> On Iau, 2003-04-17 at 02:23, David Gibson wrote:
> > > But so would loading it from hotplug via ioctl. It might be we want
> > > a clean hotplug way to ask for 'firmare for xyz'.
> > 
> > True, but ioctl()s are horrid.  And the driver needs to set up a
> > suitable device to which the ioctl() is applied, and deal with binding
> > the right image to the right instance, which can get messy in some
> 
> You are ignoring the main issue of discussion. I don't care if its
> ioctl, tcp/ip over carrier pigeon or a pipe.
> 
> fwfs is a broken idea because it leaves the data in kernel space. On
> a giant IBM monster maybe nobody cares about a few hundred K of cached
> firmware in the kernel, but the rest of us happen to run real world
> computers.

 Many drivers currently include this same data in kernel space, in in
 headers, what I am trying to do is make it easy for them to support
 fwfs (or whatever it becomes in the end). This way, they may be able to
 support it with little effort (which increases the chances of them
 actualy supporting it) and people worried about memory usage can easly
 free up that memory with a simple unlink.


> Catting the firmware to a device node also works fine for me as an 
> API, but keep the firmware in userspace.

 When sysfs binary support is integrated I'll try to do something on top
 of it, and in any case, I'll at the minimum make sure that in-kernel
 data is optional.

 Have a nice day

 	Manuel
 
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
