Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263811AbRFHCrI>; Thu, 7 Jun 2001 22:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263814AbRFHCq7>; Thu, 7 Jun 2001 22:46:59 -0400
Received: from femail4.rdc1.on.home.com ([24.2.9.91]:31442 "EHLO
	femail4.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S263811AbRFHCqo>; Thu, 7 Jun 2001 22:46:44 -0400
Date: Thu, 7 Jun 2001 22:46:37 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: "D. Stimits" <stimits@idcomm.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: missing sysrq
In-Reply-To: <20010601033839Z263340-932+3417@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0106072239570.26171-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Dieter Nützel wrote:

>> > In article <3B15EF16.89B18D@idcomm.com> you wrote:
>> > > However, if I go to /proc/sys/kernel/sysrq does not exist.
>> >
>> > It is a compile time option, so the person who compiled your kernel
>> > left it out.
>>
>> I compiled it, and the sysrq is definitely in the config. No doubt at
>> all. I also use make mrproper and config again before dep and actual
>> compile. Maybe it is just a quirk/oddball.
>>
>> D. Stimits, stimits@idcomm.com
>
>Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
>You need both, compiled in and activation.

If you *know* it is compiled into your kernel, and you *know* it
is enabled via the above, and it still does not work, do the
following:

Run:

showkey -s

Then press LALT quickly followed by SYSRQ, and keep holding both
down, and you should see:

0x38
0x54

You might see a bunch of extra 0x38's which is ok.

If however when you press ALT-SYSRQ you see:

0x38 0x54 0xd4

and are still holding both keys down, then your keyboard is
broken and incompatible with the kernel SYSRQ feature.

A proper keyboard will only show "0x38 0x54".  I have written a
patch for SYSRQ to allow it to be used with broken keyboards that
send the make+break code for the SYSRQ sequence simultaneously.

If you need it, let me know and I'll send it to you.



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Open Source advocate
       Opinions and viewpoints expressed are solely my own.
----------------------------------------------------------------------

