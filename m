Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUGYEhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUGYEhk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 00:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUGYEhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 00:37:39 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:49318 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S263664AbUGYEhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 00:37:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crash(s)?
Date: Sun, 25 Jul 2004 00:37:51 -0400
User-Agent: KMail/1.6
References: <200407242156.40726.gene.heskett@verizon.net> <200407250116.29651.vda@port.imtp.ilyichevsk.odessa.ua> <200407250012.52743.gene.heskett@verizon.net>
In-Reply-To: <200407250012.52743.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407250037.51874.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.55.2] at Sat, 24 Jul 2004 23:37:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 July 2004 00:12, Gene Heskett wrote:
>On Saturday 24 July 2004 18:16, Denis Vlasenko wrote:
>>On Sunday 25 July 2004 04:56, Gene Heskett wrote:
>>> Greetings;
>>>
>>> Machine is a new Biostar M7NCD-Pro mobo, with an athlon
>>> 2800 XP that says its a 2800 in the bootup so it not
>>> overclocked, nor is it too warm, showing 125F right now.
>>> It did take some non-default bios settings to achieve that,
>>> the default running the memory as DDR333, but the cpu as
>>> a 3200+, which understandably didn't always want to post!
>>>
>>> Kernel is 2.6.8-rc2, with the forcedeth driver using the
>>> builtin ethernet on this board.  The mobo has a Gig of ram
>>> which signs on in the bios as
>>> "DDR400 Dual Channel Mode Enabled (etc)"
>>>
[snip crash details]
>>>
>>> This is the only log entries made at what must have been its
>>> untimely demise:
>>> ----------------------
>>> Jul 24 15:37:39 coyote kernel: Unable to handle kernel paging
>>> request at virtual address 5f697461 Jul 24 15:37:39 coyote
>>> kernel: printing eip: Jul 24 15:37:39 coyote kernel: c0164376
>>> Jul 24 15:37:39 coyote kernel: *pde = 00000000
>>> Jul 24 15:37:39 coyote kernel: Oops: 0002 [#1]
>>> Jul 24 15:37:39 coyote kernel: PREEMPT
>>> Jul 24 15:37:39 coyote kernel: Modules linked in: tuner tvaudio
>>> bttv video_buf btcx_risc eeprom snd_seq_oss snd_seq _midi_event
>>> snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0
>>> snd_ac97_codec snd_pcm snd_timer snd_page_allo c snd_mpu401_uart
>>> snd_rawmidi snd_seq_device snd 8139too forcedeth sg Jul 24
>>> 15:37:39 coyote kernel: CPU:    0 Jul 24 15:37:39 coyote kernel:
>>> EIP:    0060:[<c0164376>]    Not tainted Jul 24 21:25:59 coyote
>>> syslogd 1.4.1: restart.
>>> -----------------------
>>> Previously, there was nothing in the logs at all, so this
>>> trail is a first.
>>>
>>> Is there anything of interest here?  What else can I supply
>>> that might help aim a finger at something besides the operator,
>>> who wasn't even in the room at the time :)
>>
>>Not much... at least you can look up that EIP in System.map.
>>Also, do you really need all that sound stuff?
>
>It seems to all come in with the main driver for the ALC650.  And it
>works pretty good once i got it figured out.  Everything but the
>bt878 audio, which is so far down the s/s+n isn't more than 30 db.
>
>>Also, try to slightly underclock your system and see whether
>>that will help.
>>
>>--
>>vda
>
>c0164376 isn't a label, but its in between these two in the
> System.map c0164340 t prune_dcache
>c0164500 T shrink_dcache_sb
>
>But thats all I can deduce from here.
>
>I CC:'d this back to the list in case those two labels might mean
>something to someone else.
>
>Thanks

Update, it looks as if this new mobo is a bit much for the 350 watt 
supply in this case, the +5 volt line is wandering around a couple of 
hundred millivolts, centered on about 4.86 volts.  IMO thats not 
enough, particularly since its wandering around under load.

Would everyone agree?


-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
