Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVCTWbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVCTWbL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVCTWbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:31:11 -0500
Received: from p3EE2BB7C.dip.t-dialin.net ([62.226.187.124]:48256 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261311AbVCTWbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:31:03 -0500
Date: Fri, 18 Mar 2005 22:56:40 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, Yoichi Yuasa <yuasa@hh.iij4u.or.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][resend] convert a remaining verify_area to access_ok (was: Re: [PATCH 2.6.11-mm1] mips: more convert verify_area to access_ok) (fwd)
Message-ID: <20050318225640.GA4817@linux-mips.org>
References: <Pine.LNX.4.62.0503162227270.2558@dragon.hyggekrogen.localhost> <20050317214302.GA14882@linux-mips.org> <Pine.LNX.4.62.0503180109490.2512@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503180109490.2512@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 01:17:47AM +0100, Jesper Juhl wrote:

> I hope I did a descent job and that you didn't waste too much time 
> duplicating effort...

Didn't look too hard at it since my patch of something like 2,500 lines
should be a superset of yours.

> > The last instance of verify_area() in the MIPS code is now the definition
> > itself.
> > 
> The plan is to wait for a few months (or a few kernel releases - whichever 
> comes first) and then I'll send Andrew patches to remove it completely.
> There are still a few related nits left, like the FPU_verify_area function 
> arch/i386/math-emu/reg_ld_str.c and the rw_verify_area function in 
> fs/read_write.c that I want to get out of the way first (think I'll 
> probably end up attempting to rename those s/verify_area/access_ok/ and 
> see if people scream).

Access_ok was introduced in 2.1.4.  Easy for people to write code that's
portable and so verify_area should die a peaceful death.

  Ralf
