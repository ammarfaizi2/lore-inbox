Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264925AbUFGQ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUFGQ0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbUFGQ0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:26:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47083 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264925AbUFGQ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:26:21 -0400
Date: Mon, 7 Jun 2004 18:26:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Kloska <kloska@scienion.de>
Cc: Keith Duthie <psycho@albatross.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
Message-ID: <20040607162620.GA817@atrey.karlin.mff.cuni.cz>
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <Pine.LNX.4.53.0406080228110.27816@loki.albatross.co.nz> <40C47FEE.6080505@scienion.de> <20040607145116.GE1467@elf.ucw.cz> <40C48519.6010703@scienion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C48519.6010703@scienion.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Does this bug freeze the machine ? Or just block
> >>the outputting program ?
> >>
> >>PCM will be the next to look at...
> >
> >
> >Drop all non-important hw. That's everything but keyboard, VGA and
> >harddrive...
> >
>    Already did that and APM suspends/resumes fine. That gives
>   me hope to at least pinpoint the bad behaving module/driver....

Okay, then its easy. Find offending driver; removing its
suspend/resume routine should work it around for you.

Solving this properly will be slightly harder; it involves finding
what the driver did wrong. You might want to call the driver's
suspend/resume routine repeatedly without really suspending to see if
it breaks something.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
