Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRDJMR7>; Tue, 10 Apr 2001 08:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRDJMRt>; Tue, 10 Apr 2001 08:17:49 -0400
Received: from iris.mc.com ([192.233.16.119]:4810 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131248AbRDJMRj>;
	Tue, 10 Apr 2001 08:17:39 -0400
From: Mark Salisbury <mbs@mc.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: No 100 HZ timer !
Date: Tue, 10 Apr 2001 08:07:04 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com> <01040914220214.01893@pc-eng24.mc.com> <20010410075109.A9549@gruyere.muc.suse.de>
In-Reply-To: <20010410075109.A9549@gruyere.muc.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01041008110318.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

which kind of U/K accaounting are you referring to?

are you referring to global changes in world time? are you referring to time
used by a process? 

I think the reduction of clock interrupts by a factor of 10 would buy us some
performance margin that could be traded for a slightly more complex handler.

On Tue, 10 Apr 2001, Andi Kleen wrote:
> On Mon, Apr 09, 2001 at 02:19:28PM -0400, Mark Salisbury wrote:
> > this is one of linux biggest weaknesses.  the fixed interval timer is a
> > throwback.  it should be replaced with a variable interval timer with interrupts
> > on demand for any system with a cpu sane/modern enough to have an on-chip
> > interrupting decrementer.  (i.e just about any modern chip)
> 
> Just how would you do kernel/user CPU time accounting then ?  It's currently done 
> on every timer tick, and doing it less often would make it useless.
> 
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

