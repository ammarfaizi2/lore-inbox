Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317853AbSGVWOu>; Mon, 22 Jul 2002 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSGVWOu>; Mon, 22 Jul 2002 18:14:50 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:397 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317853AbSGVWOt>; Mon, 22 Jul 2002 18:14:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Steven Cole <elenstev@mesatop.com>, Craig Kulesa <ckulesa@as.arizona.edu>
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
Date: Mon, 22 Jul 2002 18:17:50 -0400
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Steven Cole <scole@lanl.gov>,
       William Lee Irwin III <wli@holomorphy.com>
References: <Pine.LNX.4.44.0207210245080.6770-100000@loke.as.arizona.edu> <1027364068.12588.26.camel@spc9.esa.lanl.gov>
In-Reply-To: <1027364068.12588.26.camel@spc9.esa.lanl.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207221817.50128.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On July 22, 2002 02:54 pm, Steven Cole wrote:
> On Sun, 2002-07-21 at 05:24, Craig Kulesa wrote:
> > This is an update for the 2.5 port of Ed Tomlinson's patch to move slab
> > pages onto the lru for page aging, atop 2.5.27 and the full rmap patch.
> > It is aimed at being a fairer, self-tuning way to target and evict slab
> > pages.
> >
> > Previous description:
> > 	http://mail.nl.linux.org/linux-mm/2002-07/msg00216.html
> > Patch URL:
> > 	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.27/
>
> While trying to boot 2.5.27-rmap-slablru, I got this early in the boot:
>
> Kernel panic: Failed to create pte-chain mempool!
> In idle task - not syncing

This is not the result of slablru (rmap yes), rather it looks to be what Andrew Morton 
was worried about in the "Re: pte_chain_mempool-2.5.27-1" thread.  Looks like 
the chunk of continous memory need for the pte_change_mempool cannot be 
obtained...

Ed Tomlinson
