Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVC2F6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVC2F6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 00:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVC2F6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 00:58:30 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:3053 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262419AbVC2F6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 00:58:21 -0500
Date: Tue, 29 Mar 2005 00:58:14 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Coywolf Qi Hunt <coywolf@lovecn.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Greg KH <greg@kroah.com>,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050329055814.GG11458@mail>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@lovecn.org>,
	Lee Revell <rlrevell@joe-job.com>, Greg KH <greg@kroah.com>,
	Mark Fortescue <mark@mtfhpc.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk> <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe> <4248BF80.7090805@lovecn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4248BF80.7090805@lovecn.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/05 10:37:52AM +0800, Coywolf Qi Hunt wrote:
> Lee Revell wrote:
> >On Sat, 2005-03-26 at 10:28 -0800, Greg KH wrote:
> >
> >>On Sat, Mar 26, 2005 at 05:52:20PM +0000, Mark Fortescue wrote:
> >>
> >>>I am writing a "Proprietry" driver module for a "Proprietry" PCI card and
> >>>I have found that I can't use SYSFS on Linux-2.6.10.
> >>>
> >>>Why ?. 
> >>
> >>What ever gave you the impression that it was legal to create a
> >>"Proprietry" kernel driver for Linux in the first place.
> >
> >
> >The fact that Nvidia and ATI get away with it?
> 
> I have the nvidia GeForce4 driver: NVIDIA-Linux-x86-1.0-6629-pkg1.
> 
> $ ls NVIDIA-Linux-x86-1.0-6629-pkg1/usr/src/nv/
> Makefile@            makedevices.sh*  nv-vm.c  nv_compiler.h  os-agp.c      
> os-registry.c
> Makefile.kbuild      makefile         nv-vm.h  nvidia.ko      os-agp.h      
> os-registry.o
> Makefile.nvidia      nv-kernel.o      nv-vm.o  nvidia.mod.c   os-agp.o      
> pat.h
> README               nv-linux.h       nv.c     nvidia.mod.o   
> os-interface.c  precompiled/
> conftest.sh          nv-memdbg.h      nv.h     nvidia.o       
> os-interface.h  rmretval.h
> gcc-version-check.c  nv-misc.h        nv.o     nvtypes.h      os-interface.o
> 
> 
> So it seems nvidia has their kernel module `open'. Is it?

See that 4.2M binary file called nv-kernel.o? That's the real driver, the open
part is the glue, a sort of middle-ware so that the driver can be
recompiled and loaded into any kernel.

> 
> 
> 	Coywolf
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
