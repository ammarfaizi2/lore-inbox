Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTEGNog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTEGNog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:44:36 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:36043 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263195AbTEGNof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:44:35 -0400
Date: Wed, 7 May 2003 15:56:57 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507135657.GC18177@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0305070933450.11740@chaos>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 09:45:13 -0400, Richard B. Johnson wrote:
> 
> You know (I hope) that allocating stuff on the stack is not
> "bad". In fact, it's the quickest way to allocate data that
> will automatically go away when the function returns. One
> just subtracts a value from the stack-pointer and you have
> the data area. I sure hope that these temporary allocations
> are not being replaced with kmalloc()/kfree(). If so, the
> code is badly broken and you are eating my CPU cycles for
> nothing.

Agreed, partially. There is the current issue of the kernel stack
being just 8k in size and no decent mechanism in place to detect a
stack overflow. And there is (arguably) the future issue of the kernel
stack shrinking to 4k.

Stuff like intermezzo will break with 4k, no discussion about that.
Other stuff may or may not work. What I'm trying to do is pave the way
to shrink the kernel stack during 2.7 sometime.

If there is large agreement that the kernel stack should not shrink,
I'll stop this effort any day. But so far, I am under the impression
that the agreement is to do the shink. Am I wrong?

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
