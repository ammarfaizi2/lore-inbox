Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbSJRKHz>; Fri, 18 Oct 2002 06:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSJRKHz>; Fri, 18 Oct 2002 06:07:55 -0400
Received: from ns.suse.de ([213.95.15.193]:13843 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264618AbSJRKHy>;
	Fri, 18 Oct 2002 06:07:54 -0400
Date: Fri, 18 Oct 2002 12:13:55 +0200
From: Andi Kleen <ak@suse.de>
To: Russell Coker <russell@coker.com.au>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018121355.A8804@wotan.suse.de>
References: <20021017201030.GA384@kroah.com.suse.lists.linux.kernel> <3DAFC6E7.9000302@wirex.com.suse.lists.linux.kernel> <p73wuognlox.fsf@oldwotan.suse.de> <200210181155.31274.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210181155.31274.russell@coker.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For such ports would we need to have security system calls operating in both 
> 64bit and 32bit versions?  For SE Linux half the programs that use the SE 
> system calls are specific to SE Linux (loading policy, showing or toggling 
> "enforcing mode", etc), the other half are modified versions of ls, ps, cron, 
> login, and a few other important system programs.

On most 64bit ports it is no big issue, just a nuisance. But sparc64 and 
mips64 don't have a 64bit userland, only 32bit. For these it is a showstopper.

> > Some ports even only have 32bit userland but 64bit kernel (like sparc64 or
> > mips64)
> 
> So for those ports we could have a straight 32bit interface and again have no 
> problems.

So you want to maintain an own interface for sparc64? That's identical
to an emulation layer effectively, but somewhat less maintainable.

-Andi
