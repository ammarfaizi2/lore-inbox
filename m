Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTKIQHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 11:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKIQHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 11:07:46 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:40172
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262608AbTKIQHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 11:07:45 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Davide Libenzi <davidel@xmailserver.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
Date: Mon, 10 Nov 2003 03:07:40 +1100
User-Agent: KMail/1.5.3
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.44.0311090801130.12198-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0311090801130.12198-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311100307.40127.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003 03:05, Davide Libenzi wrote:
> On Sun, 9 Nov 2003, Martin J. Bligh wrote:
> > I think the confusing bit is this:
> >
> > this_rq->prev_cpu_load[i] = rq_src->nr_running;
> >
> > where "this_rq->prev_cpu_load[i]" doesn't intuitively look like what it
> > means ;-) Even just 's/i/cpu/' would help a bit, or something (like
> > wrapping it in macros). Seems it is correct as was though - thanks for
> > explaining it.
>
> Maybe something like:
>
>  * We fend off statistical fluctuations in runqueue lengths by
>  * saving the runqueue length (as seen by the balancing CPU) during the
>  * previous load-balancing operation and using the smaller one the current

"during the previous load-balancing operation" is what made me interpret it 
differently.

Con

