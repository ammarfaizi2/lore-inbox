Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270256AbRHIRQn>; Thu, 9 Aug 2001 13:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270335AbRHIRQd>; Thu, 9 Aug 2001 13:16:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42344 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270256AbRHIRQV>; Thu, 9 Aug 2001 13:16:21 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dws@dirksteinberg.de (Dirk W. Steinberg),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Swapping for diskless nodes
In-Reply-To: <E15UrbB-0007T9-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Aug 2001 11:09:37 -0600
In-Reply-To: <E15UrbB-0007T9-00@the-village.bc.nu>
Message-ID: <m1snf1tb1q.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > the memory of a fast server could have much less latency that writing 
> > that page out to a local old, slow IDE disk. Clusters could even have
> > special high-bandwidth, low latency networks that could be used for
> > remote paging.
> > 
> > In a perfect world, all nodes in a cluster would be able to dynamically 
> > share a pool of "cluster swap" space, so any locally available swap that
> > is not used could be utilized by other nodes in the cluster.
> 
> That I think is a 2.5 problem. One thing that has been talked about several
> times now is removing all the swap special case crap from the mm and making
> swap a file system. That removes special cases and means anyone can write
> or use custom, or multiple swap filesystems, in theory including things like
> swap over a shared GFS pool
> 
> But its not for 2.4, no way

I don't know about that.  We already can swap over just about everything 
because we can swap over the loopback device.  So moving making the swapping
code do the right thing is not that big of an allowance, nor that
much of extra code so if 2.5 actually starts up I can see us doing that.

Eric
