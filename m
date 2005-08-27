Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVH0CtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVH0CtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 22:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbVH0CtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 22:49:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21404
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030277AbVH0CtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 22:49:08 -0400
Date: Fri, 26 Aug 2005 19:49:05 -0700 (PDT)
Message-Id: <20050826.194905.11108278.davem@davemloft.net>
To: ak@suse.de
Cc: rml@novell.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <p73vf1skt0g.fsf@verdi.suse.de>
References: <20050826225848.GC28191@mipter.zuzino.mipt.ru>
	<20050826.161537.03992270.davem@davemloft.net>
	<p73vf1skt0g.fsf@verdi.suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: 27 Aug 2005 04:34:07 +0200

> "David S. Miller" <davem@davemloft.net> writes:
> 
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Sat, 27 Aug 2005 02:58:48 +0400
> > 
> > > What's the point of having unlikely() attached to every possible if ()?
> > 
> > If can result in smaller code, for one thing, even if it
> > isn't a performance critical path.
> 
> Really? At least on x86 it tends to generate bigger code when 
> block reordering is enabled because a jump forward and a jump
> backward and a possible label alignment are bigger than just
> a single jump forward.

In the cases I've studied on sparc64 it keeps gcc from doing basic
block replication in the unlikely paths.

I've only checked gcc-3.4 and earlier, gcc-4.x is just big bloated
useless garbage and should be avoided for a couple of years.
