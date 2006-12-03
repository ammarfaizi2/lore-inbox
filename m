Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936679AbWLCIas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936679AbWLCIas (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 03:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936680AbWLCIas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 03:30:48 -0500
Received: from 1wt.eu ([62.212.114.60]:21765 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S936679AbWLCIar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 03:30:47 -0500
Date: Sun, 3 Dec 2006 09:30:31 +0100
From: Willy Tarreau <w@1wt.eu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       William Estrada <MrUmunhum@popdial.com>, linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
Message-ID: <20061203083031.GB900@1wt.eu>
References: <4571CE06.4040800@popdial.com> <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr> <20061202211522.GB24090@1wt.eu> <Pine.LNX.4.61.0612022253280.25553@yvahk01.tjqt.qr> <20061202225528.GA27342@1wt.eu> <1165113438.5698.5.camel@lade.trondhjem.org> <20061203060208.GA900@1wt.eu> <1165129510.5745.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165129510.5745.14.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 02:05:10AM -0500, Trond Myklebust wrote:
> On Sun, 2006-12-03 at 07:02 +0100, Willy Tarreau wrote:
> 
> > That's a valid point, but in fact, building with NFS client and serial
> > port support in the kernel on some archs is as common as building with
> > IDE driver and VGA console in the kernel on x86. With some architectures
> > used in light networked workstations, it's very common to boot from the
> > network (sparc & parisc come to mind, sorry to those I forgot), hence
> > this common practise.
> 
> I have no influence over the distributions' choice of kernel compiler
> options. The fact is, though, that few of them support nfsroot out of
> the box. AFAICS FC-6 is one of those that appears not to.
> 
> > > As for the initramfs support, hpa has assured me that his klibc
> > > distribution already has a full solution for NFS mounting on current
> > > kernels.
> > 
> > That's again where we see the limits of this ever-developping 2.6.
> > I'm not saying that doing this from initramfs+tools is a bad solution,
> > since it solves lots of problems, it's just that it is *much* different
> > from what was previously done.
> > 
> > People who have installed a distro on their machines will not be
> > able to upgrade their kernel past a certain point by hand. Upgrading
> > distro packages in such environments is generally not always an
> > option (particularly boot packages such as boot loader and kernel),
> > because the boot server is not necessarily running on the same
> > OS/distro, and sometimes the kernel needs different build options.
> 
> Most people that run nfsroot systems do so because that makes
> provisioning of new machines easy: if you only have one system image,
> then upgrading it is less of a challenge.

It's one use, but another one is for diskless terminals, often built
from old systems. In this case, it's to avoid the cost, noise, power
consumption and failures associated to disks. It's quite often done
one radically different archs/OS between the server and the clients,
making the upgrade more complicated.

Willy

