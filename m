Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUHVJna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUHVJna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 05:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUHVJna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 05:43:30 -0400
Received: from darwin.snarc.org ([81.56.210.228]:23257 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S266613AbUHVJn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 05:43:28 -0400
Date: Sun, 22 Aug 2004 11:43:17 +0200
To: Albert Cahalan <albert@users.sf.net>
Cc: benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32 use simplified mmenonics
Message-ID: <20040822094317.GA2589@snarc.org>
References: <1093135526.5759.2513.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093135526.5759.2513.camel@cube>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040803i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 08:45:26PM -0400, Albert Cahalan wrote:
> I'd rather you went the other way, replacing these
> barely-documented instructions with ones that are
> easy to look up. Motorola has about a zillion of
> these "simplified" instructions. I guess Motorola
> and IBM were jealous of Intel's CISC instructions.
> 
> The big problem is this:
>         THESE ARE NOT IN THE INDEX!!!!!!
> 
> So, if I forget what one of these many instructions
> does, I'll have quite the time paging through the
> manual trying to find it.
> 
> If it's not in the index, please avoid it.

Well,

let's analyse 'mr R1,R2'. Which is simplified instruction for moving register,
which represent the following instruction 'or R2,0,R1'

when you read 'mr' you obviously know what the source want to do.
However seeing 'or', for my part, I see logicial or operation.
In spite of the fact, there's some case when 'or' could simply move a
register, I guess that's not as obvious as 'mr' instruction.

I guess that's the same for multiple other simplified instruction

bne target = bc 4,2,target

When I see first form, I know exactly what the program do, whereas on
the second form : What the hell is 4,2 ?

So I'ld rather go with simplified instruction, even if that index
doesn't contain them (which I agree with you, is very bad).
There are still in Appendix F of my pdf and you can search with the find
utility include in your reader (xpdf does)

-- 
Tab
