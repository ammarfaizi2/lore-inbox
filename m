Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVK2C12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVK2C12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 21:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVK2C12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 21:27:28 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:36958 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932333AbVK2C11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 21:27:27 -0500
Date: Mon, 28 Nov 2005 21:25:52 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
In-reply-to: <438BAC38.3070505@m1k.net>
To: linux-kernel@vger.kernel.org
Cc: Michael Krufky <mkrufky@m1k.net>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Don Koch <aardvark@krl.com>, Perry Gilfillan <perrye@linuxmail.org>
Message-id: <200511282125.52997.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
 <200511281835.56805.gene.heskett@verizon.net> <438BAC38.3070505@m1k.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 20:17, Michael Krufky wrote:
>Gene Heskett wrote:
>>On Monday 28 November 2005 18:01, Michael Krufky wrote:
>>>Perry Gilfillan wrote:
>>>>>Don Koch wrote:
>>>>>>(Followup to posting on pcHDTV forum.)
>>>>>>
>>>>>>I recentely purchased a pcHDTV HD3000 card.  Initially I was
>>>>>> having problems with NTSC reception in general (via tuner,
>>>>>> composite or svideo input), part of which was a problem with the
>>>>>> version of linux I was using.  Currently running
>>>>>>2.6.15-rc2-g458af543.
>>>>>>
>>>>>>Symptoms:
>>>>>>- ATSC OTA, svideo and composite work.  NTSC tuner does not (tried
>>>>>>both OTA and cable).
>>>>>>- Xawtv segfaults unless given a specific device (/dev/video0) and
>>>>>>then doesn't show anything in any mode including composite and
>>>>>>svideo.  This may just be an xawtv problem.
>>>>>>- Using tvtime works for composite and svideo, but the tuner
>>>>>>doesn't work in either broadcast or cable settings.  Disabling
>>>>>>signal detection shows the same "image" for any channel.
>>>>>>
>>>>>>All the appropriate modules seem to be in place.
>>>>
>>>>I can report some similar troubles.  It has worked with vanilla
>>>>kernel up to 2.6.13 on x86 up untill two weeks ago, when I moved the
>>>>card to an amd64 system.
>>>>
>>>>I'm currently running gentoo-sources-2.6.13 on amd64.  I have not
>>>>tried the newly merged tree with this kernel.
>>>>
>>>>However with gentoo-sources-2.6.14-r2 I tried the newly merged tree,
>>>>and do not get NTSC reception.  I have not tried the drivers as
>>>>released with 2.6.14 yet, so I'll follow up later on that.
>>>>
>>>>I'm also having some issues with the VIA Unichrome drivers with
>>>>2.6.14, so I may not be able to get far enough to really see whats
>>>>happening.
>>>
>>>I know that this board uses a Thomson DDT 7610 tuner.  I have a
>>>FusionHDTV3 Gold-T card that uses Thomson DDT 7611 tuner.  I've seen
>>> a copy of the datasheet -- both tuners are the same.
>>>
>>>Now, here's my story:  My card was working fine for a good long time,
>>>but ever since about 2 months ago, the analog tuner no longer works.
>>>ONLY the ATSC digital tuner is working.  The tuner does NOT include a
>>>tda9887, AFAIK, and I have also tested in windows.  Regardless of
>>>whether I am using Linux or Windows, I can only view an ATSC digital
>>>stream, NTSC analog no longer works at all.  Both used to work in
>>> both OS's.
>>>
>>>AFAIK, this is a physical hardware problem, and has nothing to do
>>> with any bad coding.  For the life of me, I cannot figure out what
>>> went wrong.
>>>
>>>-Mike
>>>
>>>Maybe Herman, or someone else, might be able to tell us what factors
>>>can burn out a hybrid tuner's analog capabilities, and leave digital
>>>tuning capabilities intact.
>>>
>>>Maybe the Thomson DDT 761x tuners are faulty?
>>>
>>>Can anybody enlighten us?
>>
>>Well, based on the note about -rc2-git6 having the v4l stuff reverted,
>>I just built it.  Same song, same verse.  The tuner acts as if the
>>antenna has been disconnected and held a fraction of an inch away. 
>> The video is all digital noise (in VSB), and the audio has a fraction
>> of a word now and then, buried in white noise.  As my dish receiver
>> has about a 65,000 u-volt output, I find that sort of signal loss
>> almost unbelievable.
>>
>>It still takes a cold reboot back to 2.6.14.3 or I think any earlier
>>kernel (that worked ok) in order to restore the cards normal
>> operation, I'm watching cnn on it right now after having done so.
>>
>>So to me, there is little difference between git3 and git6.  Neither
>>works, failing in the same manner exactly, and matching the
>> performance of 15-rc2 as issued.  I didn't build -rc1, so I can't say
>> exactly where the hose got cut.
>>
>>I'd suggest just blowing the v4l directory in the -rc2 kernel away,
>> and replacing it with that from 2.6.14.3 just to get back to a
>> working sitiuation that you can then start from scratch on.  But
>> whatdoIknow? :)Gene Heskett <gene.heskett@verizon.net>
>
>EEK!  This is not the problem that I'm having at all.....  Then again,
> I have a different board.
>
>Gene, telling someone to revert all the v4l changes in 2.6.15 doesn't
>help us to fix the actual problem at all, nor will it help them use
>their hardware.
>
>Gene, I believe that I asked you to install the cvs modules against
>2.6.14, and you told me that doing that works. 

