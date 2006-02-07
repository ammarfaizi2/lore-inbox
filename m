Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWBGN3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWBGN3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWBGN3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:29:54 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:55178 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751041AbWBGN3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:29:53 -0500
Date: Tue, 7 Feb 2006 14:29:49 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@suse.de,
       linuxppc64-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
Message-ID: <20060207132949.GB9311@osiris.boeblingen.de.ibm.com>
References: <20060207105631.39a1080c.sfr@canb.auug.org.au> <20060206.160140.59716704.davem@davemloft.net> <20060207174017.5e3b0ce0.sfr@canb.auug.org.au> <20060207093154.GA9311@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207093154.GA9311@osiris.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Therefore I think Linus' suggestion with having something like
> 
> 	compat_fn6(sys_waitif, SARG, UARG, UARG, SARG, UARG);
> 
> would be better. Just that we would need something for pointers as well.
> And to make things just a bit more complicated: only the first five
> parameters are in registers. Number six and the following are already on
> the stack. E.g. the compat wrapper for the futex syscall would need extra
> assembly code to do conversion on the stack.
> 
> Maybe having defines like SARG1..SARG6 that would define assembly code
> instead of the register would do the job.

Ah, stupid me... the SARG define defines assembly code of course. Just
that we would need different defines for arguments that are in registers
or on the stack. Is s390 the only architecture that has argument six on
the stack?

Heiko
