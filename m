Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269359AbUIIGni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269359AbUIIGni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 02:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269361AbUIIGnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 02:43:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:18956 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269359AbUIIGn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 02:43:27 -0400
Date: Thu, 9 Sep 2004 08:43:22 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS hangs in 2.4.27
Message-ID: <20040909064322.GA1444@alpha.home.local>
References: <20040908140730.1a3b77c7.Christoph.Pleger@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908140730.1a3b77c7.Christoph.Pleger@uni-dortmund.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 02:07:30PM +0200, Christoph Pleger wrote:
> Hello,
> 
> Since a few days I have great NFS problems on six Linux machines. The
> execution of "ps aux" shows that processes are hanging for they are
> waiting for the completion of uninterruptable NFS I/O and the system
> utilization becomes very high.
> 
> The hangs occurred since the installation of Kernel 2.4.27 (used 2.4.26
> before), so I guess that Kernel 2.4.27 introduces the problems with NFS.
> I am not sure about that, but since I reinstalled the old 2.4.26-Kernel
> on one of the six computers, that machine works fine.
> 
> Has someone else experienced NFS hangs under 2.4.27 so far?

I have seen this only with the preempt patch applied and enabled. But since
the kernel also had lots of other patches applied, I cannot tell that it is
only NFS+preemt alone. It deadlocked on a spinlock() in nfs_sync_page() IIRC.

But no problem so far with preempt disabled.

Regards,
Willy

