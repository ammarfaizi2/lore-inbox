Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267465AbUHPGc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267465AbUHPGc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUHPGc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:32:57 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:27608 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S267465AbUHPGcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:32:54 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Mon, 16 Aug 2004 02:32:52 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408151633.41807.gene.heskett@verizon.net> <200408160803.15206.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408160803.15206.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408160232.52158.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.63.91] at Mon, 16 Aug 2004 01:32:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 August 2004 01:03, Denis Vlasenko wrote:
>On Sunday 15 August 2004 23:33, Gene Heskett wrote:
>> On Sunday 15 August 2004 15:57, Denis Vlasenko wrote:
>> >> And I still don't have any dups, but I AAARRRRGGGGGggg! do have
>> >> this:
>> >>
>> >> --------------
>> >> Aug 15 09:33:02 coyote kernel: Unable to handle kernel paging
>> >> request at virtual address 5f746573 Aug 15 09:33:02 coyote
>> >> kernel: printing eip: Aug 15 09:33:02 coyote kernel: 5f746573
>> >> Aug 15 09:33:02 coyote kernel: *pde = 00000000
>> >> Aug 15 09:33:02 coyote kernel: Oops: 0000 [#1]
>> >> Aug 15 09:33:02 coyote kernel: PREEMPT
>> >
>> >                                 ^^^^^^^
>> >
>> >> Aug 15 09:33:02 coyote kernel: Modules linked in: eeprom
>> >> snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
>> >> snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm
>> >> snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi
>> >> snd_seq_device snd forcedeth
>> >
>> >Gene, you should have stopped using preempt/smp and sound modules
>> >in an attempt to narrow down the bug. We already kinda determined
>> >that you are experiencing random memory corruption, but hardware
>> >was tested and seems to be ok. It's software, then. Preempt/smp
>> > bug or buggy driver are prime suspects.
>>
>> Ok, non-preempt is building.  Will reboot to it when the build is
>> done.
>
>Do not load sound modules too please, unless you absolutely need
> sound.

One thing at a time I think.  Thats major surgery on modprobe.conf to 
disable that, plus a chkconfig alsasound off.

I've noticed that with preempt off, my kde curser motions are back to 
using the mouse if I want to move it more than a word or so to hit a 
typu and fix it.  Its an effect that comes and goes, often in the 
same message reply.  X is running at -1 I think.  Other than that 
(knock on wood) its running ok so far, but only 9h50m uptime.

>> >> I was able to restart the shell, and the top.  The system
>> >> "feels" normal.
>> >>
>> >> I'm going to call tcwo tomorrow and see what I can get in new
>> >> hardware.
>> >
>> >Very likely this won't help.
>>
>> I'm not quite as sure.  This could be a mobo with a flakey buffer
>> latch or something.  I also had, many years ago, a z-80 that would
>
>GCC is likely to sometimes catch sig11 on such flakey hardware.
>You did not report anything like that, than's why I'm thinking
>hardware is ok.
>
>> not reliably switch its foreground/background register set.  And
>> guess what?  By the time I'd diagnosed it, zilog wasn't interested
>> in replaceing an obviously flakey chip.  Out of warranty according
>> to the date stamps.  Not my problem it laid on some distribs shelf
>> for a frigging year plus...
>
>--
>vda

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
