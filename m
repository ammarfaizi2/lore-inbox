Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUDPByU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 21:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUDPByU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 21:54:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:5780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261425AbUDPByR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 21:54:17 -0400
Date: Thu, 15 Apr 2004 18:53:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: shannon@widomaker.com, linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-Id: <20040415185355.1674115b.akpm@osdl.org>
In-Reply-To: <1082079061.7141.85.camel@lade.trondhjem.org>
References: <20040416011401.GD18329@widomaker.com>
	<1082079061.7141.85.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> På to , 15/04/2004 klokka 18:14, skreiv Charles Shannon Hendrix:
> > 
> 
> > NFS server:
> > 
> >     Sun SS5
> >     10baseT ethernet (100baseT card available, not used)
> >     NetBSD 1.6.1
> >     pretty much a plain vanilla server setup
> > 
> > Network:
> > 
> >     simple LAN with three machines, connected via a full duplex
> >     multi-speed switch
> > 
> > NFS client:
> > 
> >     vanilla PC
> >     Intel Pro/100 ethernet
> >     Slackware 9.1
> >     Linux kernel 2.6.5, plain with no mods or patches, only enough
> > 	drivers and features enabled to run my workstation
> > 	configuration as close as I could get to my Linux 2.4
> > 	kernel
> 
> This is pretty much covered in the NFS FAQ entry B10.
> 
> You are experiencing the classical effects of using unreliable transport
> (i.e. UDP) on a mixed speed network. Writes to the server are getting
> lost, because it is on a slow segment that cannot keep up with the
> faster 100Mbit clients.

But Charles was seeing good performance with 2.4-based clients.  When he
went to 2.6 everything fell apart.

Do we know why this regression occurred?
