Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVCQWfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVCQWfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVCQWd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:33:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:41129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261293AbVCQWaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:30:02 -0500
Date: Thu, 17 Mar 2005 14:29:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: sameer.abhinkar@intel.com, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>
Subject: Re: KGDB question
Message-Id: <20050317142958.462822d2.akpm@osdl.org>
In-Reply-To: <200503171409.07290.jbarnes@engr.sgi.com>
References: <D30E01168D637641AA9D3667F3BB741603F9125F@orsmsx403.amr.corp.intel.com>
	<20050317135417.6cee8336.akpm@osdl.org>
	<200503171409.07290.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> > kgdb patches are maintained in -mm kernels.
> >
> > Patches are in
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> >-mm1/broken-out/*kgdb*
> >
> > And the patch application order is described in
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11
> >-mm1/patch-series -
> 
> What's the latest status on these?  Last I heard, some cleanup was going to 
> happen to make kgdb suitable for the mainline, did that ever happen?

It part-happened, then the effort seemed to die.

>  Also, 
> it would be nice if I could connect to a remote kernel running the kgdb stubs 
> w/o having to run gdb on the same ethernet segment.  Would that be difficult 
> to fix?

<tries to remember how ethernet works>

Maybe we'd have to teach kgdboe to arp for the remote debug host.  I think
Matt was talking about that a while back.

<tries to remember how ethernet switches work>

If switches send the destination MAC address through unchanged then maybe
the problem is that the switch simply doesn't know the MAC address of the
remote debug host yet?  If the switch has its own MAC address (it doesn't,
does it), or if it's actually a router then perhaps you should specify the
router's MAC address and not the remote debug host's.
