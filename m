Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTFDTeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbTFDTeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:34:19 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:52682 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263918AbTFDTeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:34:17 -0400
Date: Wed, 4 Jun 2003 21:46:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Frank <mflt1@micrologica.com.hk>, hugang <hugang@soulinfo.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE Power Management (Was: software suspend in 2.5.70-mm3)
Message-ID: <20030604194659.GB524@elf.ucw.cz>
References: <20030603211156.726366e7.hugang@soulinfo.com> <1054732481.20839.30.camel@gaston> <200306042151.10611.mflt1@micrologica.com.hk> <200306042210.12468.mflt1@micrologica.com.hk> <1054736960.20838.44.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054736960.20838.44.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ............ 
> > [nosave c03f7000]critical section/: done (2273 pages copied)
> > hda: Wakeup request inited, waiting for !BSY...
> > hda: start_power_step(susp: 0, step: 0)
> > hda: start_power_step(susp: 0, step: 101)
> > hda: completing PM request, suspend: 0
> > Devices Resumed
> > Devices Resumed
> 
> Hrm... the joy if swsusp putting your disk to sleep just to wake it up
> right away... I need to check if I can differenciate suspend-to-disk
> from suspend-to-ram here to just not put the drive in STANDBY mode
> on suspend-to-disk (just freeze the queues)

Why? Suspending then resuming it may take long but seems correct to
me.

> > Writing data to swap (2273 pages): .<3>bad: scheduling while atomic!
> 
> Here's the real one. However, it doesn't look related to my sleep code,
> though I cannot guarantee this for sure right now, it _seems_ it's
> a swsusp bug you are hitting.

Yes, it looks so.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
