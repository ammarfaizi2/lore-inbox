Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWHIBm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWHIBm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWHIBm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:42:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13798
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030410AbWHIBm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:42:28 -0400
Date: Tue, 08 Aug 2006 18:41:44 -0700 (PDT)
Message-Id: <20060808.184144.71088399.davem@davemloft.net>
To: phillips@google.com
Cc: a.p.zijlstra@chello.nl, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: David Miller <davem@davemloft.net>
In-Reply-To: <44D93BEE.4000001@google.com>
References: <20060808193345.1396.16773.sendpatchset@lappy>
	<20060808.151020.94555184.davem@davemloft.net>
	<44D93BEE.4000001@google.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Phillips <phillips@google.com>
Date: Tue, 08 Aug 2006 18:35:42 -0700

> David Miller wrote:
> > I think the new atomic operation that will seemingly occur on every
> > device SKB free is unacceptable.
> 
> Alternate suggestion?

Sorry, I have none.  But you're unlikely to get your changes
considered seriously unless you can avoid any new overhead your patch
has which is of this level.

We're busy trying to make these data structures smaller, and eliminate
atomic operations, as much as possible.  Therefore anything which adds
new datastructure elements and new atomic operations will be met with
fierce resistence unless it results an equal or greater shrink of
datastructures elsewhere or removes atomic operations elsewhere in
the critical path.
