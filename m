Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVCRAQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVCRAQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVCRAQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:16:17 -0500
Received: from mail.dif.dk ([193.138.115.101]:38283 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261397AbVCRAQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:16:14 -0500
Date: Fri, 18 Mar 2005 01:17:47 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][resend] convert a remaining verify_area to access_ok
 (was: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok)
 (fwd)
In-Reply-To: <20050317214302.GA14882@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0503180109490.2512@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost>
 <20050317214302.GA14882@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Ralf Baechle wrote:

> On Wed, Mar 16, 2005 at 10:35:09PM +0100, Jesper Juhl wrote:
> 
> > Around 2.6.11-mm1 Yoichi Yuasa found a user of verify_area that I had 
> > missed when converting everything to access_ok. The patch below still 
> > applies cleanly to 2.6.11-mm4.
> > Please apply (unless of course you already picked it up back then and 
> > have it in a queue somewhere :) .
> 
> Oh gosh, you actually converted the whole IRIX compatibility mess even,
> amazing stomach you have :-) I only noticed that when I just looked at
> Linus' tree - after buring a few hours into cleaning those files myself -
> mine are now almost free of sparse warnings.
> 
I hope I did a descent job and that you didn't waste too much time 
duplicating effort...

> The last instance of verify_area() in the MIPS code is now the definition
> itself.
> 
The plan is to wait for a few months (or a few kernel releases - whichever 
comes first) and then I'll send Andrew patches to remove it completely.
There are still a few related nits left, like the FPU_verify_area function 
arch/i386/math-emu/reg_ld_str.c and the rw_verify_area function in 
fs/read_write.c that I want to get out of the way first (think I'll 
probably end up attempting to rename those s/verify_area/access_ok/ and 
see if people scream).


-- 
Jesper


