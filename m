Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVAMSyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVAMSyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVAMRGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:06:20 -0500
Received: from verein.lst.de ([213.95.11.210]:42881 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261216AbVAMRFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:05:43 -0500
Date: Thu, 13 Jan 2005 18:05:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dwmw2@infradead.org
Subject: Re: [PATCH] kill symbol_get & friends
Message-ID: <20050113170528.GA24590@lst.de>
References: <20050112203136.GA3150@lst.de> <1105575573.12794.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105575573.12794.27.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 11:19:33AM +1100, Rusty Russell wrote:
> If you don't hold a reference, then yes, the module can go away.  This
> hasn't been a huge problem for users in the past.

There's a single users, and it has these problems.

> The lack of users is because, firstly, dynamic dependencies are less
> common than static ones, and secondly because the remaining inter-module
> users (AGP and mtd) have not been converted.

AGP doesn't use dynamic symbols anymore, only mtd is gone.  And I'd
rather see it not switching to symbol_get.

