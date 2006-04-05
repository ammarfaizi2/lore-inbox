Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWDEBBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWDEBBv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWDEBBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:01:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61107
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750897AbWDEBBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:01:51 -0400
Date: Tue, 04 Apr 2006 17:47:41 -0700 (PDT)
Message-Id: <20060404.174741.63557413.davem@davemloft.net>
To: rdreier@cisco.com
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       openib-general@openib.org, bunk@stusta.de, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mst@mellanox.co.il,
       rolandd@cisco.com
Subject: Re: [patch 11/26] IPOB: Move destructor from neigh->ops to
 neigh_param
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adamzf0n98z.fsf@cisco.com>
References: <adar74cnajg.fsf@cisco.com>
	<20060404.171739.92845421.davem@davemloft.net>
	<adamzf0n98z.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 04 Apr 2006 17:42:20 -0700

>     David> You were using an interface in an unintended way.
> 
> There were a lot of opportunities to suggest a better way or even just
> raise the alarm when IPoIB was first being reviewed.  And I don't
> remember anyone giving any guidance or insight into the neighbour
> destructor design the three or four times Michael raised the issue of
> the IPoIB crash and posted this patch for review....

If I thought your change was appropriate for 2.6.16 I would have put
it into that tree back then.  Instead, I did not consider it
appropriate, that's why we decided to put it into 2.6.17

Nothing since then has changed the situation.

> If this patch is too risky for -stable, that's fine.  But let's be
> clear that it _does_ fix a panic people hit in practice, and as far as
> I know it doesn't break the ATM build

I think it's too risky.  It fixes a panic for infiniband.

I think you should not have submitted such a core networking change to
-stable without passing it by netdev CC:'ing me first.
