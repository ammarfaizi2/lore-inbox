Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266882AbUHOUeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266882AbUHOUeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 16:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUHOUeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 16:34:10 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:184 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266882AbUHOUds
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 16:33:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 15 Aug 2004 16:33:41 -0400
User-Agent: KMail/1.6.82
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408151347.49987.gene.heskett@verizon.net> <200408152257.04773.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408152257.04773.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408151633.41807.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.53.77] at Sun, 15 Aug 2004 15:33:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 15:57, Denis Vlasenko wrote:
>> And I still don't have any dups, but I AAARRRRGGGGGggg! do have
>> this:
>>
>> --------------
>> Aug 15 09:33:02 coyote kernel: Unable to handle kernel paging
>> request at virtual address 5f746573 Aug 15 09:33:02 coyote kernel:
>>  printing eip: Aug 15 09:33:02 coyote kernel: 5f746573
>> Aug 15 09:33:02 coyote kernel: *pde = 00000000
>> Aug 15 09:33:02 coyote kernel: Oops: 0000 [#1]
>> Aug 15 09:33:02 coyote kernel: PREEMPT
>
>                                 ^^^^^^^
>
>> Aug 15 09:33:02 coyote kernel: Modules linked in: eeprom
>> snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss
>> snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
>> snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd
>> forcedeth
>
>Gene, you should have stopped using preempt/smp and sound modules
>in an attempt to narrow down the bug. We already kinda determined
>that you are experiencing random memory corruption, but hardware
>was tested and seems to be ok. It's software, then. Preempt/smp bug
>or buggy driver are prime suspects.

Ok, non-preempt is building.  Will reboot to it when the build is 
done.

>> I was able to restart the shell, and the top.  The system "feels"
>> normal.
>>
>> I'm going to call tcwo tomorrow and see what I can get in new
>> hardware.
>
>Very likely this won't help.

I'm not quite as sure.  This could be a mobo with a flakey buffer 
latch or something.  I also had, many years ago, a z-80 that would 
not reliably switch its foreground/background register set.  And 
guess what?  By the time I'd diagnosed it, zilog wasn't interested in 
replaceing an obviously flakey chip.  Out of warranty according to 
the date stamps.  Not my problem it laid on some distribs shelf for a 
frigging year plus...
>-
>- 
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
