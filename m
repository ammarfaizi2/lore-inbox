Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263719AbTJCLyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 07:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263720AbTJCLyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 07:54:23 -0400
Received: from fortunaty.net ([217.160.129.175]:35818 "HELO
	paladin.fortunaty.net") by vger.kernel.org with SMTP
	id S263719AbTJCLx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 07:53:56 -0400
Date: Fri, 3 Oct 2003 13:53:55 +0200
From: Andreas Hauser <andy-lkml@splashground.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.sourceforge.net
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization
Message-ID: <20031003115355.GA16436@splashground.de>
References: <20031003101215.GW32080@splashground.de> <E1A5NBc-0006R5-00@wisbech.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E1A5NBc-0006R5-00@wisbech.cl.cam.ac.uk>
X-Addicted: yeah
X-License: BSD
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 11:29:24AM +0100, Ian Pratt wrote:
> > On Fri, Oct 03, 2003 at 09:13:10AM +0100, Ian Pratt wrote:
> > [...]
> > > We built Xen for use in the XenoServers project, which aims to
> > > create an 'Open Infrastructure for Global Distributed Computing'.
> > > We envisage Xenoserver execution platforms scattered across the
> > > globe and available for any member of the public to execute code
> > > on.  The sponsor of the code will be billed for all the resources
> > > used or reserved during the course of execution. You'd be able to
> > > create on-demand 'dedicated servers' with tailored amounts of
> > > RAM, CPU, net b/w, disk b/w and disk space, and run the OS of
> > > your choice. For example, you could buy a slice of a machine to
> > > run a counterstrike server for a few minutes while you play a
> > > game with a couple of friends. You'd pick the server location
> > > such as to minimize the maximum RTT between the server and the
> > > players.
> > 
> > So does this run over openmosix ?
> 
> XenoServers is more about global-scale distributed computing
> rather than clusters.
> 
> However, there's no reason why you can't apply the OpenMosix
> patches to a xen -patched linux, and hence emulate a cluster on a
> multi-processor machine. This isn't as daft as it sounds, as if
> you have a highly parallel ccNUMA machine you might actually be
> better off in terms of performance by carving it up into a set of
> smaller multi processor virtual machines that you then glue back
> together with something like OpenMosix.

I was more thinking of running Xen on one node of a cluster,
using it as the management tool.
Each user gets his own VM on the master node,
and can only access that.
A real value would be if one could use the
cluster resources from within a e.g. freebsd guest.

So the question would be, can the processes of the
guest OS be migrated to to other nodes?
(openmosix can only migrate the userspace part of a process)

Anyways i will try it next week.

aha
