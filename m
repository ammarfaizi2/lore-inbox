Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTJCK30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 06:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbTJCK30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 06:29:26 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:29391 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263680AbTJCK3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 06:29:25 -0400
To: Andreas Hauser <andy-lkml@splashground.de>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       xen-devel@lists.sourceforge.net, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-reply-to: Your message of "Fri, 03 Oct 2003 12:12:15 +0200."
             <20031003101215.GW32080@splashground.de> 
Date: Fri, 03 Oct 2003 11:29:24 +0100
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1A5NBc-0006R5-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Oct 03, 2003 at 09:13:10AM +0100, Ian Pratt wrote:
> [...]
> > We built Xen for use in the XenoServers project, which aims to
> > create an 'Open Infrastructure for Global Distributed Computing'.
> > We envisage Xenoserver execution platforms scattered across the
> > globe and available for any member of the public to execute code
> > on.  The sponsor of the code will be billed for all the resources
> > used or reserved during the course of execution. You'd be able to
> > create on-demand 'dedicated servers' with tailored amounts of
> > RAM, CPU, net b/w, disk b/w and disk space, and run the OS of
> > your choice. For example, you could buy a slice of a machine to
> > run a counterstrike server for a few minutes while you play a
> > game with a couple of friends. You'd pick the server location
> > such as to minimize the maximum RTT between the server and the
> > players.
> 
> So does this run over openmosix ?

XenoServers is more about global-scale distributed computing
rather than clusters.

However, there's no reason why you can't apply the OpenMosix
patches to a xen -patched linux, and hence emulate a cluster on a
multi-processor machine. This isn't as daft as it sounds, as if
you have a highly parallel ccNUMA machine you might actually be
better off in terms of performance by carving it up into a set of
smaller multi processor virtual machines that you then glue back
together with something like OpenMosix.

However, although Xen is itself SMP capable, it currently doesn't
support SMP guests, though we're actively working on it.

Best,
Ian

