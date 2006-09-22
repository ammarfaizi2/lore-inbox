Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWIVKK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWIVKK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 06:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWIVKK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 06:10:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57999 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750702AbWIVKK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 06:10:28 -0400
Subject: Re: 2.6.19 -mm merge plans
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net
In-Reply-To: <1158917046.24527.662.camel@pmac.infradead.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	 <1158917046.24527.662.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 11:10:01 +0100
Message-Id: <1158919801.24527.668.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 10:24 +0100, David Woodhouse wrote:
> On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:
> > 
> > mtd-maps-ixp4xx-partition-parsing.patch
> > fix-the-unlock-addr-lookup-bug-in-mtd-jedec-probe.patch
> > mtd-printk-format-warning.patch
> > fs-jffs2-jffs2_fs_ih-removal-of-old-code.patch
> > drivers-mtd-nand-au1550ndc-removal-of-old-code.patch
> > 
> >  MTD queue -> dwmw2
> 
> Merged, with the exception of the unlock addr one which I'm still not
> sure about -- about to investigate harder.

I just reverted Randy's printk format 'fix', since rq->flags _is_ an
unsigned long, so changing from %ld to %d actually _introduces_ a
warning.

Randy, that's the second time I recall recently that I've ended up
reverting a printk format fix from you -- what are you doing? How did
you manage to get the warning you reported:

drivers/mtd/mtd_blkdevs.c:72: warning: long int format, different type arg (arg 2)


-- 
dwmw2

