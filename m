Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUCZWc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 17:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbUCZWc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 17:32:29 -0500
Received: from gprs214-69.eurotel.cz ([160.218.214.69]:17537 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261206AbUCZWc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 17:32:27 -0500
Date: Fri, 26 Mar 2004 23:32:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [.config] CONFIG_THERM_WINDTUNNEL
Message-ID: <20040326223217.GH9491@elf.ucw.cz>
References: <200403180821.44199.michal@roszka.pl> <Pine.LNX.4.58.0403181012300.29633@denise.shiny.it> <20040318112057.GC3686@ibrium.se> <Pine.LNX.4.58.0403181221580.1392@denise.shiny.it> <20040318120311.GD3686@ibrium.se> <20040324001828.GB238@elf.ucw.cz> <20040326183020.GA19610@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326183020.GA19610@ibrium.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is it actually possible to set that hardware to self-destruct?
> > 
> > [ACPI notebooks have very simple hardware failsafe: if temperature
> > exceeds some hard limit, power is simply cut.]
> 
> Well, I'm not sure.
> 
> I know that the hardware which controls the fan (a separate temperature
> sensor and a combined sensor/controller) is not connected to any death
> switch; the available overheat pin serves as a 100% fan override. There
> might very well be a safety mechanism in the UniNorth bridge though.
> Something like a forced power off if interrupts are not handled in
> a timely manner. I'm pretty sure I have seen references to this behavior
> in conjunction with the PowerBook G4. The dual G4 architecture is not all
> that different...

ACPI design seems to have aditional benefit: if your fan fails, you
can still operate machine safely. You just have to be clever with
throttling etc :-). [Assuming vendor did set shutdown threshold
right. HP Omnibook XE3 will kill power at 83C. If you leave it running
at ~82C for ten hours, you'll fry the disk. Oops.]

Funniest machine in this regard was 300MHz P2 toshiba. On extreme
overheat (95C), it went to 40MHz no matter what os did. At that point
it was able to cool itself even without fan. [But I was pretty puzzled
when I saw that behaviour].

> It would be interesting to see what happens if one disables the overheat
> protection and stops the fan. Anybody volunteering? At least one
> has an excellent reason why one need one of those new G5 machines
> if things start to smoke :-).

Well, its enough to end the test when CPU starts doing errors. Usually
CPU stops working at some temperature, and is only physically damaged
after that. Or you can get datasheets from CPU manufacturer, and call
the machine's design broken when it exceeds CPU design limits by
5C... This should be testable without letting magic smoke out.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
