Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKMLwP>; Mon, 13 Nov 2000 06:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQKMLv4>; Mon, 13 Nov 2000 06:51:56 -0500
Received: from linus.st-and.ac.uk ([138.251.32.11]:29085 "EHLO
	linus.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id <S129497AbQKMLvi>; Mon, 13 Nov 2000 06:51:38 -0500
Message-Id: <l03130300b63585c2f42d@[138.251.135.28]>
In-Reply-To: <Pine.LNX.4.21.0011111550130.953-100000@wr5z.localdomain>
In-Reply-To: <3A0DAD50.8C55A494@insignia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 13 Nov 2000 11:51:09 +0000
To: Thomas Molina <tmolina@home.com>
From: Mark Hindley <mh15@st-andrews.ac.uk>
Subject: Re: opl3 under 2.4.0-test10
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sat, 11 Nov 2000, Stephen Thomas wrote:
>
>> Mark Hindley wrote:
>> > I am trying to setup my ALS 110 soundcard under my build of kernel
>> > 2.4.0-test10.
>> >
>> > I have built in isapnp support and also the sb and opl3 drivers.
>> >
>> > However, even though I pass opl3=0x388 on the Kernel command line all
>> > I get is an isapnp panic.
>>
>> CONFIG_SOUND_YM3812=y
>>
>> and I'm passing "opl3=0x388" to the driver.  However, if I query
>> what synth devices the driver supports, it only reports an
>> AWE32-0.4.4 (RAM512k) sample device.  I expect it report an FM synth
>> device, too.  I get the same (lack of) effect if I go via the
>> adlib_card code, by saying "adlib=0x388".  My investigations so
>> far have shown that when opl3_detect() first tries to get the
>> signature of the OPL3 device, it gets 0xff from the inb() (line
>> 195 of drivers/sound/opl3.c in test11pre1), while the corresponding
>> code in 2.2.18pre19 gets 0x00.
>
>Can you try resetting CONFIG_SOUND_YM3812 to m rather than y.  I had a
>similar problem and that is the workaround I came up with.  I haven't
>gone back and tried to see why it happened; maybe I need to.

How does this relate to ALS 110? I have tried building the relevant drivers
both as modules and built-in to the kernel. It seems to make no difference.




Mark Hindley

Director of the Music Centre
University of St Andrews

01334 462226/7

http://www.st-andrews.ac.uk/services/music


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
