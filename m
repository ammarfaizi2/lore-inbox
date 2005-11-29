Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVK2BRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVK2BRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVK2BRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:17:18 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:15997 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932314AbVK2BRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:17:17 -0500
Message-ID: <438BAC38.3070505@m1k.net>
Date: Mon, 28 Nov 2005 20:17:44 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Don Koch <aardvark@krl.com>, Perry Gilfillan <perrye@linuxmail.org>,
       Gene Heskett <gene.heskett@verizon.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via tuner
References: <200511282205.jASM5YUI018061@p-chan.krl.com>	<200511282248.jASMm1PC029740@p-chan.krl.com> <438B8C5A.7070002@m1k.net> <200511281835.56805.gene.heskett@verizon.net>
In-Reply-To: <200511281835.56805.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Monday 28 November 2005 18:01, Michael Krufky wrote:
>  
>
>>Perry Gilfillan wrote:
>>    
>>
>>>>Don Koch wrote:
>>>>        
>>>>
>>>>>(Followup to posting on pcHDTV forum.)
>>>>>
>>>>>I recentely purchased a pcHDTV HD3000 card.  Initially I was having
>>>>>problems with NTSC reception in general (via tuner, composite or
>>>>>svideo input), part of which was a problem with the version of
>>>>>linux I was using.  Currently running
>>>>>2.6.15-rc2-g458af543.
>>>>>
>>>>>Symptoms:
>>>>>- ATSC OTA, svideo and composite work.  NTSC tuner does not (tried
>>>>>both OTA and cable).
>>>>>- Xawtv segfaults unless given a specific device (/dev/video0) and
>>>>>then doesn't show anything in any mode including composite and
>>>>>svideo.  This may just be an xawtv problem.
>>>>>- Using tvtime works for composite and svideo, but the tuner
>>>>>doesn't work in either broadcast or cable settings.  Disabling
>>>>>signal detection shows the same "image" for any channel.
>>>>>
>>>>>All the appropriate modules seem to be in place.
>>>>>          
>>>>>
>>>I can report some similar troubles.  It has worked with vanilla
>>>kernel up to 2.6.13 on x86 up untill two weeks ago, when I moved the
>>>card to an amd64 system.
>>>
>>>I'm currently running gentoo-sources-2.6.13 on amd64.  I have not
>>>tried the newly merged tree with this kernel.
>>>
>>>However with gentoo-sources-2.6.14-r2 I tried the newly merged tree,
>>>and do not get NTSC reception.  I have not tried the drivers as
>>>released with 2.6.14 yet, so I'll follow up later on that.
>>>
>>>I'm also having some issues with the VIA Unichrome drivers with
>>>2.6.14, so I may not be able to get far enough to really see whats
>>>happening.
>>>      
>>>
>>I know that this board uses a Thomson DDT 7610 tuner.  I have a
>>FusionHDTV3 Gold-T card that uses Thomson DDT 7611 tuner.  I've seen a
>>copy of the datasheet -- both tuners are the same.
>>
>>Now, here's my story:  My card was working fine for a good long time,
>>but ever since about 2 months ago, the analog tuner no longer works.
>>ONLY the ATSC digital tuner is working.  The tuner does NOT include a
>>tda9887, AFAIK, and I have also tested in windows.  Regardless of
>>whether I am using Linux or Windows, I can only view an ATSC digital
>>stream, NTSC analog no longer works at all.  Both used to work in both
>>OS's.
>>
>>AFAIK, this is a physical hardware problem, and has nothing to do with
>>any bad coding.  For the life of me, I cannot figure out what went
>>wrong.
>>
>>-Mike
>>
>>Maybe Herman, or someone else, might be able to tell us what factors
>>can burn out a hybrid tuner's analog capabilities, and leave digital
>>tuning capabilities intact.
>>
>>Maybe the Thomson DDT 761x tuners are faulty?
>>
>>Can anybody enlighten us?   
>>
>Well, based on the note about -rc2-git6 having the v4l stuff reverted,
>I just built it.  Same song, same verse.  The tuner acts as if the
>antenna has been disconnected and held a fraction of an inch away.  The
>video is all digital noise (in VSB), and the audio has a fraction of a
>word now and then, buried in white noise.  As my dish receiver has
>about a 65,000 u-volt output, I find that sort of signal loss almost
>unbelievable.
>
>It still takes a cold reboot back to 2.6.14.3 or I think any earlier
>kernel (that worked ok) in order to restore the cards normal operation,
>I'm watching cnn on it right now after having done so.
>
>So to me, there is little difference between git3 and git6.  Neither
>works, failing in the same manner exactly, and matching the performance
>of 15-rc2 as issued.  I didn't build -rc1, so I can't say exactly where
>the hose got cut.
>
>I'd suggest just blowing the v4l directory in the -rc2 kernel away, and
>replacing it with that from 2.6.14.3 just to get back to a working
>sitiuation that you can then start from scratch on.  But whatdoIknow? :)Gene Heskett <gene.heskett@verizon.net>
>
EEK!  This is not the problem that I'm having at all.....  Then again, I 
have a different board.

Gene, telling someone to revert all the v4l changes in 2.6.15 doesn't 
help us to fix the actual problem at all, nor will it help them use 
their hardware.

Gene, I believe that I asked you to install the cvs modules against 
2.6.14, and you told me that doing that works.  The code in cvs contains 
all the patches that we have sent to 2.6.15 and THEN some.  Can you 
please confirm that installing the cvs modules from v4l-dvb cvs (v4l and 
dvb have merged cvs repo's) against 2.6.14 is NOT broken??  This would 
rule out any possibility of the v4l changes in 2.6.15 being the cause of 
your problems.

It is WELL established that there are memory errors in 2.6.15  (although 
I thought they were all fixed -- guess not).  I understand that you are 
using some MakeIt script to build your kernel -- have you tried the 
standard method?

[...a few minutes go by...]

OKAY, I concur -- When I did my testing for 2.6.15-rc2-git6, that was 
with my saa7134-based card, using nxt200x ... success!

However, when I tried using my FusionHDTV3 Gold-T (cx88 card using 
lgdt3302), neither analog nor digital works in 2.6.15-rc2-git6....  
Under 2.6.13 (and 2.6.14, i think), however, digital DOES work.  Analog 
still doesnt work, but i believe that my hardware is damaged.

SO, looks like we have a regression somewhere in the kernel that breaks 
the cx88 driver :-(

I don't even know where to begin.


...One idea... We also know that upstream changes created some compile 
warnings in tuner-core...  Hans has fixed that in cvs -- maybe Hans' 
patch in v4l-dvb cvs could fix it?  Gene, try installing v4l-dvb cvs 
against 2.6.15-rc2-git6 (or later) and see if that might fix NTSC.  
Somehow, I doubt it -- but it is certainly worth a try.

Regards,

Michael Krufky
