Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317868AbSGWATF>; Mon, 22 Jul 2002 20:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSGWATF>; Mon, 22 Jul 2002 20:19:05 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:46979 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317868AbSGWATE>; Mon, 22 Jul 2002 20:19:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Craig Kulesa <ckulesa@as.arizona.edu>
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
Date: Mon, 22 Jul 2002 20:21:51 -0400
X-Mailer: KMail [version 1.4]
Cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Steven Cole <scole@lanl.gov>
References: <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu>
In-Reply-To: <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207222021.51600.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Kulesa wrote:

> On another note -- Steven did point out that the slablru patch has a
> patchbug with regards to dquot.c.  I think this error is also in Ed's
> June 5th patch (at least as posted), and I didn't catch it.
> I believe that:
> 
> shrink_dqcache_memory(int priority, unsigned int gfp_mask)
> needs to be
> age_dqcache_memory(kmem_cache_t *cachep, int entries, int gfp_mask)
> 
> in dquot.c.  It'll be tested and fixed on the next go. :)

Right.  Fixed  in the linux-2.4-rmap bk tree with slablru at casa.dyndns.org:3334

Thanks
Ed Tomlinson

