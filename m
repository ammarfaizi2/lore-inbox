Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268526AbTANCqT>; Mon, 13 Jan 2003 21:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268538AbTANCqP>; Mon, 13 Jan 2003 21:46:15 -0500
Received: from dp.samba.org ([66.70.73.150]:29580 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268527AbTANCqA>;
	Mon, 13 Jan 2003 21:46:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@zip.com.au, davem@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned_in_smp? 
In-reply-to: Your message of "Mon, 13 Jan 2003 02:45:16 CDT."
             <20030113074516.GA4677@gtf.org> 
Date: Tue, 14 Jan 2003 13:22:46 +1100
Message-Id: <20030114025452.896E52C3DD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030113074516.GA4677@gtf.org> you write:
> On Mon, Jan 13, 2003 at 06:24:40PM +1100, Rusty Russell wrote:
> > Dave: Anton suggested you might have a justification for
> > __cacheline_aligned doing something on UP?
> > 
> > I think I'd prefer __cacheline_aligned to be the same as
> > __cacheline_aligned_in_smp, and have a new __cacheline_aligned_always
> > for those who REALLY want it (if any).
> 
> See the recent thread on tg3 and cacheline_aligned for David's
> description...  I and one other did some performance measurements and
> ____cacheline_aligned proved useful even on UP...

Thanks, finally found the thread.

> sigh.  I wish I had caught you on IRC.

<sniff> I miss you too Jeff... 8)

> Don't you think changing the meaning of cacheline_aligned, and adding a
> new __cacheline_aligned_always to mean what it used to, is completely
> pointless churn??

Agreed.  Now I understand that's it's also possibly useful on UP, not
just programmer laziness, like it is in the module.h case 8)

Of course, it'd be nice to see benchmarks to justify each of these,
but wouldn't it always?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
