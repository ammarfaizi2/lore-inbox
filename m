Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266861AbUGWAj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266861AbUGWAj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 20:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUGWAj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 20:39:27 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:62662 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266861AbUGWAjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 20:39:24 -0400
Date: Thu, 22 Jul 2004 20:39:37 -0400
From: Jason Cooper <lkml@lakedaemon.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040723003937.GA19041@lakedaemon.net>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de> <20040722160112.177fc07f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722160112.177fc07f.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (akpm@osdl.org) scribbled:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> > There's much worth in having a very stable kernel. Many people use for 
> > different reasons self-compiled ftp.kernel.org kernels. 

I have to agree with Adrian, the first thing I always do with a new
distro is rip out the kernel and drop in a vanilla from kernel.org.
I've been biten too many times by distro kernels. :(

> I wouldn't be averse to releasing a 2.6.20.1 which is purely stability
> fixes against 2.6.20 if there is demand for it.  Anyone who really cares
> about stability of kernel.org kernels won't be deploying 2.6.20 within a
> few weeks of its release anyway, so by the time they doodle over to
> kernel.org they'll find 2.6.20.2 or whatever.

imho, I feel there are two main concerns with changing the development
model:

	1.) Need to have readily identifiable stable versions w/o
	    following lkml.
	2.) Understanding the changing of version numbers in light of
	    this change of strategy.

Ideas:

wrt (1), I think the -rc? system would be simplest.  2.6.20 is stable,
2.6.20-rc3 is not.  

wrt (2), assuming the naming stays the same:

	major++ = major overhaul of core system.
	minor++ = overhaul to drivers (or subset thereof).
	patch++ = testing patches survived, appear stable.
	extra++ = next set of testing patches applied.

Sure, this would mean version numbers start to creap up, but nothing is
stopping a kernel version 2.11.x (what?! where's my 3.0.1?  We were
definitely supposed to have a 3.0 around here somewhere... Where's my
meds? *frowns*).

tia,

Cooper.
