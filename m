Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFAXdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFAXdy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFAXcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:32:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24220
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261490AbVFAXX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:23:59 -0400
Date: Wed, 01 Jun 2005 16:23:21 -0700 (PDT)
Message-Id: <20050601.162321.58454567.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: jschopp@austin.ibm.com, mel@csn.ul.ie, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy
 Version 12
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <429E4023.2010308@yahoo.com.au>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie>
	<429E20B6.2000907@austin.ibm.com>
	<429E4023.2010308@yahoo.com.au>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Thu, 02 Jun 2005 09:09:23 +1000

> It adds a lot of complexity to the page allocator and while
> it might be very good, the only improvement we've been shown
> yet is allocating lots of MAX_ORDER allocations I think? (ie.
> not very useful)

I've been silently sitting back and considering how much this kind of
patch could help with page coloring, all existing implementations of
which fall apart due to buddy allocator fragmentation issues.
