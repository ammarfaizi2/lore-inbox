Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWBZXZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWBZXZB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWBZXZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:25:00 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:5278 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S932260AbWBZXZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:25:00 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200602262327.k1QNRbBm008810@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.15-rt16: possible sound-related side-effect
To: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 27 Feb 2006 09:57:37 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org, mingo@elte.hu (Ingo Molnar)
In-Reply-To: <Pine.LNX.4.58.0602240230170.20385@gandalf.stny.rr.com> from "Steven Rostedt" at Feb 24, 2006 02:38:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve

> > I finally got around to doing this and the first two dumps are at the
> > end of this message.  Many many more were sent to the logs though - as
> > one would expect, since we know that in the fault condition this function
> > is called very frequently without any end in site.
> 
> Thanks, it didn't find the bug for me, but it did get me a better idea of
> what it's doing.  Now that you modified the kernel, I hope you are
> comfortable in doing more of that :)

As I said, this issue first came to light while I worked on an ALSA driver
patch.  I'm fine with patches. :)

> Remove the dump stack, and apply the following patch (should work with
> both -rt16 and -rt17).  This is _not_ a bug fix (obviously) but will do
> a lot more prints.  I don't know how many interrupts this driver produces
> so beware that this can really fill the logs.

FYI it applied with some manual intervention against -rt16.  I ran out of
time to try -rt17 though.  It'll be a day or so before I get to that.

The minor problem is that with the patch applied I was unable to trigger the
bug.  I then went back to what I *think* was a totally unmodified 2.6.15-rt16
tree, recompiled that from scratch and was then unable to reproduce the
problem with that one either.

Now, this was quite late last night and there were a few other strange
issues occuring at the same time, so before declaring this whole thing the
result of an out-of-sync kernel compile I want to do everything again from
scratch (especially since I can't quite see how things could have gotten out
of sync).  I'll also test -rt17 for completeness.

Another possibility is that it's CVS-alsa which is doing something odd to
the hardware.  I'll test for this as well.

I'll try to do all this tonight, so hopefully by tomorrow I'll have some
definitive news one way or the other.

Regards
  jonathan
