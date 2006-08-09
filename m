Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWHIBig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWHIBig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWHIBig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:38:36 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10726
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030405AbWHIBif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:38:35 -0400
Date: Tue, 08 Aug 2006 18:38:08 -0700 (PDT)
Message-Id: <20060808.183808.74747814.davem@davemloft.net>
To: phillips@google.com
Cc: shemminger@osdl.org, a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: David Miller <davem@davemloft.net>
In-Reply-To: <44D93B60.7030507@google.com>
References: <20060808193345.1396.16773.sendpatchset@lappy>
	<20060808135721.5af713fb@localhost.localdomain>
	<44D93B60.7030507@google.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Phillips <phillips@google.com>
Date: Tue, 08 Aug 2006 18:33:20 -0700

> Minor rant: the whole skb_alloc familly has degenerated into an unholy
> mess and could use some rethinking.  I believe the current patch gets as
> far as three _'s at the beginning of a function, this shows it is high
> time to reroll the api.

I think it is merely an expression of how dynamic are the operations
that people want to perform on SKBs, and how important it is for
performance to implement COW semantics for the data.
