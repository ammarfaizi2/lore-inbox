Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVHDQ3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVHDQ3f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVHDQ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:29:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6673 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262541AbVHDQ3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:29:33 -0400
Date: Thu, 4 Aug 2005 17:29:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alexander Nyberg <alexn@telia.com>, Linus Torvalds <torvalds@osdl.org>,
       Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-ID: <20050804172920.H32154@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Alexander Nyberg <alexn@telia.com>,
	Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
	Andi Kleen <ak@suse.de>
References: <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org> <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org> <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org> <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com> <42F09B41.3050409@yahoo.com.au> <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org> <20050804141457.GA1178@localhost.localdomain> <42F2266F.30008@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42F2266F.30008@yahoo.com.au>; from nickpiggin@yahoo.com.au on Fri, Aug 05, 2005 at 12:30:07AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:30:07AM +1000, Nick Piggin wrote:
> Alexander Nyberg wrote:
> > On Wed, Aug 03, 2005 at 09:12:37AM -0700 Linus Torvalds wrote:
> > 
> > 
> >>
> >>Ok, I applied this because it was reasonably pretty and I liked the 
> >>approach. It seems buggy, though, since it was using "switch ()" to test 
> >>the bits (wrongly, afaik), and I'm going to apply the appended on top of 
> >>it. Holler quickly if you disagreee..
> >>
> > 
> > 
> > x86_64 had hardcoded the VM_ numbers so it broke down when the numbers
> > were changed.
> > 
> 
> Ugh, sorry I should have audited this but I really wasn't expecting
> it (famous last words). Hasn't been a good week for me.
> 
> parisc, cris, m68k, frv, sh64, arm26 are also broken.
> Would you mind resending a patch that fixes them all?

ARM as well - fix is pending Linus pulling my tree...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
