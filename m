Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUHaXuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUHaXuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269171AbUHaXtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:49:01 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:22915 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261451AbUHaXjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:39:25 -0400
Date: Wed, 1 Sep 2004 00:39:24 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DRM initial function table support.
In-Reply-To: <20040831152015.GC22978@redhat.com>
Message-ID: <Pine.LNX.4.58.0409010033370.31241@skynet>
References: <Pine.LNX.4.58.0408311409530.18657@skynet> <20040831152015.GC22978@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I like this. Lots.
> Mostly because of this..
>
> (16:14:11:davej@delerium:~)$ grep ^-# foo.diff  | wc -l
> 87

You think that one is good
 grep ^-# current_diffs | wc -l
496

is for my current CVS tree vs the in-kernel DRM ;-),

> 	.preinit = gamma_driver_preinit,
> 	.pretakedown = gamma_driver_pretakedown,
> 	.dma_ready = gamma_driver_dma_ready,
> 	.dma_quiescent = gamma_driver_dma_quiescent,
> 	.dma_flush_block_and_flush = gamma_flush_block_and_flush,
> 	.dma_flush_unblock = gamma_flush_unblock,
> };

With this patch it would be okay, with some of the functions I added to
the table later, I had to set some defaults before calling the driver
function, and also added another setting for AGP/MTRR type stuff to the
device independent structure that needed to be set, I'll try and get the
rest of the patches for macro removal merged up and then perhaps you could
take a look at it (or take a look at CVS now) and we can cleanup the style
if we still think it is necessary.. btw the setting ptrs in a fn table is
the DRI/Mesa way of doing things .. so we have a bit of where two worlds
collide... :-)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