No, I never did get it to work Michael, and I believe I said so, mainly
because it wouldn't even compile.  ISTR I sent a message with the
compiler exit messages at the time.

Now I'd be willing to try it again, but I'd need exactly the proceedure
as it would apply to a working 2.6.14.x kernel.  I don't think I did it
right the last time.  My script, fwiw, renames one generation back so
that a bad kernel can be reverted easily by renameing the vmlinuz and
/lib/modules/version-number trees.  Its kind of a swiss army knife in
that I comment/uncomment stuff in the buildit (thats another script I
use to apply then patches etc), but the makeit script only needs the
version number updated to match the Makefile and from there its a 'time
./makeit' till I'm done editing grub.conf & ready to reboot.  I've taken
note that the recent makefiles apparently does its own depmod operation
when doing the modules_install but haven't taken my command out of it
yet so that gets done twice..

> The code in cvs
> contains all the patches that we have sent to 2.6.15 and THEN some. 
> Can you please confirm that installing the cvs modules from v4l-dvb
> cvs (v4l and dvb have merged cvs repo's) against 2.6.14 is NOT
> broken??  This would rule out any possibility of the v4l changes in
> 2.6.15 being the cause of your problems.

See above.

>It is WELL established that there are memory errors in 2.6.15 
> (although I thought they were all fixed -- guess not).  I understand
> that you are using some MakeIt script to build your kernel -- have you
> tried the standard method?

My script does it essentially the same as one would do it by hand.  The
exception being that I understand the Makefile now has an install target
for the kernel, but my script does the copying rather than calling that,
and *I* do the grub.conf editing.

>[...a few minutes go by...]
>
>OKAY, I concur -- When I did my testing for 2.6.15-rc2-git6, that was
>with my saa7134-based card, using nxt200x ... success!
>
>However, when I tried using my FusionHDTV3 Gold-T (cx88 card using
>lgdt3302), neither analog nor digital works in 2.6.15-rc2-git6....
>Under 2.6.13 (and 2.6.14, i think), however, digital DOES work.  Analog
>still doesnt work, but i believe that my hardware is damaged.

He should do a full shutdown and cold boot to a kernel he knows works,
and I expect the analog will work again.  Warm reboots DO NOT DO IT!

>SO, looks like we have a regression somewhere in the kernel that breaks
>the cx88 driver :-(
>
>I don't even know where to begin.
>
>
>...One idea... We also know that upstream changes created some compile
>warnings in tuner-core...  Hans has fixed that in cvs -- maybe Hans'
>patch in v4l-dvb cvs could fix it?  Gene, try installing v4l-dvb cvs
>against 2.6.15-rc2-git6 (or later) and see if that might fix NTSC.
>Somehow, I doubt it -- but it is certainly worth a try.

Like I said, complete instructions please so that we are on the same
page.  I still have the rc2-git6 tree that didn't work, so as my script
does a make clean, it should be easy enough to do with the right
instructions.  Like what dir in the kernel tree am I supposed to be in
when I issue the cvs checkout command etc.

>Regards,
>
>Michael Krufky

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

