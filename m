Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbUKCDZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUKCDZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 22:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUKCDZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 22:25:06 -0500
Received: from cantor.suse.de ([195.135.220.2]:62593 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261370AbUKCDYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 22:24:54 -0500
Date: Wed, 3 Nov 2004 04:17:34 +0100
From: Andi Kleen <ak@suse.de>
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, roland@redhat.com, ak@suse.de
Subject: Re: [patch 1/1] ptrace POKEUSR: add comment about the DR7 check.
Message-ID: <20041103031734.GC8907@wotan.suse.de>
References: <20041102232026.6D4AE4F6D7@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102232026.6D4AE4F6D7@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 12:20:26AM +0100, blaisorblade_spam@yahoo.it wrote:
> But since the original ia32 emulation code has this comment:
> 
> 	/* You are not expected to understand this ... I don't neither. */

That was a joke, I actually went through the bits.

> 
> I am dubious that the code in ptrace32.c is wrong: does x86_64 supports
> 8byte-wide watchpoints in 32-bit emulation? I've checked the AMD manual Vol.
> 2 (no. 24593), which says that to set the length to 8 bits "long mode must be
> enabled". This means, actually, that the current code is safe, notwithstanding

Yes, it does AFAIK. "long mode" just refers to the state of the whole
system.

>  			ret = 0;
>  			break;
>  		case offsetof(struct user, u_debugreg[7]):
> +			/* See arch/i386/kernel/ptrace.c for an explaination of
> +			 * this awkward check.*/

You have a typo there.

-Andi

