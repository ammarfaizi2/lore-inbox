Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWJBUhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWJBUhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWJBUhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:37:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36291
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965002AbWJBUhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:37:00 -0400
Date: Mon, 02 Oct 2006 13:37:15 -0700 (PDT)
Message-Id: <20061002.133715.63105344.davem@davemloft.net>
To: jeff@garzik.org
Cc: jengelh@linux01.gwdg.de, kkeil@suse.de, kai.germaschewski@gmx.de,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ISDN: mark as 32-bit only
From: David Miller <davem@davemloft.net>
In-Reply-To: <45208D82.8010606@garzik.org>
References: <20061001152116.GA4684@havoc.gtf.org>
	<Pine.LNX.4.61.0610012007240.13920@yvahk01.tjqt.qr>
	<45208D82.8010606@garzik.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Sun, 01 Oct 2006 23:54:42 -0400

> Jan Engelhardt wrote:
> >> Tons of ISDN drivers cast pointers to/from 32-bit values, which just
> >> won't work on 64-bit.
> > 
> > Should not that be fixed instead of restricting isdn to 32bit?
> 
> It hasn't been fixed in many years, and I don't see anyone stepping up 
> to the plate, even with my current trolling...  :)
> 
> > Though this is probably the best temporary workaround until someone can 
> > fix up all the "tons".
> 
> I have a better workaround, I think.

I totally agree with Jeff.  The ISDN layer is effectively unmaintained
and the vast majority of the ISDN work that does actually occur is
done out-of-tree.

If someone cares enough about the ISDN layer, they can make changes
after Jeff's goes in to reduce the protection to a per-driver basis.

But right now, blocking this whole unmaintained pile of poo on 64-bit
is the best starting point.

We're talking about effectively an 8 year old code base that hasn't
been touched much at all during that time.  Let's be honest about the
situation.  The only subsystem that is more unmaintained and gathering
dust is probably the ftape layer :-)


