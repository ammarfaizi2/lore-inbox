Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUGMHm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUGMHm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 03:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUGMHm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 03:42:57 -0400
Received: from colin2.muc.de ([193.149.48.15]:10245 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263540AbUGMHm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 03:42:56 -0400
Date: 13 Jul 2004 09:42:55 +0200
Date: Tue, 13 Jul 2004 09:42:55 +0200
From: Andi Kleen <ak@muc.de>
To: "Blackwood, John" <john.blackwood@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/i386|x86_64/kernel/ptrace.c linux-2.6.7
Message-ID: <20040713074254.GA41931@muc.de>
References: <40F33B35.3020209@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F33B35.3020209@ccur.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 09:30:29PM -0400, Blackwood, John wrote:
> > returned
> > value into 'ret' from the __put_user() or __get_user() calls, in the
> > same way that the arch/x86_64/ia32/ptrace32.c code does.
> > 
> > Additionally, for x86_64 only, the access_ok() size parameter should
> > really
> > be sizeof(struct user_regs_struct) instead of FRAME_SIZE, since on
> > x86_64
> > the user_regs_struct being read/written is actually a bit larger than
> > the FRAME_SIZE define.
> > 
> > 
> > Thank you.
> > 
> Sorry, I guess my diffs got new-line-botched-up.
> 
> I'll try again:

The newlines were still broken, but I applied the x86-64 part by
hand. Thanks. For i386 I guess Andrew will queue it up. 

-Andi
