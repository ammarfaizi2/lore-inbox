Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTFLTSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTFLTSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:18:39 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:49387 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264957AbTFLTSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:18:35 -0400
Date: Fri, 13 Jun 2003 07:35:24 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: implicid declaration of function task_suspended	-	Was:	[PATCHSET]
 2.4.21-rc6-dis3 released
In-reply-to: <1055431855.11780.5.camel@slappy>
To: Disconnect <kernel@gotontheinter.net>
Cc: Martin List-Petersen <martin@list-petersen.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1055446523.19667.2.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1055410660.3ee849e439b96@support.tuxbox.dk>
 <1055418435.17838.8.camel@laptop-linux> <1055431855.11780.5.camel@slappy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beta19 is very old now, which will be why you're getting the problem.
We're up to 1.0-pre7. You'll find 1.0-pre5 on Sourceforge and the last
couple of incremental patches have been posted to the list. (I haven't
gotten around to putting them on Sourceforge yet, but will do it now for
you). If you apply them to your tree, you'll get a far more stable and
feature complete swsusp - since beta19, there have been a ton of bug
fixes (including this compile fix) and speed ups, including asynchronous
I/O. Hence the 1.0pre series.

Regards,

Nigel

On Fri, 2003-06-13 at 03:30, Disconnect wrote:
> On Thu, 2003-06-12 at 07:47, Nigel Cunningham wrote:
> > TASK_SUSPENDED is a swsusp macro. What version of swsusp do you have
> > included in your kernel? (There were some compile problems fixed a while
> > ago - you probably have a version pre then).
> 
> It may not be directly related to swsusp - it may be that in wiggling a
> patch I missed an #ifdef SWSUSP ...
> 
> ..
> 
> OK I looked there - its can_schedule() thats triggering it.  I'm going
> to try a build without software suspend and see if I can reproduce.  In
> the meantime, send me the .config file that triggered it. (And make sure
> you did 'make mrproper ; make [x/menu/old]config ; make dep ; make
> clean' ..)
> 
> FWIW its 2.4.21-rc6 with the following suspend-related patches:
>   - ACPI 20030523-2.4.21-rc3.diff
>   - patch-acpi-acpi20021212-swsusp19.gz
>   - patch-agp for swsusp on i810 motherboards
> 
> > Regards,
> > 
> > Nigel
> > 
> > On Thu, 2003-06-12 at 21:37, Martin List-Petersen wrote:
> > > I tried to compile this (both on rc6 and rc7) and the compile fails with:
> > > 
> > > kernel/kernel.o(.text+0x2d8): In function 'schedule':
> > > : undefined reference to 'TASK_SUSPENDED'
> > > kernel/kernel.o(.text+0x392): In function 'schedule':
> > > : undefined reference to 'TASK_SUSPENDED'
> > > 
> > > The compile allready stated in the beginning:
> > > sched.c: In function 'schedule':
> > > sched.c:611: implicit declaration of function 'TASK_SUSPENDED'
> > > 
> > > Any idea's what i can leave out to avoid these failures ?
> > > 
> > > Regards,
> > > Martin List-Petersen
> > > martin at list-petersen dot dk
> > > --
> > > Q:	What do you get when you cross the Godfather with an attorney?
> > > A:	An offer you can't understand.
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

