Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWEULGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWEULGI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 07:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWEULGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 07:06:08 -0400
Received: from ozlabs.org ([203.10.76.45]:32704 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932366AbWEULGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 07:06:07 -0400
Subject: Re: [patch] i386, vdso=[0|1] boot option and
	/proc/sys/vm/vdso_enabled
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       virtualization@lists.osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060521104119.GA21117@elte.hu>
References: <20060520010303.GA17858@elte.hu>
	 <20060519181125.5c8e109e.akpm@osdl.org>
	 <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
	 <20060520085351.GA28716@elte.hu> <20060520022650.46b048f8.akpm@osdl.org>
	 <446EE1C2.7060400@vmware.com> <20060520024842.69c77aaf.akpm@osdl.org>
	 <446EE992.4020604@vmware.com>
	 <1148186298.29161.8.camel@localhost.localdomain>
	 <1148204118.31087.8.camel@localhost.localdomain>
	 <20060521104119.GA21117@elte.hu>
Content-Type: text/plain
Date: Sun, 21 May 2006 21:06:03 +1000
Message-Id: <1148209563.31087.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 12:41 +0200, Ingo Molnar wrote:
> * Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > But it turns out that this is a known problem with FC1's glibc and the 
> > exec-shield patches (google for FC1 glibc vdso). [..]
> 
> no, i think that conclusion is wrong. The FC1 glibc and vdso problems 
> *when mixing a FC2 kernel with a FC1 glibc* were due to exec-shield 
> enforcing non-exec for the vdso.

Interesting.  I'll see if I can find a spare machine to try installing
FC1 on tomorrow then, see if I can figure this one out.  I can't think
how this could happen, though.

> > [...] When Ingo and Arjan convinced me to push their code from 
> > exec-shield, they conveniently didn't mention this.
> 
> this bug has nothing to do with nonexec restrictions. [ Also, this all 
> was _years_ and hundreds of bugs ago, when upstream's position was still 
> a cocky "who the hell needs protection against overflows" and "go away 
> with this non-exec crap" so we were pretty much alone trying to 
> introduce those features. So any suggestion of intention on our part 
> would be quite unfair. ]

Sorry if I was narky.  I tried to do the right thing and get more of
execshield in, rather than just what I needed, but it seems I screwed up
somewhere.  With the Wesnoth 1.2 feature freeze next week, my spare time
to chase bugs I don't need to is limited 8(

Cheers,
Rusty.
-- 
 ccontrol: http://ccontrol.ozlabs.org

