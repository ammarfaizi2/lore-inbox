Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVAMInV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVAMInV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVAMInU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:43:20 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:48586 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261302AbVAMInQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:43:16 -0500
Subject: Re: [PATCH] kill symbol_get & friends
From: David Woodhouse <dwmw2@redhat.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e997050112165935b89a27@mail.gmail.com>
References: <20050112203136.GA3150@lst.de>
	 <1105575573.12794.27.camel@localhost.localdomain>
	 <21d7e997050112165935b89a27@mail.gmail.com>
Content-Type: text/plain
Organization: Red Hat UK Ltd.
Date: Thu, 13 Jan 2005 08:42:59 +0000
Message-Id: <1105605779.30759.76.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 11:59 +1100, Dave Airlie wrote:
> what weak symbol support? can I actually use gcc weak symbols and have
> it all work?

Weak undefined symbols used to work, certainly. The MTD code used them
for a while, before kaos imposed the inter_module_crap on it despite my
objections.

> what happens if the module goes away? 

If another module is using a weak symbol, IIRC the module providing the
symbol _can't_ go away. I could be wrong -- I didn't use that
functionality. I was using get_symbol() and I added put_symbol() so I
could explicitly refcount it. 

-- 
dwmw2


