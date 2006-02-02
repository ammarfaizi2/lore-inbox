Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423007AbWBBGME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423007AbWBBGME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423094AbWBBGME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:12:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423007AbWBBGMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:12:03 -0500
Date: Wed, 1 Feb 2006 22:11:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] compat: fix compat_sys_openat and friends
In-Reply-To: <20060202170523.3ee85519.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0602012211320.21884@g5.osdl.org>
References: <20060202161151.58839ffd.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0602012134150.21884@g5.osdl.org> <20060201.215644.116024082.davem@davemloft.net>
 <20060202170523.3ee85519.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Feb 2006, Stephen Rothwell wrote:
> 
> Yes, that is it.  I have tried using "long" and "unsigned int" for those
> first parameters and it produces exactly the same assembler output on
> ppc64 and x86_64.  Everywhere else that we have a file descriptor argument
> to a compat syscall function it is declared "unsigned int".
> 
> And for these compat functions, alpha is irrelevent of course. :-)

Fair enough. Applied.

		Linus
