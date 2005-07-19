Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVGSPTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVGSPTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 11:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGSPTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 11:19:09 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:30359 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261415AbVGSPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 11:19:07 -0400
Date: Tue, 19 Jul 2005 11:19:06 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
In-reply-to: <20050719135715.GA20664@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Karsten Wiese <annabellesgarden@yahoo.de>,
       "K.R. Foley" <kr@cybsft.com>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>
Message-id: <200507191119.06671.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
 <200507191314.24093.annabellesgarden@yahoo.de> <20050719135715.GA20664@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 July 2005 09:57, Ingo Molnar wrote:
>* Karsten Wiese <annabellesgarden@yahoo.de> wrote:
>> > Found another error:
>> > the ioapic cache isn't fully initialized in -51-31's
>> > ioapic_cache_init(). <snip>
>>
>> and another: some NULL-pointers are used in -51-31 instead of
>> ioapic_data[0]. Please apply attached patch on top of -51-31. It
>> includes yesterday's fix.
>
>thanks, i've applied it and released -32.

And this fixed ntpd (in mode 4) right up.  But now Im seeing some 
fussing from Xprint when its started, from my logs:

Jul 19 10:59:58 coyote rc: Starting xprint:  succeeded
Jul 19 10:59:58 coyote kernel: set_rtc_mmss: can't update from 7 to 59
Jul 19 10:59:58 coyote kernel: set_rtc_mmss: can't update from 7 to 59
Jul 19 10:59:59 coyote Xprt_33: lpstat: Unable to connect to server: Connection refused
Jul 19 10:59:59 coyote Xprt_33: No matching visual for __GLcontextMode with visual class = 0 (32775), nplanes =
8
Jul 19 11:00:00 coyote kernel: set_rtc_mmss: can't update from 7 to 59

The font path stuff I snipped has been there since forever.
And, I didn't get the set_rtc_mmss messages when I did a service xprint restart.

Is this even connected to Xprint, that looks like something from maybe ntp?

And of course in mode 4, tvtime has a blue screen.  But you knew that. :)

> Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
