Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285940AbSADXvJ>; Fri, 4 Jan 2002 18:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285937AbSADXu7>; Fri, 4 Jan 2002 18:50:59 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:15628 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S285935AbSADXuy>; Fri, 4 Jan 2002 18:50:54 -0500
Date: Fri, 4 Jan 2002 17:50:50 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020104175050.A3623@asooo.flowerfire.com>
In-Reply-To: <20020103142301.C4759@asooo.flowerfire.com> <200201040019.BAA30736@webserver.ithnet.com> <20020103232601.B12884@asooo.flowerfire.com> <20020104140321.51cb8bf0.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020104140321.51cb8bf0.skraw@ithnet.com>; from skraw@ithnet.com on Fri, Jan 04, 2002 at 02:03:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 02:03:21PM +0100, Stephan von Krawczynski wrote:
[...]
| Ok. It would be really nice to know if the -aa patches do any good at your

I'd love to, but unfortunately my problems reproduce only in production,
and -- nothing against Andrea -- I'm hesitant to deploy -aa live, since
it hasn't received the widespread use that mainline has.  I may be
forced to soon if the VM fixes don't get merged.

[...]
| > Do they have *sustained* heavy hit/IRQ/IO load?  For example, sending
| > 25Mbit and >1,000 connections/s of sustained small images traffic
| > through khttpd will kill 2.4 (slow loss of timer and eventual total
| > freeze) in a couple of hours.  Trivially reproducable for me on SMP with
| > any amount of memory.  On HP, Tyan, Intel, Asus... etc.
| 
| Hm, I have about 24GB of NFS traffic every day, which may be too less. What
| exactly are you seeing in this case (logfiles etc.)?

Well, the nature of the problem is that the timer "slows" and stops,
causing the machine to get more and more sluggish until it falls of the
net and stops dead.

I suspect that high IRQ rates cause the issue -- large sequential
transfers are not necessarily culprits due the lowish overhead.

[...]
| > It's not that the kernel is bad, it's that there are specific things
| > that shouldn't be forgotten because of a "the kernel is good"
| > evaluation.
| 
| Hopefully nobody does this here, I don't.

I don't think it's intentional, and I realize that VM changes are hard
to swallow in a stable kernel release.  I just hope that the severity
and fairly wide negative effect is enough to make people more
comfortable with accepting VM fixes that may be somewhat invasive.

Thanks,
-- 
Ken.
brownfld@irridia.com
