Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVDIBnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVDIBnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDIBnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:43:46 -0400
Received: from mail.dif.dk ([193.138.115.101]:54672 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261243AbVDIBno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:43:44 -0400
Date: Sat, 9 Apr 2005 03:46:17 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, arjan@infradead.org, ecashin@noserose.net,
       greg@kroah.com, axboe@suse.de
Subject: Re: [PATCH] make mempool_destroy resilient against NULL pointers.
In-Reply-To: <20050408184121.0a498a3d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0504090345070.2455@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504090334490.2455@dragon.hyggekrogen.localhost>
 <20050408184121.0a498a3d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Andrew Morton wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > 
> > General rule (as I understand it) is that functions that free resources 
> > should handle being passed NULL pointers - mempool_destroy() will 
> > currently explode if passed a NULL pointer, the patch below makes it safe 
> > to pass it NULL.
> 
> The best response to mempool_destroy(0) is an oops.  There's no legitimate
> reason for doing it.
> 
Ok, ignore the patch then.

-- 
Jesper


