Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWBZJpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWBZJpu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 04:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWBZJpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 04:45:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751299AbWBZJpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 04:45:49 -0500
Date: Sun, 26 Feb 2006 01:44:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       Dave Airlie <airlied@linux.ie>
Subject: Re: old radeon latency problem still unfixed?
Message-Id: <20060226014437.327b1cc3.akpm@osdl.org>
In-Reply-To: <1140917787.24141.78.camel@mindpipe>
References: <1140917787.24141.78.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
>  Users report that this patch:
> 
>  https://www.redhat.com/archives/fedora-devel-list/2004-June/msg00072.html
> 
>  is still needed to eliminate audio underruns for Radeon users.

That's a 2.6.4 patch which generates 100% rejects.

But still, if that patch helped and didn't throw a billion might_sleep()
and people were using preemptible kernels then we have a lock_kernel()
problem.  A suitable fix would be to make sure all the locking's tight and
to convert DRM to use unlocked_ioctl.
