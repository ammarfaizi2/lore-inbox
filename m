Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUHJEM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUHJEM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUHJEM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:12:56 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:22411 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S267422AbUHJEMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:12:15 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Tue, 10 Aug 2004 00:12:08 -0400
User-Agent: KMail/1.6.82
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408081030.39051.gene.heskett@verizon.net> <20040808113930.24ae0273.akpm@osdl.org>
In-Reply-To: <20040808113930.24ae0273.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408100012.08945.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.153.76.4] at Mon, 9 Aug 2004 23:12:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 August 2004 14:39, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> On Thursday 05 August 2004 23:24, Linus Torvalds wrote:
>>
>> [...]
>>
>> >I'll commit the obvious one-liner fix, since it might explain
>> > _some_ problems people have seen.
>> >
>> >		Linus
>>
>> I had to reboot late last night, out of memory and things (like
>> mozilla (1.7.2) were dying, but nothing in the logs.
>
>Please wait for it to happen again, then send the contents of
>/proc/meminfo, /proc/slabinfo and then do
>
>	su
>	dmesg -c
>	echo m > /proc/sysrq-trigger
>	dmesg > foo
>
>and send foo as well.

I just had to reboot again.  Top was showing about 50 megs free, and 
there was about 60 megs in the swap.  Top wasn't showing anything 
else of interest that I noted.

I've been gone all day, a long day at that, 12 hours. We had another 
blowup in the hi voltage at the tv transmitter, and we'll be sometime 
tomorrow getting things back to normal there.  Its 40 years old, and 
quite far up the far end of the "bathtub curve".

I left about 10:15 and came back in about 22:30.  A friend had been 
trying to reach me over an alsa problem, and I'd opened a shell and 
was showing him how the new 2.6 modprobe.conf worked.  When we were 
done, I hit a q to quit less, and (surprise) the whole shell went 
away, and I could not start another shell, each attempt being 
reported as an error 5 on the kickstart panel at the bottom of the 
screen after the new window opened and reclosed in about 100 
milliseconds per attempt.  I quit the top program to free that shell, 
and thinking maybe I was being attacked, entered a 'w' at the prompt, 
and that shell went away too, with the same error.  That left me with 
the tail on the log, which at that point still wasn't showing me 
anything but a samba restart I do once daily else it dies from a 
profound lack of interest anyway.

I right clicked on the screen and selected quit X.

It quit, but then a trap error was reported.

I typed "reboot" and the machine reported no more processes at this 
run level and was then DOA, requireing a tap on the reset button to 
bring it back to life.  On the subsequent e2fsck's, /dev/hda8 had 
this error:

i_dir_acl for inode 654880 (/lib/local/ar_YE is 42752 but s/b zero.

And then dropped me to a shell to run e2fsck without any options.  
Which I did.  Eventually it asked me if I wanted to clear that inode, 
so I answered 'y' and it finished without any other errors, but when 
I did the ctl-d to reboot, it still wanted to do an e2fsck on 
everything, which passed.  So now I'm rebooted, but without anything 
of meaning (there is nothing in the logs) to report.  Any evidence of 
the debacle is now gone.

Also, during the reboot, I'm blind from "ok, booting the kernel" until 
the line in something that sets the default font is executed, setting 
it to "lat0_sun16" at which time I have readable info on the screen 
again.  I don't recall seeing that particular font mentioned in a 
make xconfig, so I've no idea how to make it use it from square one 
so I can read the dmesg as it goes by the first time.  I have 
iso-8859-1 compiled in, along with codepage 437 for US useage, with 
everything else as modular.

How can I fix this "blind" time?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
