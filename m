Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135543AbRDXLJm>; Tue, 24 Apr 2001 07:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135541AbRDXLJc>; Tue, 24 Apr 2001 07:09:32 -0400
Received: from [205.162.53.13] ([205.162.53.13]:14863 "EHLO
	primary.cyberlane.net") by vger.kernel.org with ESMTP
	id <S135543AbRDXLJS>; Tue, 24 Apr 2001 07:09:18 -0400
Date: Tue, 24 Apr 2001 06:02:58 -0500
From: Eugene Kuznetsov <divx@euro.ru>
X-Mailer: The Bat! (v1.47 Halloween Edition) UNREG / CD5BF9353B3B7091
Reply-To: Eugene Kuznetsov <divx@euro.ru>
X-Priority: 3 (Normal)
Message-ID: <92987369.20010424060258@euro.ru>
To: Doug Ledford <dledford@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: Problem with i810_audio driver
In-Reply-To: <3AE4EAEB.254B2A48@redhat.com>
In-Reply-To: <921508308.20010421012021@euro.ru> <3AE4EAEB.254B2A48@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

Monday, April 23, 2001, 9:54:35 PM, you wrote:

DL> Both B and C are cases of the whole chip acting flat busted.  I would suspect
DL> that possibly Win2k drivers set this thing up some way that we don't recover
DL> from.  Is there any pattern like maybe "I listen to X in Win2k then reboot to
DL> linux and sound is screwed" or something like that?  Also, when it does
DL> happen, does shutting down and then actually powering the machine off
DL> (possibly by going so far as to unplug the machine for 5 seconds or so to
DL> overcome any low power state savings on modern motherboards) make it reliably
DL> come back instead of having to reboot multiple times?  Does this ever happen
DL> if you just unload/reload the module without rebooting inbetween (aka, does
DL> the linux driver module sometimes trigger the problem)?

 Here are some more answers.
 1. I tried powering the machine off, unplugging it for several seconds
and then booting into Linux. Two out of three times it came into state B and
one time into state A. Thus, I think that the problem is not caused by
Win2k drivers. Moreover, rebooting into Win2k, playing something with Winamp
( 44k/16/stereo ) and returning into Linux also brought it into state A.
 2. Unloading/reloading driver module does _not_ trigger the problem.
It simply does not affect the condition. I can switch it from state
B to state A by removing i810_audio, inserting ALSA driver for the
chip, immediately removing it and inserting i810_audio back.
 3. Multiple rebooting sometimes ( not always ) switches it from B to
A, but I'm not sure that it can switch it in other direction.

 The whole thing sounds to my mind as having some kind of resource,
register, etc. which is supposed to be initialized during loading of
drivers, but it's not done by i810_audio driver.

-- 
Best regards,
 Eugene
mailto:divx@euro.ru or sparky@projectmayo.com
[Team GADGET]  [Team Two Divided By Zero]  [Team Hackzone.ru]


