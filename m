Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129398AbRAZK0h>; Fri, 26 Jan 2001 05:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAZK02>; Fri, 26 Jan 2001 05:26:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:12299 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S129398AbRAZK0H>; Fri, 26 Jan 2001 05:26:07 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101261025.f0QAPxo00754@wellhouse.underworld>
Subject: Re: [PATCH](s): Use spinlocks instead of STI/CLI in SoundBlaster
To: andrewm@uow.edu.au (Andrew Morton)
Date: Fri, 26 Jan 2001 21:25:58 +1100 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A712AA4.13B912AD@uow.edu.au> from "Andrew Morton" at Jan 26, 2001 06:43:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> spin_lock_irqsave() and save_flags()+cli() are identical on
> uniprocessor builds.

OK, so a UP-build proves nothing ...

> cli() is quite putrid on SMP and should be shot.

This much I understand ...

> You can test your patch on uniprocessor hardware - just build
> an SMP kernel and run it.  If it doesn't deadlock, things
> are looking positive.

OK, I'll do that.

> I dunno if you'll have much luck getting this into 2.4.1 though.
> I suggest you send it to Alan.

I have no illusions whatsoever about Linus picking this up. However,
Alan has been picking patches up I've posted before. I can't send this
to Alan directly though, because his mailserver keeps on asking for
the average airspeed of an unladen swallow ... (I don't know that!)

Cheers,
Chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
