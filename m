Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbRERWSm>; Fri, 18 May 2001 18:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261589AbRERWSc>; Fri, 18 May 2001 18:18:32 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:9062 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261578AbRERWSO>; Fri, 18 May 2001 18:18:14 -0400
Date: Fri, 18 May 2001 18:18:14 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200105182218.f4IMIE910681@devserv.devel.redhat.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <mailman.990207420.8659.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.990207420.8659.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > As for the language CML2 is written in, surely C would work just as well as
> > Python if the config-ruleset file is in a known format.  GCC is required
> > for the kernel to build, I don't see why anything else should be required
> > simply to configure it.
> 
> Menuconfig is fairly popular, and requires curses.. etc. etc.  There isn't
> a configurator which doesn't require something more than gcc is there?

I always do "vi .config", then "make oldconfig", because it is very
convinient, simple, and flexible way to do it. For instance, it is
very easy to store a pile of configs for different kernels, very
easy do diff them (with -u and without).

I do not have Python installed on any of my machines.

The right way to handle the CML2 problem, IMHO, is to have a
C implementation of Python part without curses, tcl, and other crap.
Half of ESR's justification is "dynatic loading of components and
recovery from failure to load them", which goes away if we
do not support extras like curses. Another half was GC, which
is just a convinience for a project of CML's size.

-- Pete
