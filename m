Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVGNN6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVGNN6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVGNN4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:56:35 -0400
Received: from relay01.pair.com ([209.68.5.15]:47374 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S263033AbVGNN4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:56:02 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42D66EF0.1070408@cybsft.com>
Date: Thu, 14 Jul 2005 08:56:00 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karsten Wiese <annabellesgarden@yahoo.de>
CC: Ingo Molnar <mingo@elte.hu>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050713103930.GA16776@elte.hu> <42D51EAF.2070603@cybsft.com> <200507141450.42837.annabellesgarden@yahoo.de>
In-Reply-To: <200507141450.42837.annabellesgarden@yahoo.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese wrote:
> Am Mittwoch, 13. Juli 2005 16:01 schrieb K.R. Foley:
> 
>>Ingo Molnar wrote:
>>
>>>* Chuck Harding <charding@llnl.gov> wrote:
>>>
>>>
>>>
>>>>>CC [M]  sound/oss/emu10k1/midi.o
>>>>>sound/oss/emu10k1/midi.c:48: error: syntax error before '__attribute__'
>>>>>sound/oss/emu10k1/midi.c:48: error: syntax error before ')' token
>>>>>
>>>>>Here's the offending line:
>>>>>
>>>>> 48 static DEFINE_SPINLOCK(midi_spinlock __attribute((unused)));
>>>>>
>>>>>Lee
>>>>>
>>>>
>>>>I got it to compile but it won't boot - it hangs right after the
>>>>'Uncompressing Linux... OK, booting the kernel' - I'm using .config
>>>
>>>>from 51-27 (attached)
>>>
>>>
>>>and -51-27 worked just fine? I've uploaded -29 with the -28 io-apic 
>>>changes undone (will re-apply them once Karsten has figured out what's 
>>>wrong).
>>>
>>>	Ingo
>>
>>I too had the same problem booting -51-28 on my older SMP system at 
>>home. -51-29 just booted fine.
>>
> 
> Have I corrected the other path of ioapic early initialization, which had lacked
> virtual-address setup before ioapic_data[ioapic] was to be filled in -51-28?
> Please test attached patch on top of -51-29 or later.
> Also on Systems that liked -51-28.
> 
>     thanks, Karsten
> 
> 
Karsten,

Just booted on my 2.6 dual Xeon w/HT and thus far all is well. I am 
still building on the older SMP system that didn't like -51-28. Will 
report after I try booting that one.

<snip>

-- 
    kr
