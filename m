Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbTCUWTX>; Fri, 21 Mar 2003 17:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263946AbTCUWSA>; Fri, 21 Mar 2003 17:18:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:9941 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263935AbTCUWQz>;
	Fri, 21 Mar 2003 17:16:55 -0500
Date: Fri, 21 Mar 2003 16:32:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5 vm bugfix
Message-Id: <20030321163223.18d80737.akpm@digeo.com>
In-Reply-To: <20030321151827.GA9387@bytesex.org>
References: <20030321151827.GA9387@bytesex.org>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2003 22:27:14.0533 (UTC) FILETIME=[05F06150:01C2EFF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> wrote:
>
>   Hi,
> 
> 2.5.x kernels don't look at the VM_DONTEXPAND flag when merging
> multiple vmas into one.  Fix below.

There is but one user of VM_DONTEXPAND in the kernel, and that is you ;)

Can you describe exactly why this driver requires DONTEXPAND?  ie: how does
the driver work, and why is it special?

If there is some alternative way of providing the same behaviour we could
remove VM_DONTEXPAND, which would be nice.

Thanks.
