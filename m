Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbUL0RVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUL0RVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 12:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUL0RVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 12:21:45 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:59035 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261936AbUL0RVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 12:21:40 -0500
Date: Mon, 27 Dec 2004 18:21:34 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-mtd <linux-mtd@lists.infradead.org>,
       David Woodhouse <dwmw2@redhat.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wh.fh-wedel.de>,
       Greg Ungerer <gerg@snapgear.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove unnessesary casts from drivers/mtd/maps/nettel.c and kill two warnings
Message-ID: <20041227172134.GB16025@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.61.0412262202510.3552@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0412262202510.3552@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 December 2004 22:13:48 +0100, Jesper Juhl wrote:
> 
> I took a look at the cause for these warnings in the 2.6.10 kernel,
> 
> drivers/mtd/maps/nettel.c:361: warning: assignment makes pointer from integer without a cast
> drivers/mtd/maps/nettel.c:395: warning: assignment makes pointer from integer without a cast
> 
> and as far as I can see the casts in there (to unsigned long and back to 
> void*) are completely unnessesary ('virt' in 'struct map_info' is a void 
> __iomem *), and getting rid of those casts buys us a warning free build.
> 
> Are there any reasons not to apply the patch below?
> Unfortunately I don't have hardware to test this patch, so it has been 
> compile tested only.

Neither do I, but the patch looks fine to me.  Give Greg a grace
period, in case he knows better.  And interpret this as a personal
opinion, not as dwmw2's final word.

If it helps:
Acked-by: Jörn Engel <joern@wh.fh-wedel.de>

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
