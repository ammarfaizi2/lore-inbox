Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWHCX4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWHCX4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWHCX4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:56:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31672
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030230AbWHCX4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:56:52 -0400
Date: Thu, 03 Aug 2006 16:56:54 -0700 (PDT)
Message-Id: <20060803.165654.45876296.davem@davemloft.net>
To: tytso@mit.edu
Cc: mchan@broadcom.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060803235326.GC7894@thunk.org>
References: <20060803201741.GA7894@thunk.org>
	<20060803.144845.66061203.davem@davemloft.net>
	<20060803235326.GC7894@thunk.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Tso <tytso@mit.edu>
Date: Thu, 3 Aug 2006 19:53:26 -0400

> Any suggestions on how I could figure out what was really going on and
> what would be a better fix would be greatly appreciated.

As Michael explained, it's the ASF heartbeat sent by tg3_timer() that
must be delivered to the chip within certain timing constraints.

If you had any watchdog devices on this machine, they would likely
trigger too and reset your machine :)
