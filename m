Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVK2Dgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVK2Dgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 22:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVK2Dgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 22:36:37 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:16227 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932353AbVK2Dgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 22:36:36 -0500
Message-ID: <438BCCF9.1000606@m1k.net>
Date: Mon, 28 Nov 2005 22:37:29 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Don Koch <aardvark@krl.com>, Perry Gilfillan <perrye@linuxmail.org>
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
References: <200511282205.jASM5YUI018061@p-chan.krl.com> <200511281835.56805.gene.heskett@verizon.net> <438BAC38.3070505@m1k.net> <200511282125.52997.gene.heskett@verizon.net>
In-Reply-To: <200511282125.52997.gene.heskett@verizon.net>
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

>On Monday 28 November 2005 20:17, Michael Krufky wrote:
>  
>
>>Gene Heskett wrote:
>>    
>>
>>>Well, based on the note about -rc2-git6 having the v4l stuff reverted,
>>>I just built it.  Same song, same verse.  The tuner acts as if the
>>>antenna has been disconnected and held a fraction of an inch away. 
>>>The video is all digital noise (in VSB), and the audio has a fraction
>>>of a word now and then, buried in white noise.  As my dish receiver
>>>has about a 65,000 u-volt output, I find that sort of signal loss
>>>almost unbelievable.
>>>
>>>It still takes a cold reboot back to 2.6.14.3 or I think any earlier
>>>kernel (that worked ok) in order to restore the cards normal
>>>operation, I'm watching cnn on it right now after having done so.
>>>
>>>So to me, there is little difference between git3 and git6.  Neither
>>>works, failing in the same manner exactly, and matching the
>>>performance of 15-rc2 as issued.  I didn't build -rc1, so I can't say
>>>exactly where the hose got cut.
>>>
>>>I'd suggest just blowing the v4l directory in the -rc2 kernel away,
>>>and replacing it with that from 2.6.14.3 just to get back to a
>>>working sitiuation that you can then start from scratch on.  But
>>>whatdoIknow? :)Gene Heskett <gene.heskett@verizon.net>
>>>      
>>>
>>EEK!  This is not the problem that I'm having at all.....  Then again,
>>I have a different board.
>>
>>Gene, telling someone to revert all the v4l changes in 2.6.15 doesn't
>>help us to fix the actual problem at all, nor will it help them use
>>their hardware.
>>
>>Gene, I believe that I asked you to install the cvs modules against
>>2.6.14, and you told me that doing that works. 
>>    
>>
>No, I never did get it to work Michael, and I believe I said so, mainly
>because it wouldn't even compile.  ISTR I sent a message with the
>compiler exit messages at the time.
>
>Now I'd be willing to try it again, but I'd need exactly the proceedure
>as it would apply to a working 2.6.14.x kernel.  I don't think I did it
>right the last time.  My script, fwiw, renames one generation back so
>that a bad kernel can be reverted easily by renameing the vmlinuz and
>/lib/modules/version-number trees.  Its kind of a swiss army knife in
>that I comment/uncomment stuff in the buildit (thats another script I
>use to apply then patches etc), but the makeit script only needs the
>version number updated to match the Makefile and from there its a 'time
>./makeit' till I'm done editing grub.conf & ready to reboot.  I've taken
>note that the recent makefiles apparently does its own depmod operation
>when doing the modules_install but haven't taken my command out of it
>yet so that gets done twice..
>
>>The code in cvs
>>contains all the patches that we have sent to 2.6.15 and THEN some. 
>>Can you please confirm that installing the cvs modules from v4l-dvb
>>cvs (v4l and dvb have merged cvs repo's) against 2.6.14 is NOT
>>broken??  This would rule out any possibility of the v4l changes in
>>2.6.15 being the cause of your problems.
>>    
>>
>See above.
>
>>It is WELL established that there are memory errors in 2.6.15 
>>(although I thought they were all fixed -- guess not).  I understand
>>that you are using some MakeIt script to build your kernel -- have you
>>tried the standard method?
>>    
>>
>My script does it essentially the same as one would do it by hand.  The
>exception being that I understand the Makefile now has an install target
>for the kernel, but my script does the copying rather than calling that,
>and *I* do the grub.conf editing.
>
>>[...a few minutes go by...]
>>
>>OKAY, I concur -- When I did my testing for 2.6.15-rc2-git6, that was
>>with my saa7134-based card, using nxt200x ... success!
>>
>>However, when I tried using my FusionHDTV3 Gold-T (cx88 card using
>>lgdt3302), neither analog nor digital works in 2.6.15-rc2-git6....
>>Under 2.6.13 (and 2.6.14, i think), however, digital DOES work.  Analog
>>still doesnt work, but i believe that my hardware is damaged.
>>    
>>
>He should do a full shutdown and cold boot to a kernel he knows works,
>and I expect the analog will work again.  Warm reboots DO NOT DO IT!
>
>>SO, looks like we have a regression somewhere in the kernel that breaks
>>the cx88 driver :-(
>>
>>I don't even know where to begin.
>>
>>...One idea... We also know that upstream changes created some compile
>>warnings in tuner-core...  Hans has fixed that in cvs -- maybe Hans'
>>patch in v4l-dvb cvs could fix it?  Gene, try installing v4l-dvb cvs
>>against 2.6.15-rc2-git6 (or later) and see if that might fix NTSC.
>>Somehow, I doubt it -- but it is certainly worth a try.
>>    
>>
>Like I said, complete instructions please so that we are on the same
>page.  I still have the rc2-git6 tree that didn't work, so as my script
>does a make clean, it should be easy enough to do with the right
>instructions.  Like what dir in the kernel tree am I supposed to be in
>when I issue the cvs checkout command etc.
>
Gene-

Let's go a slightly different route... First off, I must say:

I think that I over-reacted in my previous email.  To test, I have 
installed v4l-dvb cvs over kernels 2.6.13, 2.6.14, and 2.6.15-rc2-git6, 
and all three worked fine with my FusionHDTV3 Gold-T in ATSC mode.  It 
was the vanilla 2.6.15-rc2-git6 that didnt work for me.  With the cvs 
modules installed, however, it is working well.

Right now, I am in the process of recompiling my vanilla 2.6.15-rc2-git6 
kernel, to confirm that this actually is a new regression.  If it is in 
fact a regression in 2.6.15, then it is likely to be a v4l regression.  
Luckily, Mauro and I have prepared some patchsets to fix some 2.6.15 
bugs and compile warnings.  It seems that this might be one of the bugs 
that is now fixed in cvs.

Anyhow, would you like to give cvs a whirl under your 2.6.15-rc2-git6 
kernel?

There is a wiki-howto, located at:
http://linuxtv.org/v4lwiki/index.php/How_to_build_from_CVS

... but I will include instructions in this email for your convenience.

Here's how:

1) Please start with vanilla 2.6.15-rc2-git6 ... Have the kernel already 
installed and running.

2) Check-out the newly merged v4l-dvb cvs repository:

   cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux login
   cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux co v4l-dvb

3) Change into the v4l-dvb directory:

   cd v4l-dvb

4) (optional) If you are recompiling the cvs modules against a different 
kernel, clean the tree and kernel version info:

   make distclean

5) Compile the modules:

   make

6) Install them: (as root)

   make install

7) Reboot the machine

Hopefully, this will fix your problem.  Please let me know.

-Michael Krufky
