Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSKVTry>; Fri, 22 Nov 2002 14:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSKVTry>; Fri, 22 Nov 2002 14:47:54 -0500
Received: from bitmover.com ([192.132.92.2]:48306 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262380AbSKVTrx>;
	Fri, 22 Nov 2002 14:47:53 -0500
Date: Fri, 22 Nov 2002 11:54:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
Message-ID: <20021122115454.A481@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
	"David S. Miller" <davem@redhat.com>, ak@muc.de
References: <20021122162312.32ff4bd3.sfr@canb.auug.org.au> <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211221141070.1440-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Nov 22, 2002 at 11:47:27AM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Make your compat stuff use u32/s32/u64 directly, instead of making up ugly 
> new types that make no sense.

IMHO, the thing that the early Unix systems did wrong was to not have 
u8, u16, u32, etc as basic ctypes in sys/types.h.  And C should have 
had a way to fake it if they weren't native.

Anyone who has ported a networking stack or worked on driver knows exactly
what I'm talking about.

And while I'm whining, 

	assert(strlen(any typedef) < 8));

I like my stack variable declarations to line up.  I despise some_long_name_t
typedefs with a passion.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
