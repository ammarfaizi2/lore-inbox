Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUFGOJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUFGOJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUFGOJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:09:45 -0400
Received: from gprs214-178.eurotel.cz ([160.218.214.178]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264656AbUFGOFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:05:23 -0400
Date: Mon, 7 Jun 2004 16:05:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Kloska <kloska@scienion.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
Message-ID: <20040607140511.GA1467@elf.ucw.cz>
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C46F7F.7060703@scienion.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I'm really willing  to help the APM developers to track down this bug
> >>but don't have a clue how to debug this kind stuff.
> >
> >
> >What APM developers? There are none as far as I know.
> 
> 
>   Hmmm ... So once again the Tooth Fairy and Santa Claus :-) ?
> 
>   At least a
> 
>   grep '<.*@' /usr/src/linux-2.6.6/arch/i386/kernel/apm.c | sed 's/.*<//' | 
>   sed 's/>.*//'
> 
>   gives me:
> 
> <snip>
> Ulrich.Windl@rz.uni-regensburg.de
...
> chen@ctpa04.mit.edu
> </snip>
> 
> This is pretty much for no one. And I guess you knew since you're on
> the list yourself. But I think you're right when meaning
> that there is not much of active maintenance anymore. Which at
> least I find a little bit discouraging when looking of the state
> of the ACPI support.

Yes, that's pretty much what I meant. ACPI has ~5 people actively
working on it, some of them probably full-time. That's a lot of
manpower, compared to APM.

And ACPI is in pretty good state, btw, unless you want
suspend-to-RAM. Unfortunately you want suspend-to-RAM.

> >Try removing calls to device_* in apm.c. Better yet become APM
> >developer.
> 
>   It seems like I'm on my way to do so (still reluctantly). As I stated
>  in my previous mails I'm not born as a hardware/BIOS hacker (more the
>  application C++/Java stuff) but I'm willing to learn. When I'm
>  grown up I definitely want to be linux kernel hacker :-) ...
> 
>   Currently I ripped down the 2.6.6 kernel to almost nothing
>  and add one module after the other checking for proper
>  suspend/resume behavior....
> 
>   The most suspicious candidates on my list are currently  the
>  USB-UHCI driver and the ALSA sound system, which is my #1 candidate
>  since it has not been an integral part of the 2.4.x (x<=20) kernels.
> 
> 
>  So if anybody out there could give me guidance on how the apm code
>  might interact with the ALSA sound system it would be highly
>  appreciated....

device_suspend() will propagate all the way to alsa.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
