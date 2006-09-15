Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWIOAT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWIOAT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 20:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWIOAT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 20:19:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932168AbWIOAT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 20:19:26 -0400
Date: Thu, 14 Sep 2006 17:19:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
In-Reply-To: <1158274508.14473.88.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609141718090.4388@g5.osdl.org>
References: <1158274508.14473.88.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Sep 2006, Benjamin Herrenschmidt wrote:
> 
> This wait is interruptible. However, we have no way to fail "gracefully"
> from no_page() if the routine we use underneath returns a failure due to
> a signal (we use, logically, -EINTR). It's a generic issue with no_page
> handlers. They can either wait non-interruptibly, or fail with a sigbus
> or oom result.

I certainly personally have nothing against adding a NOPAGE_RETRY, it 
seems very straightforward. 

		Linus
