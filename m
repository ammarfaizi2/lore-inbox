Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUHVTRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUHVTRd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 15:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUHVTRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 15:17:33 -0400
Received: from darwin.snarc.org ([81.56.210.228]:4816 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S268069AbUHVTRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 15:17:30 -0400
Date: Sun, 22 Aug 2004 21:17:27 +0200
To: Albert Cahalan <albert@users.sf.net>
Cc: benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32 use simplified mmenonics
Message-ID: <20040822191727.GB12014@snarc.org>
References: <1093135526.5759.2513.camel@cube> <20040822094317.GA2589@snarc.org> <1093171291.5759.2544.camel@cube> <20040822144501.GA10017@snarc.org> <1093178422.2301.2674.camel@cube> <20040822162845.GA10911@snarc.org> <1093184939.2301.2799.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093184939.2301.2799.camel@cube>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040803i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 10:29:00AM -0400, Albert Cahalan wrote:
> That comes to 2304. Subtract the 456 "simplified"
> instruction names you have. That leaves 1848 that
> you are unable to access.
> 
> Take a look at the crand instruction. It uses numbers.
> Now, just imagine mixing that with branch instructions
> that hide the numbers. I hope you see the problem.

I never said we should use simplified instructions everywhere there are
instructions. Hence I don't see why we care here about 1848 instructions
not beeing accessible. Most of thoses 1848 instructions probably fit in the
'not so much' used, and thus doesn't need a simplified mmenonic.

> It doesn't appear to be so. He wrote:
> 
> : Oh well.. I've got quite used to tweaking rlwinm directly
> : but I suppose it's more clear for others to go to clrrwi.
> 
> So I'd like him to know that others like rlwinm directly too.

sure.

and some other prefer simplified instructions. I guess we're hitting a
wall here :)

But as clrrwi is already use in the kernel (as a lot of others simplified
instructions), either send a patch to remove them or don't say that this
is madness.

> Using instructions that are in the index makes sense.
> Using a zillion poorly documented alternatives is madness.

Maybe then you should rewrite all part of kernels, gcc, objdump and gdb that
use/disassemble the code with simplified instructions (mr, li, b*, etc...) too.
(clrrwi is as documented as mr)

-- 
Tab
