Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbSKBDio>; Fri, 1 Nov 2002 22:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265873AbSKBDin>; Fri, 1 Nov 2002 22:38:43 -0500
Received: from 3-090.ctame701-1.telepar.net.br ([200.193.161.90]:25797 "EHLO
	3-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265872AbSKBDin>; Fri, 1 Nov 2002 22:38:43 -0500
Date: Sat, 2 Nov 2002 01:44:47 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, <pbadari@us.ibm.com>
Subject: Re: idle time & iowait accounting
In-Reply-To: <3DC34808.A8FE6FAC@digeo.com>
Message-ID: <Pine.LNX.4.44L.0211020143500.1697-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Andrew Morton wrote:

> > +       preempt_disable();
> > +       rq = this_rq();
> > +       atomic_inc(&rq->nr_iowait);
> > +       schedule();
> > +       atomic_dec(&rq->nr_iowait);
> > +       preempt_enable();

> "scheduling while atomic".

Point.

> You'll need to reacquire the runqueue pointer on waking up.

No. It makes sense to decrement the same counter that was
incremented before.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

