Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbTFFJE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 05:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbTFFJE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 05:04:28 -0400
Received: from angband.namesys.com ([212.16.7.85]:37776 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265128AbTFFJE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 05:04:27 -0400
Date: Fri, 6 Jun 2003 13:17:59 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030606091759.GC23608@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030606081712.GA27663@namesys.com> <20030606110408.1c8ef962.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606110408.1c8ef962.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jun 06, 2003 at 11:04:08AM +0200, Stephan von Krawczynski wrote:
> > No, it did crashed in allocation code (you skipped one trace line):
> > Jun  5 16:53:55 admin kernel: Call Trace:    [__kmem_cache_alloc+107/304]
> > [kmem_cache_grow+508/624]
> > [__kmem_cache_alloc+125/304]+[get_mem_for_virtual_node+87/224]
> > [fix_nodes+198/1008]
> > 
> > And the EIP is in kmem_cache_alloc_batch, sounds like it tripped on bad
> > pointer or something like this. So something is corrupting slab lists it
> > seems.
> I agree with you. Only problem is: how can I find out what caused the problem.

Probably by careful code observations.

> The only thing I can tell is that the box never hangs when using only HDs on
> the aic & 3ware controllers. As soon as I begin to use a SDLT drive on aic
> things get fishy.

You do not have reiserfs filesystem on a tape drive, right? ;)
But thhat reduces the region to review to parts thqt deal with tape devices and
tape-specific stuff, it seems.

Bye,
    Oleg
