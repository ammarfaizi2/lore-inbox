Return-Path: <linux-kernel-owner+w=401wt.eu-S933115AbWLaKEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115AbWLaKEv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 05:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933114AbWLaKEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 05:04:51 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39262
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933110AbWLaKEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 05:04:49 -0500
Date: Sun, 31 Dec 2006 02:04:46 -0800 (PST)
Message-Id: <20061231.020446.39159713.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: arjan@infradead.org, torvalds@osdl.org, miklos@szeredi.hu,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061231100007.GC1702@flint.arm.linux.org.uk>
References: <1167557242.20929.647.camel@laptopd505.fenrus.org>
	<20061231.014756.112264804.davem@davemloft.net>
	<20061231100007.GC1702@flint.arm.linux.org.uk>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sun, 31 Dec 2006 10:00:07 +0000

> I'm willing to do that - and I guess this means we can probably do this
> instead of walking the list of VMAs for the shared mapping, thereby
> hitting both anonymous and shared mappings with the same code?

That's pretty much the idea.

BTW, I was in a similar boat as you on sparc 32-bit in the
pre-RMAP days, I was able to walk the VMA's for stuff
with a mapping but couldn't handle anonymous stuff very
well.
