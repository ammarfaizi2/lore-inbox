Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTDXCeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTDXCeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:34:00 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:35530 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263525AbTDXCd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:33:59 -0400
Date: Wed, 23 Apr 2003 19:45:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: BK->CVS, kernel.bkbits.net
Message-ID: <20030424024549.GA10840@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Neil Brown <neilb@cse.unsw.edu.au>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <20030417162723.GA29380@work.bitmover.com> <b7n46e$dtb$1@cesium.transmeta.com> <20030420003021.GA10547@work.bitmover.com> <16035.30645.648954.185797@notabene.cse.unsw.edu.au> <3EA6B61B.7030303@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA6B61B.7030303@gmx.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 05:49:47PM +0200, Carl-Daniel Hailfinger wrote:
> > % time bk pull
> > ....
> > 444.95user 42.29system 49:09.46elapsed 16%CPU (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (326737major+196385minor)pagefaults 0swaps
> > 
> > 
> > % time cvs update
> > .....
> > 2.78user 1.94system 4:12.36elapsed 1%CPU (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (333major+7240minor)pagefaults 0swaps

Fast or safe, pick one.  CVS has no integrity check and you will never know
if you have bad data or not.  And the BK checks find el cheapo memory dimms
and all sorts of other problems all the time.  It even found a cache aliasing
bug in SPARC/Linux...

The BK integrity check will tell you right away if any of your data is bad.
*Everyone* hates the check until it saves their butt and then they decide
it's not such a bad idea.  It's a lot like a seatbelt - you don't like it
until something goes wrong.

BK != CVS.  You want fast and loose, by all means, use CVS, that's not our
intended market and we don't care about fast where fast means bad data.

> > That is an order of magnitude difference in wall-clock time!  This is
> > on my humble notebook with "only" 128Meg of RAM.  The delay is mostly 
> > in the consistency checking.  Sure there is a way to turn that off.
> 
> Just add this line to your /etc/BitKeeper/etc/config:
> []partial_check:yes!
> 
> and you should notice a big speedup.
> 
> P.S. If anyone knows other speedup tricks for a kernel tree in bk,
> please tell me.

Mount the file system with noatime.

Buy enough memory to fit the kernel in memory and on a 1Ghz processor that
pull will take about 20 seconds.  Even laptop memory is pretty cheap these
days.  Pricewatch says $80 for .5GB for laptops, that's cheap.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
