Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVAZIkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVAZIkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVAZIkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:40:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28551 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262391AbVAZIkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:40:17 -0500
Date: Wed, 26 Jan 2005 09:40:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050126084005.GB2751@suse.de>
References: <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org> <1106528219.867.22.camel@boxen> <20050124204659.GB19242@suse.de> <20050124125649.35f3dafd.akpm@osdl.org> <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org> <20050126080152.GA2751@suse.de> <20050126001113.30933eef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126001113.30933eef.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26 2005, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > But the 2.6.11-rcX vm is still very
> >  screwy, to get something close to nice and smooth behaviour I have to
> >  run a fillmem every now and then to reclaim used memory.
> 
> Can you provide more details?

Hmm not really, I just seem to have a very large piece of
non-cache/buffer memory that seems reluctant to shrink on light memory
pressure. This makes the box feel sluggish, if I force reclaim by
running fillmem and swapping on/off again, it feels much better.

I should mention that this is with 2.6.bk + andreas oom patches that he
asked me to test. I can try 2.6.11-rc2-bkX if you think I should.

-- 
Jens Axboe

