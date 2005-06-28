Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVF1FIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVF1FIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVF1FIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:08:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9915
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262533AbVF1FIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:08:44 -0400
Date: Mon, 27 Jun 2005 22:08:27 -0700 (PDT)
Message-Id: <20050627.220827.21920197.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 2] mm: speculative get_page
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42C0D717.2080100@yahoo.com.au>
References: <42C0AAF8.5090700@yahoo.com.au>
	<20050628040608.GQ3334@holomorphy.com>
	<42C0D717.2080100@yahoo.com.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 2] mm: speculative get_page
Date: Tue, 28 Jun 2005 14:50:31 +1000

> William Lee Irwin III wrote:
> 
> >On Tue, Jun 28, 2005 at 11:42:16AM +1000, Nick Piggin wrote:
> >
> >spin_unlock() does not imply a memory barrier.
> >
> 
> Intriguing...

BTW, I disagree with this assertion.  spin_unlock() does imply a
memory barrier.

All memory operations before the release of the lock must execute
before the lock release memory operation is globally visible.
