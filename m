Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTJWNlR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 09:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTJWNlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 09:41:17 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:36857 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263573AbTJWNlQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 09:41:16 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Joseph D. Wagner" <theman@josephdwagner.info>,
       Dave Jones <davej@redhat.com>
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Date: Thu, 23 Oct 2003 08:40:51 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <200310221855.15925.theman@josephdwagner.info> <20031023012350.GI26476@redhat.com> <200310222135.22968.theman@josephdwagner.info>
In-Reply-To: <200310222135.22968.theman@josephdwagner.info>
MIME-Version: 1.0
Message-Id: <03102308405100.10491@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 October 2003 10:35, Joseph D. Wagner wrote:
[snip]
> > Your proposed change is in part already vetoed (for sound reasons)
> > for 2.4, and is already included in the development branch
> > (where such a far-reaching change should be tested). The other part
> > of your proposal is completely bogus as far as the kernel is concerned.
>
> I respectivly disagree with those reasons.  -march is gcc flag.  If it
> creates any instability (doubtful), it's really a gcc problem.  Throwing it
> in will light a fire under their @$$ to get their act together.

Based on past history of the compiler, it will have no effect. Frequently
the Kernel compile flags have had to wait a year or two before corrections
to the compiler get entered.

Or do you mean to have the kernel be MIS-compiled for a couple of years?

The change in gcc versions is what determines the changes in the compile
flags.

Try your change out. Create/use floating point in the kernel if you want.

One suggestion - for maximum effect, replace the process scheduler with
a full fair-share sheduler, with full weight computation in the kernel.
Since this calls for a small amount of floating point on each iteration,
any problems should show up quickly. Sure, it will be slow, but it will
provide a lot of testing.

Another place to have fun (if you have a GPS reciever attached), put a
small navigation module in the kernel. (use a laptop...). This uses a
LOT of floating point math. This is normally done in user mode for that
reason.

If everything appears to work as you think, no errors due to the compiler,
then submit a patch to LKML (maybe even include the navigator as another
patch). If it doesn't, try to get the GCC project to fix the problem.
