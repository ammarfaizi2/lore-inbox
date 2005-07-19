Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVGSN2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVGSN2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVGSN2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:28:03 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:47510 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261285AbVGSN2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:28:02 -0400
Date: Tue, 19 Jul 2005 09:35:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
In-reply-to: <200507191314.24093.annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Ingo Molnar <mingo@elte.hu>,
       "K.R. Foley" <kr@cybsft.com>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>
Message-id: <200507190935.19341.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
 <200507171407.20373.annabellesgarden@yahoo.de>
 <200507191314.24093.annabellesgarden@yahoo.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 July 2005 07:14, Karsten Wiese wrote:
>Am Sonntag, 17. Juli 2005 14:07 schrieb Karsten Wiese:
>> Am Samstag, 16. Juli 2005 19:15 schrieb Ingo Molnar:
>> > * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
>> > > Have I corrected the other path of ioapic early
>> > > initialization, which had lacked virtual-address setup before
>> > > ioapic_data[ioapic] was to be filled in -51-28? Please test
>> > > attached patch on top of -51-29 or later. Also on Systems that
>> > > liked -51-28.
>> >
>> > thanks - i've applied it to my tree and have released the -51-31
>> > patch. It looks good on my testboxes.
>>
>> Found another error:
>> the ioapic cache isn't fully initialized in -51-31's
>> ioapic_cache_init(). <snip>
>
>and another: some NULL-pointers are used in -51-31 instead of
> ioapic_data[0]. Please apply attached patch on top of -51-31. It
> includes yesterday's fix.
>
>    Karsten

I found yesterday, that a -31 build in mode 4 seems to do something to 
ntpd, it fails startup, and floods the log with bad file descriptor 
messages.  I put some debugging echo's in the ntpd script but wasn't 
able to see any problems there.

So I'm back to -30, in mode 3 ATM, so tvtime works.  But everything 
else works far better in mode 4.


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
