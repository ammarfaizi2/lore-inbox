Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUJCUxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUJCUxC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 16:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUJCUxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 16:53:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:32663 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268146AbUJCUw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 16:52:59 -0400
Date: Sun, 3 Oct 2004 13:48:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Erich Focht <efocht@hpce.nec.com>
Cc: pj@sgi.com, nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041003134842.79270083.akpm@osdl.org>
In-Reply-To: <200410032221.26683.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<200410032221.26683.efocht@hpce.nec.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht <efocht@hpce.nec.com> wrote:
>
> Can CKRM (as it is now) fulfil the requirements?
> 
>  I don't think so. CKRM gives me to some extent the confidence that I
>  will really use the part of the machine for which I paid, say 50%. But
>  it doesn't care about the structure of the machine.

Right.   That's a restriction of the currently-implemented CKRM controllers.

> ...
>  Can CKRM be extended to do what cpusets do? 
> 
>  Certainly. Probably easilly. But cpusets will have to be reinvented, I
>  guess. Same hooks, same checks, different user interface...

Well if it is indeed the case that the CKRM *framework* is up to the task
of being used to deliver the cpuset functionality then that's the way we
should go, no?  It's more work and requires coordination and will deliver
later, but the eventual implementation will be better.

But I'm still not 100% confident that the CKRM framework is suitable. 
Mainly because the CKRM and cpuset teams don't seem to have looked at each
other's stuff enough yet.
