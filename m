Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135306AbRDXKbj>; Tue, 24 Apr 2001 06:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135331AbRDXKba>; Tue, 24 Apr 2001 06:31:30 -0400
Received: from [205.162.53.13] ([205.162.53.13]:8207 "EHLO
	primary.cyberlane.net") by vger.kernel.org with ESMTP
	id <S135325AbRDXKbT>; Tue, 24 Apr 2001 06:31:19 -0400
Date: Tue, 24 Apr 2001 05:24:58 -0500
From: Eugene Kuznetsov <divx@euro.ru>
X-Mailer: The Bat! (v1.47 Halloween Edition) UNREG / CD5BF9353B3B7091
Reply-To: Eugene Kuznetsov <divx@euro.ru>
X-Priority: 3 (Normal)
Message-ID: <1283215844.20010424052458@euro.ru>
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

DL> Eugene Kuznetsov wrote:
>> 
>> Hello,
>> 
>>       I am a happy owner of Intel D815EEA2 mother board. This board
>> comes with integrated AC-97 audio. When I try to load i810_audio
>> driver for it, driver identifies the device as
>> "Intel 810 + AC97 Audio, version 0.02, 19:43:23 Apr 20 2001
>> i810: Intel ICH2 found at IO 0xef00 and 0xe800, IRQ 6
>> ac97_codec: AC97 Audio codec, id: 0x4144:0x5360 (Analog Devices
>> AD1885)"
>> and later brings the system into one of three possible conditions.
>> A) a bit later it says:
>>    i810_audio: 11168 bytes in 50 milliseconds
>>    i810_audio: setting clocking to 41260 to compensate
>> In this case everything is fine ( 16-bit sound is played correctly, I
>> don't need much more ... ).

DL> Write that number down.  You can add it to your /etc/modules.conf file if you
DL> like.  If the new driver sees that the clocking variable has been set to
DL> anything other than 48000 it doesn't run the clocking autodetect routine.

>> B) It says:
>>    i810_audio: 65528 bytes in 50 milliseconds
>>    i810_audio: setting clocking to 7032 to compensate
>> In this case the sound does not work at all - sound card does not
>> produce anything but silence. With versions of kernel up to 2.4.3 I
>> also received a lot of "DMA buffer overrun on send" messages in dmesg
>> when playing anything.
>> C) Last condition is relatively rare. It says something similar to
>> case A, but number of bytes is multiple of 11168 and clocking is lower
>> ( e.g. 13753 = 41260/3 ). Sound card works, but output quality is
>> quite low.
>> Which of cases A)..C) takes place, seems to be random ( I haven't
>> noticed any pattern ). However, attempts to do rmmod/insmod
>> do not have any effect. I have to at least reboot the system a few
>> times to bring the sound to working state.

DL> Both B and C are cases of the whole chip acting flat busted.  I would suspect
DL> that possibly Win2k drivers set this thing up some way that we don't recover
DL> from.  Is there any pattern like maybe "I listen to X in Win2k then reboot to
DL> linux and sound is screwed" or something like that?
DL>   Also, when it does
DL> happen, does shutting down and then actually powering the machine off
DL> (possibly by going so far as to unplug the machine for 5 seconds or so to
DL> overcome any low power state savings on modern motherboards) make it reliably
DL> come back instead of having to reboot multiple times?
DL> Does this ever happen
DL> if you just unload/reload the module without rebooting inbetween (aka, does
DL> the linux driver module sometimes trigger the problem)?

Maybe there is a pattern: I remember that case B occured more
frequently after soft reboot from Win2k. I had case C one time
immediately after turning the computer on and booting directly into
Linux. I will do some more testing about these three
questions and tell you the results later today.

DL>  Finally, when B or C
DL> does happen, can you get the module to work by loading the module with the
DL> clocking= option set to the correct clocking value from A?

No.

I want to tell you that I received an advice from one of list subscribers
and tried installing ALSA drivers for the chip. They work without any
of described problems.

-- 
Best regards,
 Eugene
mailto:divx@euro.ru or sparky@projectmayo.com
[Team GADGET]  [Team Two Divided By Zero]  [Team Hackzone.ru]


