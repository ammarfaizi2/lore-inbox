Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288008AbSAMIDM>; Sun, 13 Jan 2002 03:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288018AbSAMIDC>; Sun, 13 Jan 2002 03:03:02 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:22539 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S288008AbSAMICy>; Sun, 13 Jan 2002 03:02:54 -0500
Date: Sun, 13 Jan 2002 19:03:06 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020113190306.02ec6869.rusty@rustcorp.com.au>
In-Reply-To: <3C409B2D.DB95D659@zip.com.au>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu>
	<1010781207.819.27.camel@phantasy>
	<20020112121315.B1482@inspiron.school.suse.de>
	<20020112160714.A10847@planetzork.spacenet>
	<20020112095209.A5735@hq.fsmlabs.com>
	<20020112180016.T1482@inspiron.school.suse.de>
	<005301c19b9b$6acc61e0$0501a8c0@psuedogod>
	<3C409B2D.DB95D659@zip.com.au>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2002 12:23:09 -0800
Andrew Morton <akpm@zip.com.au> wrote:
> And guess what?   Nobody has tested the damn thing, so it's going
> nowhere.

Haven't had latency problems, to be honest.  Maybe I should start playing mp3s
while I code?

1) conditional_schedule?  Hmmm... Why the __set_current_state?  I think I prefer
   an explicit "if (need_schedule()) schedule()", with
   #define need_schedule() unlikely(current->need_resched)

2) I hate condsched.h: Use sched.h please!

3) Why this:
   > +#ifndef __LINUX_COMPILER_H
   > +#include <linux/compiler.h>
   > +#endif

Other than that, I like this patch.  Linus?
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
