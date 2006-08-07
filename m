Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWHGGSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWHGGSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWHGGSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:18:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53425
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751102AbWHGGSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:18:47 -0400
Date: Sun, 06 Aug 2006 23:18:46 -0700 (PDT)
Message-Id: <20060806.231846.71090637.davem@davemloft.net>
To: rostedt@goodmis.org
Cc: tytso@mit.edu, mchan@broadcom.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0608070124340.15870@gandalf.stny.rr.com>
References: <20060803.144845.66061203.davem@davemloft.net>
	<20060803235326.GC7894@thunk.org>
	<Pine.LNX.4.58.0608070124340.15870@gandalf.stny.rr.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 7 Aug 2006 01:34:56 -0400 (EDT)

> My suggestion would be to separate that tg3_timer into 4 different
> timers, which is what it actually looks like.

Timers have non-trivial cost.  It's cheaper to have one and
vector off to the necessary operations each tick internalls.

That's why it's implemented as one timer.
