Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRA2SG7>; Mon, 29 Jan 2001 13:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRA2SGl>; Mon, 29 Jan 2001 13:06:41 -0500
Received: from mail.myrealbox.com ([192.108.102.201]:42425 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S129733AbRA2SG2>;
	Mon, 29 Jan 2001 13:06:28 -0500
Message-ID: <01ab01c08a1e$29d1c840$9b2f4189@angelw2k>
From: "Micah Gorrell" <angelcode@myrealbox.com>
To: <root@chaos.analogic.com>, "Craig I. Hagan" <hagan@cih.com>
Cc: "Romain Kang" <romain@kzsu.stanford.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: eepro100 - Linux vs. FreeBSD
Date: Mon, 29 Jan 2001 11:06:11 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in a number of previous messages to this list many people have had
serious problems with the eepro100 driver in 2.4.  These problems where not
there in 2.2 and it is not a select few machines showing this so I very much
doubt that it is a configuration problem.  I assume that the intel driver
would prolly fix all of these issues but its not ready for 2.4 yet and its
not GPL so no one wants to use it.  If there is a good driver that is GPL'ed
lets use it.  I am not up to the task of porting it myself but I would be
glad to help in any way that I can.  I do write code, I'm just not familiar
enough with the linux kernel.

Micah
___
The irony is that Bill Gates claims to be making a stable operating system
and Linus Torvalds claims to be trying to take over the world
-----Original Message-----
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: "Craig I. Hagan" <hagan@cih.com>
Cc: "Romain Kang" <romain@kzsu.stanford.edu>; <linux-kernel@vger.kernel.org>
Date: Monday, January 29, 2001 10:50 AM
Subject: Re: eepro100 - Linux vs. FreeBSD


>On Mon, 29 Jan 2001, Craig I. Hagan wrote:
>
>> > One approach to the endless eepro100 headaches would be to port
>> > the FreeBSD if_fxp driver to Linux.  After all, drivers have been
>> > ported between these OSs before; e.g., the aic7xxx SCSI adapter.
>> > However, I see no evidence that this has been attempted.  Can
>> > someone tell me what I'm obviously missing?
>>
>> Had I my druthers, i'd see the intel e100 driver brought into the kernel.
It
>> seems to work quite well with the eepro100 boards.
>>
>
>Two of my Linux machines use the Intel Ethernet controller on the
>motherboard. These are both SMP machines. I have never, ever, had
>any problems with the eepro100 driver that handles these chips.
>
>I spite of the fact that the driver loops in the ISR, and does other
>things that show poor design, it works so I have not done anything
>to it. "If it ain't broke, don't fix it..."
>
>So, if you have problems with using on-board Intel chip, it's
>unlikely that it's a driver problem. If you have cards on the PCI
>bus, the driver doesn't "know" any difference (PCI is PCI even if
>it's not in a connector). You may find that the problem is caused
>by PCI (mis)configuration since recent kernels use internal PCI
>code. You may find that some bus master device does not have its
>latency set correctly so it's taking over the bus. This can cause
>problems with any high-activity device on the bus, such as a
>network device.
>
>Cheers,
>Dick Johnson
>
>Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).
>
>"Memory is like gasoline. You use it up when you are running. Of
>course you get it all back when you reboot..."; Actual explanation
>obtained from the Micro$oft help desk.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
