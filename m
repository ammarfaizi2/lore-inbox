Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268236AbTAMG7z>; Mon, 13 Jan 2003 01:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268267AbTAMG7z>; Mon, 13 Jan 2003 01:59:55 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:46989 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S268236AbTAMG7t>; Mon, 13 Jan 2003 01:59:49 -0500
Date: Mon, 13 Jan 2003 00:49:40 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.56-bug
Message-ID: <20030113004940.K628@nightmaster.csn.tu-chemnitz.de>
References: <E18Xh1V-0000R7-00@raistlin.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E18Xh1V-0000R7-00@raistlin.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Jan 12, 2003 at 12:15:29PM +0000
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18Xyi4-0007Sd-00*ayV6tl2w7/U*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,
Hi LKML,

On Sun, Jan 12, 2003 at 12:15:29PM +0000, Russell King wrote:
> This patch appears not to be in 2.5.56, but applies cleanly.
> 
> This patch moves BUG() and PAGE_BUG() from asm/page.h into asm/bug.h.

While we are at it: BUG() expects the offending task to be killed
so implementations, which just do a printk() there are
non-conforming.

Code paths which contain BUG() or BUG_ON() usally expect this
code-path to end and just threat the opposite condition to be
true.

A conforming implementation is panic(), if faulting is not that
easy in these architectures, but printk() is just plain wrong.

Mind to get a patch on top of your doing exactly this
modification?

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
