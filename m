Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUCRTin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUCRTim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:38:42 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:49573 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261875AbUCRTik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:38:40 -0500
Date: Fri, 19 Mar 2004 03:34:44 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: akpm@osdl.org, anton@samba.org, vojtech@suse.cz
Subject: Re: 2.6.x atkbd.c moaning
Cc: "kernel mailing list" <linux-kernel@vger.kernel.org>
References: <opr41z9zel4evsfm@smtp.pacific.net.th> <20040318120114.GN28212@krispykreme> <opr42hoctn4evsfm@smtp.pacific.net.th> <opr42nq0a24evsfm@smtp.pacific.net.th>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr42on6x04evsfm@smtp.pacific.net.th>
In-Reply-To: <opr42nq0a24evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004 03:14:50 +0800, Michael Frank <mhf@linuxmail.org> wrote:

> On Fri, 19 Mar 2004 01:03:38 +0800, Michael Frank <mhf@linuxmail.org> wrote:
>
>> On Thu, 18 Mar 2004 23:01:14 +1100, Anton Blanchard <anton@samba.org> wrote:
>>
>>>
>>>> Why is this and should I investigate further?
>>> ..
>>>
>>>> mice: PS/2 mouse device common for all mice
>>>> serio: i8042 AUX port at 0x60,0x64 irq 12
>>>> input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
>>>> serio: i8042 KBD port at 0x60,0x64 irq 1
>>>> input: AT Translated Set 2 keyboard on isa0060/serio0
>>>> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
>>>
>>> Did this happen recently? If so, does backing out the following patch help?
>>
>> I think so but later than this changeset 1.34 of 19 December.
>
> The Unknown key release msg is introduced in 2.6.1 with i8042 changesets from 1.33 to 1.35
> (likely 1.34 as Anton suggested). Guess i did not think much of it as it was "smaller"
> but "blaming xfree" during boot since 2.6.2 caught my attention.
>
>>
>> The patch has no effect.
>>
>> Also the mouse screws up after a few hours and becomes unusable.
> 	On 2.6.4
>
> On 2.6.[012] the mouse does not sync at all (even after power up).
>
> On 2.4.18-26 mouse never had problems.

Booting 2.6.4 again the mouse does not sync despite OK earlier
until getting out of sync.

Reooting 2.4.24 mouse OK.

Rebooting 2.6.4 again the mouse does not sync.

Weird.

>
>>
>> psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
>> psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
>
> Could also be load dependent. Will do more testing on 2.6.4 to reproduce.
>
> The serious issue with the mouse is that it does not recover and stays
> out of sync and interprets further movement as random coordinates/button clicks.
>
> x2x mouse works.
>
> Regards
> Michael
>
>


