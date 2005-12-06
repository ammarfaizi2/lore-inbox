Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVLFCHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVLFCHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVLFCHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:07:36 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:805 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S964919AbVLFCHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:07:35 -0500
Date: Mon, 05 Dec 2005 21:07:24 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ntp problems
In-reply-to: <1133828065.7605.50.camel@cog.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Message-id: <200512052107.24427.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512050031.39438.gene.heskett@verizon.net>
 <200512051833.19629.gene.heskett@verizon.net>
 <1133828065.7605.50.camel@cog.beaverton.ibm.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 19:14, john stultz wrote:
>On Mon, 2005-12-05 at 18:33 -0500, Gene Heskett wrote:
>> On Monday 05 December 2005 16:39, john stultz wrote:
>> >On Mon, 2005-12-05 at 00:31 -0500, Gene Heskett wrote:
>> >> Greetings everybody;
>> >>
>> >> I seem to have an ntp problem.  I noticed a few minutes ago that
>> >> if my watch was anywhere near correct, then the computer was about
>> >> 6 minutes fast.  Doing a service ntpd restart crash set it back
>> >> nearly 6 minutes.
>> >
>> >Not sure exactly what is going on, but you might want to try
>> > dropping the LOCAL server reference in your ntp.conf. It could be
>> > you're just syncing w/ yourself.
>>
>> Joanne, bless her, pointed out that I had probably turned the ACPI
>> stuff in my kernel back on.  She was of course correct, shut it off &
>> ntpd works just fine.
>
>Err. ACPI stuff? Could you elaborate? Sounds like you have some sort of
>bug hiding there.

This has been a relatively long standing problem, John.  I think its 
possibly related to some access path in the nforce2 chipset as it seems 
to plague that chipset worse than others.  But its long been, and I had 
forgotten, that if ntpd didn't work, turning off the ACPI stuff was the 
fix.

It had worked for a few kernel.org kernels and I had become complacent.  
My mistake.

OTOH, calling it a local bug, no, I certainly wouldn't call it a local to 
my machine bug.  Jdow OTOH, running an FC4 box, has it enabled, and hers 
is working just fine.  She is I believe, running the FC4's latest kernel 
too, so maybe the redhat people have massaged it.  However, at one time 
several months ago I believe she also had to have a grub argument 
turning acpi=no.

There was a bunch of ntp related patches submitted recently, and I have 
no idea which of them may have restored the broken acpi vs ntp scenario 
to its formerly broken status, again.

Should it be looked at?  Certainly, but I don't have the knowledge to do 
so.  So I build kernels, and report problems areas.  The canary in the 
coal mine so to speak. :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
