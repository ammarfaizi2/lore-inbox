Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbTHGTk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270474AbTHGTkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:40:49 -0400
Received: from post.tau.ac.il ([132.66.16.11]:42952 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S270469AbTHGTkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:40:40 -0400
Subject: Re: ACPI Power Button Event problems(?)
From: Micha Feigin <michafeigin@yahoo.com>
Reply-To: michf@math.tau.ac.il
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F31F6FD.8030001@sbcglobal.net>
References: <3F31F6FD.8030001@sbcglobal.net>
Content-Type: text/plain
Message-Id: <1060285317.3351.7.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 22:41:57 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.20.0.1; VDF: 6.20.0.55; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 09:51, Wes Janzen wrote:
> I'm having an interesting, and relatively benign problem with ACPI 
> events.  I downloaded the ACPI daemon from SourceForge and with 
> 2.6.0-test1-mm2 when I pressed the power button, ACPI would be deluded 
> with PWRF events until I pushed the button again or acpid was 
> restarted.  That's easy enough to work around, but with 2.6.0-test2-mm1 
> the events never stop.  Restarting the daemon makes no difference, nor 
> does pushing the button have any effect.  That wouldn't be too big of a 
> problem if I was using the power button to restart the PC, but I'm using 
> the event to kill sawfish since it likes locking up (and disregarding 
> any keyboard input) leaving me with no recourse but to press the reset 
> button otherwise.  So, it works great for the first lockup, but I can't 
> reset the power button event so I'm stuck with the reset button on the 
> second round.  Unless I want to reboot, which I'd rather not. 
> 
> Is this a bug in 2.6.0-test2-mm1 or was the bug the fact it could be 
> cancelled in 2.6.0-test1-mm2?
> 
> Thanks,
> 
> -Wes-
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I am guessing that it is not a bug in acpid since stop it didn't help.
You could try a
cat /proc/acpi/event
to make sure that you are actually getting these events no stop.
I am guessing that it is a faulty dsdt since you got the same the
behavior on the different kernel.
Can you tell if this also happens with 2.4 kernel?

