Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWHNQe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWHNQe4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWHNQez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:34:55 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:9692 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751037AbWHNQey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:34:54 -0400
Date: Mon, 14 Aug 2006 12:33:40 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Touchpad problems with latest kernels
In-reply-to: <d120d5000608140853t5a27b522ra7b29aeb0e318efa@mail.gmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <200608141233.41044.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
 <200608141134.32714.gene.heskett@verizon.net>
 <d120d5000608140853t5a27b522ra7b29aeb0e318efa@mail.gmail.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 11:53, Dmitry Torokhov wrote:
>On 8/14/06, Gene Heskett <gene.heskett@verizon.net> wrote:
>> On Monday 14 August 2006 11:13, Dmitry Torokhov wrote:
>> >HI Gene,
>> >
>> >On 8/14/06, Gene Heskett <gene.heskett@verizon.net> wrote:
>> >> I'm having similar problems with an HP Pavilian dv5220, and with a
>> >> bluetooth mouse dongle plugged into the right side usb port it works
>> >> just fine.  What I'd like to do is totally disable that synaptics
>> >> pad as its way too sensitive,
>> >
>> >Are you using synaptics X driver? It can be tweaked to adjust
>> >sensitivity and lots of other things.
>>
>> No, I've tried to totally disable any references to it in the
>> xorg.conf. Unsuccessfully it would appear, even so far as to say no
>> effect from doing so.
>
>Ok, so you are most likely using mousedev emulation mode. Not the best
>choice with ALPS/Synaptics. I recommend usig specialized driver for X
>(see below).
>
>> >> making it impossible to type more than a line or 2
>> >> without the cursor suddenly jumping to someplace else in the
>> >> message, often highliteing several lines of text as it goes, and the
>> >> next keystroke then deletes wholesale quantities of text, thoroughly
>> >> destroying any chance of actually writing a cogent, understandable
>> >> email response to anyone.
>> >
>> >Have you tried synclient utility? It temporarily disables the touchpad
>> >when you start typing and re-enables it when you done.
>>
>> Its not installed that I know of.  Availability?
>
>http://web.telia.com/~u89404340/touchpad/
>It is a part of Synaptics X driver. And I apologize, it is called
>syndaemon, not synclient.
>
>> >> Unforch, my questions along those lines have been treated as the
>> >> ravings of a lunatic and ignored.  The bios has no place to disable
>> >> it, dumbest bios I've seen in quite a while, and it has been updated
>> >> in the last 3 months.
>> >>
>> >> I don't *think* I'm a lunatic, but I'm equally sure that the
>> >> synaptics is a pain in the ass and should be capable of being
>> >> totally disabled somehow, hopefully short of opening the lappy up
>> >> and unplugging or cutting every lead to it until such time as it can
>> >> be made to behave instead of responding to every thumb waved 1/2 to
>> >> 3/4" above it.  I've gotten hand cramps trying to hold my thumbs far
>> >> enough away from that abomination to stop such goings on.
>> >>
>> >> So count this as a vote FOR doing something about the synaptics
>> >> touchpad situation.
>> >
>> >There are ways to disable it:
>> >
>> >echo -n "manual" > /sys/bus/serio/devices/serioX/bind_mode
>>
>> bash: /sys/bus/serio/devices/serioX/bind_mode:  No such file or
>> directory
>>
>> >echo -n "none" > /sys/bus/serio/devices/serioXdrvctl
>>
>> bash: /sys/bus/serio/devices/serioXdvrctl: Permission denied
>>
>> The above is from a root bash shell while X is running the KDE desktop.
>>
>> >This should disable it completely.
>>
>> next step? :)
>
>serioX is the name of serio port your touchpad is connected to
>(serio0, serio1, etc) You will have to look which port is bound to
>psmouse driver.

What if there appear to be two functional mice running the same curser?  
One being the M$ accessory mouse, the other the touchpad.  So I would have 
a serio0 and a serio1.  How do I determine which to feed those commands 
to?  Is the device identified in those info trees?

I've printed this for reference the next time I fire it up, as I'd just now 
shut it off after installing the synaptics driver and a few other updates.

Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
