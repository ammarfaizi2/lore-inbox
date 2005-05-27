Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVE0J0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVE0J0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVE0JYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:24:24 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39057 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262406AbVE0JJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:09:23 -0400
Date: Fri, 27 May 2005 11:09:02 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4: resent] cpuset exit NULL dereference fix
In-Reply-To: <20050527090243.30833.93829.sendpatchset@tomahawk.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0505271106330.11050@openx3.frec.bull.fr>
References: <20050527090243.30833.93829.sendpatchset@tomahawk.engr.sgi.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/05/2005 11:20:01,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 27/05/2005 11:20:04,
	Serialize complete at 27/05/2005 11:20:04
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Paul Jackson wrote:

> Andrew,
> 
> Resubmitting the same patch I submitted yesterday.  Simon Derr
> and I agree that we need this patch now to fix a kernel crash.
> 
> The potential scaling issues are theoretical at this time.
> When they become more real, we will be in a better position to
> consider more ambitious changes to cpuset locking and reference
> counting.
> 
> Meanwhile -- this patch is small, simple, and needed.
> 
> ===
> 
> There is a race in the kernel cpuset code, between the code
> to handle notify_on_release, and the code to remove a cpuset.
> The notify_on_release code can end up trying to access a
> cpuset that has been removed.  In the most common case, this
> causes a NULL pointer dereference from the routine cpuset_path.
> However all manner of bad things are possible, in theory at least.

> Signed-off-by: Paul Jackson <pj@sgi.com>
> 
> Index: 2.6-cpuset_path_fix/kernel/cpuset.c
> ===================================================================
> --- 2.6-cpuset_path_fix.orig/kernel/cpuset.c	2005-05-25 19:20:27.000000000 -0700
> +++ 2.6-cpuset_path_fix/kernel/cpuset.c	2005-05-26 00:50:32.000000000 -0700

OK for me.

Acked-by: Simon Derr <simon.derr@bull.net>

