Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTEHLBS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 07:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTEHLBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 07:01:18 -0400
Received: from dialpool-210-214-91-49.maa.sify.net ([210.214.91.49]:63104 "EHLO
	softhome.net") by vger.kernel.org with ESMTP id S261324AbTEHLBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 07:01:16 -0400
Date: Thu, 8 May 2003 16:43:13 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5: ieee1394 still broken, vesafb still broken, ipv6 still broken
Message-ID: <20030508111313.GA1081@localhost.localdomain>
References: <20030507235104.GA12486@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507235104.GA12486@codeblau.de>
X-GPG-Fingerprint: A977 433E B71E 2D1C 6114  9F33 F390 527D 70D1 2799
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 01:51:04AM +0200, Felix von Leitner wrote:
> I am surprised that Linus thinks now is the time to move towards a
> stable 1.6 release, I don't see any sign for increased stability in
> 2.5.59.  I am still forced to use 2.5.53 because that is the last kernel
> that has working ieee1394.
> 
> To reiterate the problems:
> 
>   ohci1394 detects my controller, sbp2 gets the same unsolicited packets
>     from my Maxtor firewire hard disk as 2.5.53, but no sign of a
>     detected SCSI device.
> 
>   vesafb is told to go to 1024x768-32, does so, but then reads from my
>     TFT display that 1600x1200 is the native resolution and then thinks
>     that is the resolution it is using (even fbset says so).  The result
>     is that I can only see the upper half of my screen, and the display
>     is garbled to boot because the line length is too large, meaning
>     writing something in the right half of the 1600x1200 screen results
>     in overwriting something on the left of my real 1024x768 screen.
> 
>   ipv6 is still broken because running npush and then starting npoll on
>     another virtual terminal will hang the kernel hard instantaneously.
>     So hard, in fact, that I don't have a trace I could give you.  Since
>     vesafb is broken (hint, hint), I only see the last lines, which say
>     something about a fatal error in an interrupt routine and a callback
>     where the last lines are call_socketcall and call_syscall (IIRC).
>     npush and npoll are from the ncp package, which you can find at
>     http://www.fefe.de/ncp/
> 
> We should not make any wind about even mentioning 2.6 to the press until
> we at least reach the basic functionality requirements, let alone
> stability of 2.4.  I find the situation pretty embarassing considering
> that I am running around and telling customers to install Linux (come
> see me at LinuxTag, by the way, I'm talking about scalable network
> programming on Linux there.  It would be really embarassing if I
> couldn't present the slides about the cool 2.5 features because 2.5 just
> happens to still suck then.
> 
> And if you are right now considering to tell me that I should go to
> nvidia tech support, please limit yourself to private email as to reduce
> the embarrassment and damage you are causing to the rest of this list
> with Theo DeRaadt style user alienation.  And unless you are going to
> investigate these, don't even bother with private email as well.
> Bullshit like that makes Windows look like the better option.  The
> FreeBSD people are probably having a field day with this nvidia episode
> here.
> 
> Felix
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


For the vesafb just remove the EDID ifdef in drivers/video/vesafb.c,
line 303 to 308.
-- 
