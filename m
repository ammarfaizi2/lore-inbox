Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUIDWpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUIDWpa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUIDWpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:45:30 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:10941 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264286AbUIDWpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:45:24 -0400
Message-ID: <9e47339104090415451c1f454f@mail.gmail.com>
Date: Sat, 4 Sep 2004 18:45:23 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: multi-domain PCI and sysfs
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200409041527.50136.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409041457.46578.jbarnes@engr.sgi.com>
	 <9e47339104090415123750a1eb@mail.gmail.com>
	 <200409041527.50136.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a multipath configuration where pci0000:01 and pci0000:02 can
both get to the same target bus? So both busses are top level busses?

I'm trying to figure out where to stick the vga=0/1 attribute for
disabling all the VGA devices in a domain. It's starting to look like
there isn't a single node in sysfs that corresponds to a domain, in
this case there are two for the same domain.

On Sat, 4 Sep 2004 15:27:50 -0700, Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> On Saturday, September 4, 2004 3:12 pm, Jon Smirl wrote:
> > On Sat, 4 Sep 2004 14:57:46 -0700, Jesse Barnes <jbarnes@engr.sgi.com>
> wrote:
> > > Yep, on all the machines I've used.
> > >
> > > sn2 (ia64):
> > > [root@flatearth ~]# ls -l /sys/devices
> > > total 0
> > > drwxr-xr-x  5 root root 0 Sep  5 08:07 pci0000:01
> > > drwxr-xr-x  3 root root 0 Sep  5 08:07 pci0000:02
> > > drwxr-xr-x  2 root root 0 Sep  5 08:07 platform
> > > drwxr-xr-x  5 root root 0 Sep  5 08:07 system
> >
> > sn2 looks wrong. It should be
> >
> > > drwxr-xr-x  5 root root 0 Sep  5 08:07 pci0000:01
> > > drwxr-xr-x  3 root root 0 Sep  5 08:07 pci0001:02
> > > drwxr-xr-x  2 root root 0 Sep  5 08:07 platform
> > > drwxr-xr-x  5 root root 0 Sep  5 08:07 system
> 
> It only has one domain though, so it's correct.  Both busses are in domain 0.
> 
> Jesse
> 



-- 

Jon Smirl
jonsmirl@gmail.com
