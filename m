Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVK2Ot4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVK2Ot4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVK2Ot4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:49:56 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:40649 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751365AbVK2Otz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:49:55 -0500
Date: Tue, 29 Nov 2005 09:49:44 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>
cc: vserver@list.linux-vserver.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] race condition in procfs
In-Reply-To: <121a28810511290639g79617c85h@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0511290945380.7838@gandalf.stny.rr.com>
References: <121a28810511282317j47a90f6t@mail.gmail.com> 
 <20051129000916.6306da8b.akpm@osdl.org>  <121a28810511290038h37067fecx@mail.gmail.com>
  <121a28810511290525m1bdf12e0n@mail.gmail.com>  <121a28810511290604m68c56398t@mail.gmail.com>
  <1133274524.6328.56.camel@localhost.localdomain> <121a28810511290639g79617c85h@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Nov 2005, Grzegorz Nosek wrote:

>
> I'm not really using vanilla 2.6 kernels and my setup would be quite
> hard to run on a vanilla kernel.
>
> The reproduceability of this bug varies. Sometimes it'll go for a few
> days without happening, sometimes it's a matter of a few minutes. I'm
> beginning to feel it's a vserver issue after all, somehow related to
> pid virtualisation (it maps some vxi->vx_initpid to 1).
>
> Thus I cannot provide a simple script to trigger the bug (I wish I
> could) but often doing a -j8 kernel compile in a vserver is enough.
>

What you are showing, would probably show up by others if this were a
vanilla kernel issue.  I don't have an 8 way machine, just 2 way, but the
vanilla kernel is being used on many 8 ways out there, so I think you are
right that this _is_ a vserver issue.

Unless, of course, that the vserver is producing an obscure race in the
vanilla kernel that normal operations would seldom have.  Just like the
PREEMPT_RT patch has discovered many race conditions that were in the
vanilla kernel but were not often a problem.

-- Steve

